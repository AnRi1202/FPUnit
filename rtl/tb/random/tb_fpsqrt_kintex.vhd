library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_fpsqrt_kintex is
  generic (
    NUM_RANDOM : positive := 1000;
    MAX_ULP    : natural  := 1;
    CLK_PERIOD : time     := 10 ns
  );
end entity;

architecture tb of tb_fpsqrt_kintex is
  component FPSqrt_8_23 is
    port (
      clk : in  std_logic;
      X   : in  std_logic_vector(33 downto 0);
      R   : out std_logic_vector(33 downto 0)
    );
  end component;

  signal clk : std_logic := '0';
  signal X   : std_logic_vector(33 downto 0) := (others => '0');
  signal R   : std_logic_vector(33 downto 0);

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

  function xs(v : std_logic_vector(33 downto 0)) return std_logic_vector is
  begin
    return v(33 downto 31); -- exn(2) & sign
  end function;

  function exp_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(30 downto 23)));
  end function;

  function frac_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(22 downto 0)));
  end function;

  function is_normal(v : std_logic_vector(33 downto 0)) return boolean is
  begin
    return v(33 downto 32) = "01";
  end function;

  function is_zero(v : std_logic_vector(33 downto 0)) return boolean is
  begin
    return v(33 downto 32) = "00";
  end function;

  function is_inf(v : std_logic_vector(33 downto 0)) return boolean is
  begin
    return v(33 downto 32) = "10";
  end function;

  function is_nan(v : std_logic_vector(33 downto 0)) return boolean is
  begin
    return v(33 downto 32) = "11";
  end function;

  -- normal/subnormal を real に変換（TB側参照用）
  function fp_to_real(v : std_logic_vector(33 downto 0)) return real is
    variable sign   : integer := 1;
    variable e      : integer;
    variable frac   : natural;
    variable mant   : real;
    variable expn   : natural;
  begin
    if v(31) = '1' then
      sign := -1;
    end if;

    expn := exp_u(v);
    frac := frac_u(v);

    if expn = 0 then
      -- subnormal 
      mant := real(frac) / real(2**23);
      e    := -126;
      return real(sign) * mant * (2.0 ** e);
    else
      mant := 1.0 + real(frac) / real(2**23);
      e    := integer(expn) - 127;
      return real(sign) * mant * (2.0 ** e);
    end if;
  end function;

  -- real(>=0) を float32(exp+frac) に丸めて pack（最小限の参照モデル）
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
    constant EPS       : real := 1.0e-12; -- tie 判定用の緩い許容
  begin
    if x = 0.0 then
      return pack_fp("00", '0', 0, 0);
    end if;

    -- mant を [1,2) に正規化して e を得る（logを使わずループ）
    while mant >= 2.0 loop
      mant := mant / 2.0;
      e := e + 1;
    end loop;
    while mant < 1.0 loop
      mant := mant * 2.0;
      e := e - 1;
    end loop;

    frac_real  := (mant - 1.0) * FRAC_SCALE;
    frac_floor := integer(frac_real); -- frac_real>=0 なので trunc= floor
    frac_rem        := frac_real - real(frac_floor);

    -- round-to-nearest (ties-to-even 近似)
    if frac_rem > 0.5 + EPS then
      frac_int := frac_floor + 1;
    elsif frac_rem < 0.5 - EPS then
      frac_int := frac_floor;
    else
      -- tie: even
      if (frac_floor mod 2) = 1 then
        frac_int := frac_floor + 1;
      else
        frac_int := frac_floor;
      end if;
    end if;

    -- 繰り上がりで mant=2.0 相当になったら exponent を +1
    if frac_int = (2**FRAC_BITS) then
      frac_int := 0;
      e := e + 1;
    end if;

    exp_bits := e + 127;

    if exp_bits >= 255 then
      return pack_fp("10", '0', 0, 0); -- +inf
    elsif exp_bits <= 0 then
      -- subnormal/underflow は今回は 0 扱い（必要なら拡張）
      return pack_fp("00", '0', 0, 0);
    else
      return pack_fp("01", '0', exp_bits, frac_int);
    end if;
  end function;

  -- 入力 v に対する期待出力（FloPoCo 例外仕様に合わせる）
  function sqrt_expected(v : std_logic_vector(33 downto 0)) return std_logic_vector is
    variable exn  : std_logic_vector(1 downto 0);
    variable sign : std_logic;
    variable xr   : real;
    variable yr   : real;
  begin
    exn  := v(33 downto 32);
    sign := v(31);

    if exn = "00" then
      -- +0/-0 は符号維持
      return pack_fp("00", sign, 0, 0);

    elsif exn = "10" then
      -- inf
      if sign = '0' then
        return pack_fp("10", '0', 0, 0); -- +inf
      else
        return pack_fp("11", '0', 0, 1); -- NaN
      end if;

    elsif exn = "11" then
      -- NaN 入力は NaN
      return pack_fp("11", '0', 0, 1);

    else
      -- normal
      if sign = '1' then
        -- negative finite => NaN（-0 は exn=00 で既に処理）
        return pack_fp("11", '0', 0, 1);
      else
        xr := fp_to_real(v);
        yr := sqrt(xr);
        return real_to_fp_normal(yr);
      end if;
    end if;
  end function;

  function ulp_diff(a, b : std_logic_vector(33 downto 0)) return natural is
    variable ai : integer;
    variable bi : integer;
    variable d  : integer;
  begin
    -- normal のときのみ使う想定：符号なしで単調（exp+frac 31bit）
    ai := to_integer(unsigned(a(30 downto 0)));
    bi := to_integer(unsigned(b(30 downto 0)));
    d := ai - bi;
    if d < 0 then d := -d; end if;
    return natural(d);
  end function;

