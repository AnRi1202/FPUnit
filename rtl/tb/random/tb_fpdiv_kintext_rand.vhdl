library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_fpdiv_kintex is
  generic (
    NUM_RANDOM : positive := 2000;
    MAX_ULP    : natural  := 1;    -- normal の許容ULP (0ならビット完全一致)
    LATENCY    : natural  := 0;    -- DUTのパイプライン遅延(サイクル)
    CLK_PERIOD : time     := 10 ns
  );
end entity;

architecture tb of tb_fpdiv_kintex is

  --------------------------------------------------------------------------
  -- DUT
  --------------------------------------------------------------------------
--  component FPDiv_8_23_Freq1_uid2 is
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
  signal Y   : std_logic_vector(33 downto 0) := (others => '0');
  signal R   : std_logic_vector(33 downto 0);

  signal exp_in    : std_logic_vector(33 downto 0) := (others => '0');
  signal exp_valid : std_logic := '0';
  signal done      : std_logic := '0';

  --------------------------------------------------------------------------
  -- Types (必ず architecture の begin より前)
  --------------------------------------------------------------------------
  type slv_arr is array (natural range <>) of std_logic_vector(33 downto 0);
  type sl_arr  is array (natural range <>) of std_logic;

  --------------------------------------------------------------------------
  -- Helpers (FloPoCo FP format)
  -- layout: [33:32]=exn, [31]=sign, [30:23]=exp, [22:0]=frac
  -- exn: "00"=zero, "01"=normal, "10"=inf, "11"=NaN
  --------------------------------------------------------------------------
  function pack_fp(exn  : std_logic_vector(1 downto 0);
                   sign : std_logic;
                   exp  : natural;
                   frac : natural) return std_logic_vector is
    variable v : std_logic_vector(33 downto 0);
  begin
    v(33 downto 32) := exn;
    v(31)           := sign;
    v(30 downto 23) := std_logic_vector(to_unsigned(exp, 8));
    v(22 downto 0)  := std_logic_vector(to_unsigned(frac, 23));
    return v;
  end function;

  function exp_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(30 downto 23)));
  end function;

  function frac_u(v : std_logic_vector(33 downto 0)) return natural is
  begin
    return to_integer(unsigned(v(22 downto 0)));
  end function;

  -- normal を real に（TB参照用）
  function fp_to_real_normal(v : std_logic_vector(33 downto 0)) return real is
    variable sgn : real := 1.0;
    variable e   : integer;
    variable f   : natural;
    variable mant: real;
    variable ex  : natural;
  begin
    if v(31) = '1' then
      sgn := -1.0;
    end if;

    ex := exp_u(v);
    f  := frac_u(v);

    -- TB側では normal入力のみを想定（random生成も 1..254 に制限）
    mant := 1.0 + real(f) / (2.0 ** 23);
    e    := integer(ex) - 127;

    return sgn * mant * (2.0 ** e);
  end function;

  -- real(>=0) を float32(normal想定) に丸め、sign を付与して pack
  function real_to_fp_normal_signed(x_abs : real; sign : std_logic) return std_logic_vector is
    variable mant      : real := x_abs;
    variable e         : integer := 0;
    variable frac_real : real;
    variable frac_floor: integer;
    variable frac_rem_r: real;
    variable frac_int  : integer;
    variable exp_bits  : integer;

    constant FRAC_BITS  : integer := 23;
    constant FRAC_SCALE : real    := 2.0 ** FRAC_BITS;
    constant EPS        : real    := 1.0e-12;
  begin
    if x_abs = 0.0 then
      return pack_fp("00", sign, 0, 0);
    end if;

    -- normalize to [1,2)
    while mant >= 2.0 loop
      mant := mant / 2.0;
      e := e + 1;
    end loop;

    while mant < 1.0 loop
      mant := mant * 2.0;
      e := e - 1;
    end loop;

    frac_real  := (mant - 1.0) * FRAC_SCALE;
    frac_floor := integer(frac_real); -- trunc toward 0 (>=0なのでfloor相当)
    frac_rem_r := frac_real - real(frac_floor);

    -- round-to-nearest, ties-to-even（近似）
    if frac_rem_r > 0.5 + EPS then
      frac_int := frac_floor + 1;
    elsif frac_rem_r < 0.5 - EPS then
      frac_int := frac_floor;
    else
      if (frac_floor mod 2) = 1 then
        frac_int := frac_floor + 1;
      else
        frac_int := frac_floor;
      end if;
    end if;

    if frac_int = integer(2.0 ** FRAC_BITS) then
      frac_int := 0;
      e := e + 1;
    end if;

    exp_bits := e + 127;

    if exp_bits >= 255 then
      return pack_fp("10", sign, 0, 0); -- inf
    elsif exp_bits <= 0 then
      return pack_fp("00", sign, 0, 0); -- underflow -> 0（subnormal未対応の簡易モデル）
    else
      return pack_fp("01", sign, natural(exp_bits), natural(frac_int));
    end if;
  end function;

  -- ULP差（sign/exn一致が前提で、exp+frac を unsigned として距離）
  function ulp_diff(a, b : std_logic_vector(33 downto 0)) return natural is
    variable ai : integer;
    variable bi : integer;
    variable d  : integer;
  begin
    ai := to_integer(unsigned(a(30 downto 0)));
    bi := to_integer(unsigned(b(30 downto 0)));
    d  := ai - bi;
    if d < 0 then d := -d; end if;
    return natural(d);
  end function;

  -- DUT仕様に合わせた期待値（special優先、normalはreal参照）
  function div_expected(xv, yv : std_logic_vector(33 downto 0)) return std_logic_vector is
    variable exnX : std_logic_vector(1 downto 0);
    variable exnY : std_logic_vector(1 downto 0);
    variable sR   : std_logic;
    variable xr   : real;
    variable yr   : real;
    variable zr   : real;
    variable zabs : real;
  begin
    exnX := xv(33 downto 32);
    exnY := yv(33 downto 32);
    sR   := xv(31) xor yv(31);

    -- NaN propagation / undefined
    if (exnX = "11") or (exnY = "11") then
      return pack_fp("11", '0', 0, 1);
    end if;

    -- inf/inf, 0/0 => NaN
    if (exnX = "10") and (exnY = "10") then
      return pack_fp("11", '0', 0, 1);
    end if;

    if (exnX = "00") and (exnY = "00") then
      return pack_fp("11", '0', 0, 1);
    end if;

    -- division by zero: normal/0 or inf/0 => inf
    if (exnY = "00") and ((exnX = "01") or (exnX = "10")) then
      return pack_fp("10", sR, 0, 0);
    end if;

    -- 0/normal or 0/inf => 0
    if (exnX = "00") and ((exnY = "01") or (exnY = "10")) then
      return pack_fp("00", sR, 0, 0);
    end if;

    -- inf/normal => inf
    if (exnX = "10") and (exnY = "01") then
      return pack_fp("10", sR, 0, 0);
    end if;

    -- normal/inf => 0
    if (exnX = "01") and (exnY = "10") then
      return pack_fp("00", sR, 0, 0);
    end if;

    -- normal/normal
    -- ここでは exnX=01, exnY=01 のみのはず
    xr := fp_to_real_normal(xv);
    yr := fp_to_real_normal(yv);
    zr := xr / yr;

    if zr < 0.0 then
      zabs := -zr;
      return real_to_fp_normal_signed(zabs, '1');
    else
      zabs := zr;
      return real_to_fp_normal_signed(zabs, '0');
    end if;
  end function;

  -- 比較：specialは exn/sign だけ、normalは sign一致 + ULP
  procedure check_result(r_act : std_logic_vector(33 downto 0);
                         r_exp : std_logic_vector(33 downto 0);
                         tag   : string) is
    variable d : natural;
  begin
    if r_exp(33 downto 32) /= "01" then
      -- special
      if r_exp(33 downto 32) = "11" then
        -- NaN: exnだけチェック（signはdon't care）
        if r_act(33 downto 32) /= "11" then
          assert false report "FAIL(NaN exn) " & tag severity error;
        end if;
      else
        -- zero/inf: exn + sign をチェック
        if r_act(33 downto 31) /= r_exp(33 downto 31) then
          assert false report "FAIL(special exn/sign) " & tag severity error;
        end if;
      end if;

    else
      -- normal
      if r_act(33 downto 32) /= "01" then
        assert false report "FAIL(normal exn) " & tag severity error;
      elsif r_act(31) /= r_exp(31) then
        assert false report "FAIL(normal sign) " & tag severity error;
      else
        d := ulp_diff(r_act, r_exp);
        if d > MAX_ULP then
          assert false report "FAIL(normal ulp=" & integer'image(integer(d)) & ") " & tag severity error;
        end if;
      end if;
    end if;
  end procedure;

