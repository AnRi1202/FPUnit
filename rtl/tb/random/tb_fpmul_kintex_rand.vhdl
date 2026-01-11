library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_fpadd_8_23 is
  generic (
    NUM_RANDOM : positive := 2000;
    MAX_ULP    : natural  := 2;   -- normal結果の許容ULP（まずは 1~2 推奨）
    LATENCY    : natural  := 0;   -- FloPoCoのpipeline depthに合わせる
    CLK_PERIOD : time     := 10 ns
  );
end entity;

architecture tb of tb_fpadd_8_23 is
  component FPAdd_8_23_Freq1_uid2 is
    port (
      clk : in  std_logic;
      X   : in  std_logic_vector(33 downto 0);
      Y   : in  std_logic_vector(33 downto 0);
      R   : out std_logic_vector(33 downto 0)
    );
  end component;

  signal clk   : std_logic := '0';
  signal X_in  : std_logic_vector(33 downto 0) := (others => '0');
  signal Y_in  : std_logic_vector(33 downto 0) := (others => '0');
  signal R_dut : std_logic_vector(33 downto 0);

  -- driver -> scoreboard
  signal exp_in    : std_logic_vector(33 downto 0) := (others => '0');
  signal exp_valid : std_logic := '0';
  signal done      : std_logic := '0';

  -- ===== FloPoCo FP helpers =====
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

  function exn(v : std_logic_vector(33 downto 0)) return std_logic_vector is
  begin
    return v(33 downto 32);
  end function;

  function sgn(v : std_logic_vector(33 downto 0)) return std_logic is
  begin
    return v(31);
  end function;

  function exp_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(30 downto 23)));
  end function;

  function frac_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(22 downto 0)));
  end function;

  -- FloPoCo normal（exn="01"）を real に（subnormal exp=0 も一応対応）
  function fp_to_real(v : std_logic_vector(33 downto 0)) return real is
    variable sign_i : integer := 1;
    variable e      : integer;
    variable frac_i : natural;
    variable mant   : real;
    variable expn   : natural;
  begin
    if v(31) = '1' then sign_i := -1; end if;

    expn   := exp_u(v);
    frac_i := frac_u(v);

    if expn = 0 then
      -- subnormal: value = sign * 2^-126 * (frac/2^23)
      mant := real(frac_i) / real(2**23);
      e    := -126;
      return real(sign_i) * mant * (2.0 ** e);
    else
      mant := 1.0 + real(frac_i) / real(2**23);
      e    := integer(expn) - 127;
      return real(sign_i) * mant * (2.0 ** e);
    end if;
  end function;

  -- real を FloPoCo FP(34bit) に（簡易RN-even相当、subnormalも対応）
  function real_to_fp(x : real) return std_logic_vector is
    variable sign_b   : std_logic := '0';
    variable ax       : real;
    variable mant     : real;
    variable e        : integer := 0;
    variable exp_bits : integer;

    variable frac_real  : real;
    variable frac_floor : integer;
    variable frac_rem   : real;
    variable frac_int   : integer;

    constant FRAC_BITS  : integer := 23;
    constant FRAC_SCALE : real    := real(2**FRAC_BITS);
    constant EPS        : real    := 1.0e-12;

    -- subnormal用
    variable scaled : real;
    variable sub_i  : integer;
  begin
    if x = 0.0 then
      return pack_fp("00", '0', 0, 0); -- +0 を返す（符号付き0が必要なら呼び出し側で処理）
    end if;

    if x < 0.0 then
      sign_b := '1';
      ax := -x;
    else
      sign_b := '0';
      ax := x;
    end if;

    -- 正規化 mant in [1,2)
    mant := ax;
    while mant >= 2.0 loop
      mant := mant / 2.0;
      e := e + 1;
    end loop;
    while mant < 1.0 loop
      mant := mant * 2.0;
      e := e - 1;
    end loop;

    exp_bits := e + 127;

    if exp_bits >= 255 then
      return pack_fp("10", sign_b, 0, 0); -- inf
    elsif exp_bits <= 0 then
      -- subnormal: value = 2^-126 * (frac/2^23)
      -- frac ~= ax * 2^(126+23) = ax * 2^149
      scaled := ax * (2.0 ** 149);

      -- round-to-nearest ties-to-even 近似
      sub_i := integer(scaled);
      frac_rem := scaled - real(sub_i);
      if frac_rem > 0.5 + EPS then
        sub_i := sub_i + 1;
      elsif frac_rem < 0.5 - EPS then
        null;
      else
        if (sub_i mod 2) = 1 then
          sub_i := sub_i + 1;
        end if;
      end if;

      if sub_i <= 0 then
        return pack_fp("00", sign_b, 0, 0); -- underflow to signed zero（符号は保持）
      elsif sub_i >= (2**23) then
        -- subnormal域を越える場合は最小normalに寄せる
        return pack_fp("01", sign_b, 1, 0);
      else
        return pack_fp("01", sign_b, 0, sub_i); -- exp=0 を subnormal として使う
      end if;
    end if;

    -- normal frac
    frac_real  := (mant - 1.0) * FRAC_SCALE;
    frac_floor := integer(frac_real);
    frac_rem   := frac_real - real(frac_floor);

    -- round-to-nearest ties-to-even 近似
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

    -- carry out
    if frac_int = (2**FRAC_BITS) then
      frac_int := 0;
      exp_bits := exp_bits + 1;
      if exp_bits >= 255 then
        return pack_fp("10", sign_b, 0, 0); -- inf
      end if;
    end if;

    return pack_fp("01", sign_b, exp_bits, frac_int);
  end function;

  -- 特殊値込みの参照モデル（FloPoCoの挙動に寄せる）
  function add_expected(a, b : std_logic_vector(33 downto 0)) return std_logic_vector is
    variable ax_exn : std_logic_vector(1 downto 0);
    variable bx_exn : std_logic_vector(1 downto 0);
    variable ax_s   : std_logic;
    variable bx_s   : std_logic;

    variable ar : real;
    variable br : real;
    variable cr : real;

    -- 0の符号規約（FloPoCo実装に合わせる）
    function zero_sign(sa, sb : std_logic) return std_logic is
    begin
      -- -0 + -0 => -0、それ以外は +0
      if sa='1' and sb='1' then return '1'; else return '0'; end if;
    end function;

  begin
    ax_exn := exn(a);  bx_exn := exn(b);
    ax_s   := sgn(a);  bx_s   := sgn(b);

    -- NaN があれば NaN
    if ax_exn="11" or bx_exn="11" then
      return pack_fp("11",'0',0,1);
    end if;

    -- inf
    if ax_exn="10" and bx_exn="10" then
      if ax_s /= bx_s then
        return pack_fp("11",'0',0,1); -- +inf + -inf => NaN
      else
        return pack_fp("10", ax_s, 0, 0);
      end if;
    elsif ax_exn="10" then
      return pack_fp("10", ax_s, 0, 0);
    elsif bx_exn="10" then
      return pack_fp("10", bx_s, 0, 0);
    end if;

    -- zeros
    if ax_exn="00" and bx_exn="00" then
      return pack_fp("00", zero_sign(ax_s, bx_s), 0, 0);
    elsif ax_exn="00" and bx_exn="01" then
      return b; -- 0 + normal = normal（符号含む）
    elsif ax_exn="01" and bx_exn="00" then
      return a;
    end if;

    -- normal + normal（subnormal exp=0 も fp_to_real が一応扱う）
    ar := fp_to_real(a);
    br := fp_to_real(b);
    cr := ar + br;

    if cr = 0.0 then
      -- cancellation は +0 に寄せる（FPAdd内部も cancellation時 sign を 0 に倒す）
      return pack_fp("00",'0',0,0);
    end if;

    return real_to_fp(cr);
  end function;

  -- ULP比較用：IEEE32相当( sign|exp|frac ) を ordered int に変換
  function ordered_ieee32(v : std_logic_vector(33 downto 0)) return unsigned is
    variable bits : unsigned(31 downto 0);
    variable ord  : unsigned(31 downto 0);
  begin
    bits := unsigned(v(31 downto 0));
    if v(31) = '1' then
      ord := not bits;
    else
      ord := bits xor x"80000000";
    end if;
    return ord;
  end function;

  function ulp_diff_u(a, b : std_logic_vector(33 downto 0)) return unsigned is
    variable oa : unsigned(31 downto 0);
    variable ob : unsigned(31 downto 0);
  begin
    oa := ordered_ieee32(a);
    ob := ordered_ieee32(b);
    if oa >= ob then
      return oa - ob;
    else
      return ob - oa;
    end if;
  end function;

  procedure check_result(act, exp : std_logic_vector(33 downto 0); tag : string) is
    variable d : unsigned(31 downto 0);
  begin
    -- NaN: exn だけチェック（payload/符号は don't care とする）
    if exn(exp) = "11" then
      if exn(act) /= "11" then
        assert false report "FAIL(NaN) " & tag severity error;
      end if;
      return;
    end if;

    -- inf/zero: exn と sign をチェック（exp/fracは don't care）
    if exn(exp) = "10" then
      if exn(act) /= "10" or sgn(act) /= sgn(exp) then
        assert false report "FAIL(Inf) " & tag severity error;
      end if;
      return;
    end if;

    if exn(exp) = "00" then
      if exn(act) /= "00" or sgn(act) /= sgn(exp) then
        assert false report "FAIL(Zero) " & tag severity error;
      end if;
      return;
    end if;

    -- normal: exn/sign一致 + ULP
    if exn(act) /= "01" then
      assert false report "FAIL(normal exn) " & tag severity error;
      return;
    end if;

    if sgn(act) /= sgn(exp) then
      assert false report "FAIL(normal sign) " & tag severity error;
      return;
    end if;

    d := ulp_diff_u(act, exp);
    if d > to_unsigned(MAX_ULP, 32) then
      assert false report "FAIL(normal ulp) " & tag severity error;
    end if;
  end procedure;

  -- scoreboard arrays