begin
  uut: FPSqrt_8_23
    port map (
      clk => clk,
      X   => X,
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

  -- stimulus + check
  p_test: process
    variable seed1 : positive := 13579;
    variable seed2 : positive := 24680;
    variable rand_u: real;

    variable v_in  : std_logic_vector(33 downto 0);
    variable v_exp : std_logic_vector(33 downto 0);

    variable exp_e : natural;
    variable exp_f : natural;

    variable pass_cnt : natural := 0;
    variable fail_cnt : natural := 0;

    procedure apply_and_check(v : std_logic_vector(33 downto 0); name : string) is
      variable e : std_logic_vector(33 downto 0);
      variable d : natural;
    begin
      X <= v;
      wait for 1 ns; -- combinational DUT 想定（pipeline depth 0）

      e := sqrt_expected(v);

      -- special は xs のみ見る（exp/frac は don't care）
      if e(33 downto 32) /= "01" then
        if R(33 downto 31) /= e(33 downto 31) then
          assert false report "FAIL(special) " & name severity error;
          fail_cnt := fail_cnt + 1;
        else
          pass_cnt := pass_cnt + 1;
        end if;
      else
        -- normal: xs は必ず "010" のはず
        if R(33 downto 31) /= "010" then
          assert false report "FAIL(normal xs) " & name severity error;
          fail_cnt := fail_cnt + 1;
        else
          d := ulp_diff(R, e);
          if d > MAX_ULP then
            assert false report "FAIL(normal ulp=" & integer'image(integer(d)) & ") " & name severity error;
            fail_cnt := fail_cnt + 1;
          else
            pass_cnt := pass_cnt + 1;
          end if;
        end if;
      end if;
    end procedure;

  begin
    wait for 20 ns;

    -- ===== Directed / corner cases =====
    apply_and_check(pack_fp("00",'0',0,0), "+0");
    apply_and_check(pack_fp("00",'1',0,0), "-0");
    apply_and_check(pack_fp("10",'0',0,0), "+inf");
    apply_and_check(pack_fp("10",'1',0,0), "-inf -> NaN");
    apply_and_check(pack_fp("11",'0',0,1), "NaN payload");
    -- negative normal（例: -1.0）
    apply_and_check(pack_fp("01",'1',127,0), "-1.0 -> NaN");

    -- squares: 1.0, 4.0, 0.25
    apply_and_check(pack_fp("01",'0',127,0), "1.0");
    apply_and_check(pack_fp("01",'0',129,0), "4.0");   -- 4.0 = 2^(2) => exp=127+2=129
    apply_and_check(pack_fp("01",'0',125,0), "0.25");  -- 0.25 = 2^(-2) => exp=127-2=125

    -- ===== Random tests (normal + specials mix) =====
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
        -- negative normal を混ぜる
        uniform(seed1, seed2, rand_u); exp_e := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); exp_f := natural(integer(rand_u * real(2**23)));
        if exp_f > (2**23 - 1) then exp_f := 2**23 - 1; end if;
        v_in := pack_fp("01",'1',exp_e,exp_f);
      else
        -- positive normal
        uniform(seed1, seed2, rand_u); exp_e := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); exp_f := natural(integer(rand_u * real(2**23)));
        if exp_f > (2**23 - 1) then exp_f := 2**23 - 1; end if;
        v_in := pack_fp("01",'0',exp_e,exp_f);
      end if;

      apply_and_check(v_in, "rand#" & integer'image(i));
      wait for CLK_PERIOD;
    end loop;

    report "TB done. pass=" & integer'image(integer(pass_cnt)) &
           " fail=" & integer'image(integer(fail_cnt))
           severity note;

    wait;
  end process;

end architecture;
