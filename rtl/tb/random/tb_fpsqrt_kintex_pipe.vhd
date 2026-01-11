------- !!!!!!!!!!!!!! not work !!!!!!!!!! ---------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.all;

entity tb_fpsqrt_kintex is
  generic (
    NUM_RANDOM : positive := 1000;
    MAX_ULP    : natural  := 1;   -- normal 比較の許容ULP (0ならビット完全一致)
    LATENCY    : natural  := 0;   -- 出力遅延サイクル数（FloPoCoのpipeline depthに合わせる）
    CLK_PERIOD : time     := 10 ns
  );
end entity;

architecture tb of tb_fpsqrt_kintex is
--  component FPSqrt_8_23 is


  component FPALL_Shared_Wrapper is
    generic (
      OP_CODE_GEN : std_logic_vector(1 downto 0) := "00"
    );
    port (
      clk : in  std_logic;
      X   : in  std_logic_vector(33 downto 0);
      Y   : in  std_logic_vector(33 downto 0);
      R   : out std_logic_vector(33 downto 0)
    );
  end component;

  signal clk : std_logic := '0';
  signal X   : std_logic_vector(33 downto 0) := (others => '0');
  signal R   : std_logic_vector(33 downto 0);

  -- ドライバが提示する「今回投入した入力に対する期待値」
  signal exp_in    : std_logic_vector(33 downto 0) := (others => '0');
  signal exp_valid : std_logic := '0';
  signal done      : std_logic := '0';

  -- ========== FloPoCo FP helpers ==========
  -- layout: [33:32]=exn, [31]=sign, [30:23]=exp, [22:0]=frac

  function pack_fp(exn : std_logic_vector(1 downto 0);
                   sign: std_logic;
                   exp : natural;
                   frac: natural) return std_logic_vector is
    variable v : std_logic_vector(33 downto 0);
  begin
    v(33 downto 32) := exn;
    v(31)           := sign;
    v(30 downto 23) := std_logic_vector(to_unsigned(exp, 8));
    v(22 downto 0)  := std_logic_vector(to_unsigned(frac, 23));
    return v;
  end function;

  function ulp_diff(a, b : std_logic_vector(33 downto 0)) return natural is
    variable ai : integer;
    variable bi : integer;
    variable d  : integer;
  begin
    ai := to_integer(unsigned(a(30 downto 0)));
    bi := to_integer(unsigned(b(30 downto 0)));
    d := ai - bi;
    if d < 0 then d := -d; end if;
    return natural(d);
  end function;

  function exp_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(30 downto 23)));
  end function;

  function frac_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(22 downto 0)));
  end function;

  -- normal/subnormal を real に（参照モデル用）
  function fp_to_real(v : std_logic_vector(33 downto 0)) return real is
    variable sign_i : integer := 1;
    variable e      : integer;
    variable frac   : natural;
    variable mant   : real;
    variable expn   : natural;
  begin
    if v(31) = '1' then sign_i := -1; end if;

    expn := exp_u(v);
    frac := frac_u(v);

    if expn = 0 then
      -- subnormal（必要なら精密化可）
      mant := real(frac) / real(2**23);
      e    := -126;
      return real(sign_i) * mant * (2.0 ** e);
    else
      mant := 1.0 + real(frac) / real(2**23);
      e    := integer(expn) - 127;
      return real(sign_i) * mant * (2.0 ** e);
    end if;
  end function;

  -- real(>=0) を float32(normal想定) へ丸めて pack（簡易参照）
  function real_to_fp_normal(x : real) return std_logic_vector is
    variable mant : real := x;
    variable e    : integer := 0;
    variable frac_real : real;
    variable frac_floor: integer;
    variable frac_rem       : real;
    variable frac_int  : integer;
    variable exp_bits  : integer;
    constant FRAC_BITS : integer := 23;
    constant FRAC_SCALE: real := real(2**FRAC_BITS);
    constant EPS       : real := 1.0e-12;
  begin
    if x = 0.0 then
      return pack_fp("00", '0', 0, 0);
    end if;

    while mant >= 2.0 loop
      mant := mant / 2.0;
      e := e + 1;
    end loop;
    while mant < 1.0 loop
      mant := mant * 2.0;
      e := e - 1;
    end loop;

    frac_real  := (mant - 1.0) * FRAC_SCALE;
    frac_floor := integer(frac_real);
    frac_rem        := frac_real - real(frac_floor);

    -- round-to-nearest, ties-to-even 近似
    if frac_rem > 0.5 + EPS then
      frac_int := frac_floor + 1;
    elsif frac_rem < 0.5 - EPS then
      frac_int := frac_floor;
    else
      if (frac_floor mod 2) = 1 then
        frac_int := frac_floor + 1;
      else
        frac_int := frac_floor;
      end if;
    end if;

    if frac_int = (2**FRAC_BITS) then
      frac_int := 0;
      e := e + 1;
    end if;

    exp_bits := e + 127;

    if exp_bits >= 255 then
      return pack_fp("10", '0', 0, 0); -- +inf
    elsif exp_bits <= 0 then
      return pack_fp("00", '0', 0, 0); -- underflowは0扱い（必要なら拡張）
    else
      return pack_fp("01", '0', exp_bits, frac_int);
    end if;
  end function;

  -- DUT仕様に合わせた期待値（special優先）
  function sqrt_expected(v : std_logic_vector(33 downto 0)) return std_logic_vector is
    variable exn  : std_logic_vector(1 downto 0);
    variable sign : std_logic;
    variable xr   : real;
    variable yr   : real;
  begin
    exn  := v(33 downto 32);
    sign := v(31);

    if exn = "00" then
      return pack_fp("00", sign, 0, 0);     -- ±0 は符号維持
    elsif exn = "10" then
      if sign = '0' then
        return pack_fp("10", '0', 0, 0);    -- +inf
      else
        return pack_fp("11", '0', 0, 1);    -- -inf は NaN
      end if;
    elsif exn = "11" then
      return pack_fp("11", '0', 0, 1);      -- NaN は NaN
    else
      if sign = '1' then
        return pack_fp("11", '0', 0, 1);    -- negative finite => NaN
      else
        xr := fp_to_real(v);
        yr := sqrt(xr);
        return real_to_fp_normal(yr);
      end if;
    end if;
  end function;

  -- 比較：specialは xs(exn+sign) だけ、normalはULP
  procedure check_result(r_act : std_logic_vector(33 downto 0);
                         r_exp : std_logic_vector(33 downto 0);
                         tag   : string;
                         pass_cnt : inout natural;
                         fail_cnt : inout natural) is
    variable d : natural;
  begin
    if r_exp(33 downto 32) /= "01" then
      -- special: xs= [exn(2)+sign] のみチェック（exp/fracはdon't care）
      if r_act(33 downto 31) /= r_exp(33 downto 31) then
        assert false report "FAIL(special) " & tag severity error;
        fail_cnt := fail_cnt + 1;
      else
        pass_cnt := pass_cnt + 1;
      end if;
    else
      -- normal
      if r_act(33 downto 31) /= "010" then
        assert false report "FAIL(normal xs) " & tag severity error;
        fail_cnt := fail_cnt + 1;
      else
        d := ulp_diff(r_act, r_exp);
        if d > MAX_ULP then
          assert false report "FAIL(normal ulp=" & integer'image(integer(d)) & ") " & tag severity error;
          fail_cnt := fail_cnt + 1;
        else
          pass_cnt := pass_cnt + 1;
        end if;
      end if;
    end if;
  end procedure;

  -- スコアボード用配列型
  type slv_arr is array (natural range <>) of std_logic_vector(33 downto 0); -- std_logic_vector = slv
  type sl_arr  is array (natural range <>) of std_logic; -- std_logc = sl