type slv_arr is array (natural range <>) of std_logic_vector(33 downto 0);
  type sl_arr  is array (natural range <>) of std_logic;

  p_scoreboard: process
    variable exp_q : slv_arr(0 to LATENCY);
    variable val_q : sl_arr (0 to LATENCY);
    variable cyc   : natural := 0;
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
        check_result(R, exp_q(LATENCY), "cycle=" & integer'image(integer(cyc)));
      end if;

      exit when done = '1';
      wait until rising_edge(clk);
    end loop;

    report "TB done." severity note;
    wait;
  end process;

begin
  uut: FPAdd_8_23_Freq1_uid2
    port map (
      clk => clk,
      X   => X_in,
      Y   => Y_in,
      R   => R_dut
    );

  -- clock
  p_clk: process
  begin
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;
  end process;

  -- scoreboard: compare after LATENCY cycles
  p_scoreboard: process
    variable cyc : natural := 0;
  begin
    wait until rising_edge(clk);
    cyc := cyc + 1;

    if val_pipe(LATENCY) = '1' then
      check_result(R_dut, exp_pipe(LATENCY), "cycle=" & integer'image(integer(cyc)));
    end if;

    for k in LATENCY downto 1 loop
      exp_pipe(k) <= exp_pipe(k-1);
      val_pipe(k) <= val_pipe(k-1);
    end loop;

    exp_pipe(0) <= exp_in;
    val_pipe(0) <= exp_valid;

    if done = '1' then
      report "TB done." severity note;
      wait;
    end if;
  end process;

  -- driver: directed + random
  p_driver: process
    variable seed1  : positive := 13579;
    variable seed2  : positive := 24680;
    variable u      : real;

    variable vx     : std_logic_vector(33 downto 0);
    variable vy     : std_logic_vector(33 downto 0);
    variable ve     : std_logic_vector(33 downto 0);

    variable e_rand : natural;
    variable f_rand : natural;
    variable s_rand : std_logic;

    procedure drive_one(ax, by : std_logic_vector(33 downto 0)) is
    begin
      ve := add_expected(ax, by);

      X_in      <= ax;
      Y_in      <= by;
      exp_in    <= ve;
      exp_valid <= '1';

      -- 入力は rising edge 前に安定させたいので、falling->rising を使う
      wait until rising_edge(clk);
      wait until falling_edge(clk);
    end procedure;

  begin
    exp_valid <= '0';
    done      <= '0';
    wait for 20 ns;
    wait until falling_edge(clk);

    -- ===== directed specials =====
    drive_one(pack_fp("00",'0',0,0), pack_fp("00",'0',0,0)); -- +0 + +0 = +0
    drive_one(pack_fp("00",'1',0,0), pack_fp("00",'1',0,0)); -- -0 + -0 = -0
    drive_one(pack_fp("00",'1',0,0), pack_fp("00",'0',0,0)); -- -0 + +0 = +0 (FloPoCoも+0に倒す)
    drive_one(pack_fp("10",'0',0,0), pack_fp("01",'0',127,0)); -- +inf + 1.0 = +inf
    drive_one(pack_fp("10",'0',0,0), pack_fp("10",'1',0,0));   -- +inf + -inf = NaN
    drive_one(pack_fp("11",'0',0,1), pack_fp("01",'0',127,0)); -- NaN + 1.0 = NaN

    -- cancellation（+1.0 + -1.0 = +0 を期待）
    drive_one(pack_fp("01",'0',127,0), pack_fp("01",'1',127,0));

    -- ===== random mix =====
    for i in 1 to NUM_RANDOM loop
      uniform(seed1, seed2, u);

      if u < 0.02 then
        vx := pack_fp("00",'0',0,0);
        vy := pack_fp("00",'1',0,0);
      elsif u < 0.04 then
        vx := pack_fp("10",'0',0,0);
        vy := pack_fp("01",'1',140,12345);
      elsif u < 0.06 then
        vx := pack_fp("11",'0',0,1);
        vy := pack_fp("01",'0',150,54321);
      else
        -- normal を生成（極端を避けるため exp を中間域に制限）
        uniform(seed1, seed2, u);
        if u < 0.5 then s_rand := '0'; else s_rand := '1'; end if;

        uniform(seed1, seed2, u);
        e_rand := 20 + natural(integer(u * 200.0)); -- [20..219] くらい

        uniform(seed1, seed2, u);
        f_rand := natural(integer(u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;

        vx := pack_fp("01", s_rand, e_rand, f_rand);

        uniform(seed1, seed2, u);
        if u < 0.5 then s_rand := '0'; else s_rand := '1'; end if;

        uniform(seed1, seed2, u);
        e_rand := 20 + natural(integer(u * 200.0));

        uniform(seed1, seed2, u);
        f_rand := natural(integer(u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;

        vy := pack_fp("01", s_rand, e_rand, f_rand);
      end if;

      drive_one(vx, vy);

      -- commutativity sanity（余裕があれば）
      -- drive_one(vy, vx);

    end loop;

    -- ===== flush =====
    exp_valid <= '0';
    exp_in    <= (others => '0');
    X_in      <= (others => '0');
    Y_in      <= (others => '0');

    for k in 0 to integer(LATENCY)+2 loop
      wait until rising_edge(clk);
    end loop;

    done <= '1';
    wait;
  end process;

end architecture;