begin

--  uut: FPDiv_8_23_Freq1_uid2
--    port map (
--      clk => clk,
--      X   => X,
--      Y   => Y,
--      R   => R
--    );

  uut: FPALL_Shared_Wrapper
    generic map (
      OP_CODE_GEN => "11"
    )
    port map (
      clk => clk,
      X   => X,
      Y   => Y,
      R   => R
    );

  --------------------------------------------------------------------------
  -- clock
  --------------------------------------------------------------------------
  p_clk: process
  begin
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;
  end process;

  --------------------------------------------------------------------------
  -- Scoreboard（LATENCY吸収）
  --------------------------------------------------------------------------
  p_scoreboard: process
    variable exp_q : slv_arr(0 to LATENCY);
    variable val_q : sl_arr (0 to LATENCY);
    variable cyc   : natural := 0;
  begin
    -- init
    for k in 0 to LATENCY loop
      exp_q(k) := (others => '0');
      val_q(k) := '0';
    end loop;

    wait until rising_edge(clk);
    loop
      cyc := cyc + 1;

      -- shift
      for k in LATENCY downto 1 loop
        exp_q(k) := exp_q(k-1);
        val_q(k) := val_q(k-1);
      end loop;

      -- push current expected
      exp_q(0) := exp_in;
      val_q(0) := exp_valid;

      -- DUTレジスタ更新のdelta反映待ち
      wait for 0 ns;

      if val_q(LATENCY) = '1' then
        check_result(R, exp_q(LATENCY), "cycle=" & integer'image(integer(cyc)));
      end if;

      exit when done = '1';
      wait until rising_edge(clk);
    end loop;

    report "TB done." severity note;
    wait;
  end process;

  --------------------------------------------------------------------------
  -- Driver（directed + random）
  --------------------------------------------------------------------------
  p_driver: process
    variable seed1  : positive := 13579;
    variable seed2  : positive := 24680;
    variable rand_u : real;

    variable vx : std_logic_vector(33 downto 0);
    variable vy : std_logic_vector(33 downto 0);
    variable ve : std_logic_vector(33 downto 0);

    variable e_rand : natural;
    variable f_rand : natural;
    variable sgn    : std_logic;

    procedure pick_sign(variable u : in real; variable s : out std_logic) is
    begin
      if u < 0.5 then
        s := '0';
      else
        s := '1';
      end if;
    end procedure;

    procedure drive_one(ax, ay : std_logic_vector(33 downto 0)) is
      variable e_local : std_logic_vector(33 downto 0);
    begin
      e_local := div_expected(ax, ay);

      X         <= ax;
      Y         <= ay;
      exp_in    <= e_local;
      exp_valid <= '1';

      wait until rising_edge(clk);
    end procedure;

    -- normal number generator (exn="01", exp in 1..254)
    function gen_normal(sign : std_logic; e_in : natural; f_in : natural) return std_logic_vector is
    begin
      return pack_fp("01", sign, e_in, f_in);
    end function;

  begin
    exp_valid <= '0';
    done      <= '0';
    wait for 20 ns;

    -- 位相合わせ：rising前に入力を安定させたい
    wait until falling_edge(clk);

    ------------------------------------------------------------------------
    -- directed
    ------------------------------------------------------------------------
    -- 1.0 / 1.0 = 1.0
    drive_one(gen_normal('0', 127, 0), gen_normal('0', 127, 0));

    -- 4.0 / 2.0 = 2.0 (4.0=exp129, 2.0=exp128)
    drive_one(gen_normal('0', 129, 0), gen_normal('0', 128, 0));

    -- (-4.0) / 2.0 = -2.0
    drive_one(gen_normal('1', 129, 0), gen_normal('0', 128, 0));

    -- 0 / 1.0 = 0
    drive_one(pack_fp("00",'0',0,0), gen_normal('0',127,0));

    -- 1.0 / 0 = inf
    drive_one(gen_normal('0',127,0), pack_fp("00",'0',0,0));

    -- inf / 2.0 = inf
    drive_one(pack_fp("10",'0',0,0), gen_normal('0',128,0));

    -- 2.0 / inf = 0
    drive_one(gen_normal('0',128,0), pack_fp("10",'0',0,0));

    -- 0/0 = NaN
    drive_one(pack_fp("00",'0',0,0), pack_fp("00",'1',0,0));

    -- inf/inf = NaN
    drive_one(pack_fp("10",'0',0,0), pack_fp("10",'1',0,0));

    -- NaN / 1.0 = NaN
    drive_one(pack_fp("11",'0',0,1), gen_normal('0',127,0));

    -- 1.0 / NaN = NaN
    drive_one(gen_normal('0',127,0), pack_fp("11",'1',0,123));

    ------------------------------------------------------------------------
    -- random
    ------------------------------------------------------------------------
    for i in 1 to NUM_RANDOM loop
      -- X
      uniform(seed1, seed2, rand_u);
      if rand_u < 0.03 then
        -- zero
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vx := pack_fp("00", sgn, 0, 0);
      elsif rand_u < 0.05 then
        -- inf
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vx := pack_fp("10", sgn, 0, 0);
      elsif rand_u < 0.07 then
        -- NaN
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vx := pack_fp("11", sgn, 0, 1);
      else
        -- normal
        uniform(seed1, seed2, rand_u); e_rand := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); f_rand := natural(integer(rand_u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vx := gen_normal(sgn, e_rand, f_rand);
      end if;

      -- Y（ゼロ除算を適度に混ぜる）
      uniform(seed1, seed2, rand_u);
      if rand_u < 0.03 then
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vy := pack_fp("00", sgn, 0, 0);
      elsif rand_u < 0.05 then
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vy := pack_fp("10", sgn, 0, 0);
      elsif rand_u < 0.07 then
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vy := pack_fp("11", sgn, 0, 1);
      else
        uniform(seed1, seed2, rand_u); e_rand := 1 + natural(integer(rand_u * 254.0)); -- 1..254
        uniform(seed1, seed2, rand_u); f_rand := natural(integer(rand_u * real(2**23)));
        if f_rand > (2**23 - 1) then f_rand := 2**23 - 1; end if;
        uniform(seed1, seed2, rand_u);
        pick_sign(rand_u, sgn);
        vy := gen_normal(sgn, e_rand, f_rand);
      end if;

      drive_one(vx, vy);
      wait until falling_edge(clk);
    end loop;

    ------------------------------------------------------------------------
    -- flush
    ------------------------------------------------------------------------
    exp_valid <= '0';
    exp_in    <= (others => '0');
    X         <= (others => '0');
    Y         <= (others => '0');

    for k in 0 to integer(LATENCY)+2 loop
      wait until rising_edge(clk);
    end loop;

    done <= '1';
    wait;
  end process;

end architecture;