begin
--  uut: FPSqrt_8_23
--    port map (
--      clk => clk,
--      X   => X,
--      R   => R
--    );

  uut: FPALL_Shared_Wrapper
    generic map (
      OP_CODE_GEN => "10"
    )
    port map (
      clk => clk,
      X   => X,
      Y   => (others => '0'),
      R   => R
    );

  -- clock
  p_clk: process
  begin
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;
  end process;

  -- ========== Scoreboard: pipeline latency を吸収して比較 ==========
  p_scoreboard: process
    variable exp_q : slv_arr(0 to LATENCY);
    variable val_q : sl_arr (0 to LATENCY);
    variable cyc   : natural := 0;
    variable pass_cnt : natural := 0;
    variable fail_cnt : natural := 0;
  begin
    -- 初期化
    for k in 0 to LATENCY loop
      exp_q(k) := (others => '0');
      val_q(k) := '0';
    end loop;

    wait until rising_edge(clk);
    loop
      cyc := cyc + 1;

      -- 1) まずシフト（古いものが後段へ）
      for k in LATENCY downto 1 loop
        exp_q(k) := exp_q(k-1);
        val_q(k) := val_q(k-1);
      end loop;

      -- 2) そのサイクルの期待値を stage0 に投入
      exp_q(0) := exp_in;
      val_q(0) := exp_valid;

      -- 3) 投入後のキューで比較（LATENCY=0でも正しい）
      if val_q(LATENCY) = '1' then
        check_result(R, exp_q(LATENCY), "cycle=" & integer'image(integer(cyc)), pass_cnt, fail_cnt);
      end if;

      exit when done = '1';
      wait until rising_edge(clk);
    end loop;

    report "TB done. pass=" & integer'image(pass_cnt) & " fail=" & integer'image(fail_cnt) severity note;
    finish;
  end process;

  -- ========== Driver: 入力生成（directed + random） ==========
  p_driver: process
    variable seed1 : positive := 13579;
    variable seed2 : positive := 24680;
    variable rand_u     : real;

    variable v_in  : std_logic_vector(33 downto 0);
    variable v_exp : std_logic_vector(33 downto 0);

    variable e_rand : natural;
    variable f_rand : natural;

    procedure drive_one(v : std_logic_vector(33 downto 0)) is
      variable e : std_logic_vector(33 downto 0);
    begin
      e := sqrt_expected(v);

      -- rising edge の前に安定させる
      X         <= v;
      exp_in    <= e;
      exp_valid <= '1';

      wait until rising_edge(clk);
      -- ここでは比較しない：比較は scoreboard が LATENCY を見て行う
    end procedure;

  begin
    -- 初期化
    exp_valid <= '0';
    done      <= '0';
    wait for 20 ns;

    -- クロック位相を合わせる（以後、rising前にXを入れたい）
    wait until falling_edge(clk);

    -- -------- directed --------
    drive_one(pack_fp("00",'0',0,0));         -- +0
    drive_one(pack_fp("00",'1',0,0));         -- -0
    drive_one(pack_fp("10",'0',0,0));         -- +inf
    drive_one(pack_fp("10",'1',0,0));         -- -inf -> NaN
    drive_one(pack_fp("11",'0',0,1));         -- NaN
    drive_one(pack_fp("01",'1',127,0));       -- -1.0 -> NaN
    drive_one(pack_fp("01",'0',127,0));       -- 1.0
    drive_one(pack_fp("01",'0',129,0));       -- 4.0
    drive_one(pack_fp("01",'0',125,0));       -- 0.25

    -- -------- random --------
    for i in 1 to NUM_RANDOM loop
      uniform(seed1, seed2, rand_u);

      if rand_u < 0.02 then
        v_in := pack_fp("00",'0',0,0); -- +0
      elsif rand_u < 0.04 then
        v_in := pack_fp("00",'1',0,0); -- -0
      elsif rand_u < 0.06 then
        v_in := pack_fp("10",'0',0,0); -- +inf
      elsif rand_u < 0.08 then
        v_in := pack_fp("11",'0',0,1); -- NaN
      elsif rand_u < 0.10 then
        -- negative normal
        uniform(seed1, seed2, rand_u); e_rand := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); f_rand := natural(integer(rand_u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;
        v_in := pack_fp("01",'1', e_rand, f_rand);
      else
        -- positive normal
        uniform(seed1, seed2, rand_u); e_rand := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); f_rand := natural(integer(rand_u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;
        v_in := pack_fp("01",'0', e_rand, f_rand);
      end if;

      drive_one(v_in);
      wait until falling_edge(clk);
    end loop;

    -- -------- flush: パイプラインを空にする --------
    exp_valid <= '0';
    exp_in    <= (others => '0');
    X         <= (others => '0');

    -- LATENCY+2 サイクルほど回せば、最後の期待値が比較され尽くす
    for k in 0 to integer(LATENCY)+2 loop
      wait until rising_edge(clk);
    end loop;

    done <= '1';
    wait;
  end process;


  
end architecture;
