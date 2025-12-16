library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fpmul_kintex is
end entity;

architecture sim of tb_fpmul_kintex is

  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal X, Y : std_logic_vector(33 downto 0);  -- 8+23+2 = 33 bits
  signal R   : std_logic_vector(33 downto 0);

  constant CLK_PERIOD : time := 5 ns; -- 200MHz

  -- Helper function to create FP32 from components
  -- Format: [33:32] EXC, [31] SIGN, [30:23] EXP, [22:0] FRAC
  function to_fp32(exc : std_logic_vector(1 downto 0);
                   sign : std_logic;
                   exp : std_logic_vector(7 downto 0);
                   frac : std_logic_vector(22 downto 0))
    return std_logic_vector is
  begin
    return exc & sign & exp & frac;
  end function;

  -- Test case record
  type test_case_t is record
    x_val  : std_logic_vector(33 downto 0);
    y_val  : std_logic_vector(33 downto 0);
    name   : string(1 to 50);
  end record;

  type test_array_t is array (natural range <>) of test_case_t;

  constant test_cases : test_array_t := (
    -- Test 1: 2.0 * 3.0 = 6.0
    (to_fp32("01", '0', "10000000", "00000000000000000000000"), -- 2.0
     to_fp32("01", '0', "10000001", "10000000000000000000000"), -- 3.0
     "MUL: 2.0 * 3.0 = 6.0                            "),
    -- Test 2: 1.0 * 1.0 = 1.0
    (to_fp32("01", '0', "01111111", "00000000000000000000000"), -- 1.0
     to_fp32("01", '0', "01111111", "00000000000000000000000"), -- 1.0
     "MUL: 1.0 * 1.0 = 1.0                            "),
    -- Test 3: 0.5 * 4.0 = 2.0
    (to_fp32("01", '0', "01111110", "00000000000000000000000"), -- 0.5
     to_fp32("01", '0', "10000010", "00000000000000000000000"), -- 4.0
     "MUL: 0.5 * 4.0 = 2.0                            "),
    -- Test 4: -2.0 * 3.0 = -6.0
    (to_fp32("01", '1', "10000000", "00000000000000000000000"), -- -2.0
     to_fp32("01", '0', "10000001", "10000000000000000000000"), -- 3.0
     "MUL: -2.0 * 3.0 = -6.0                          "),
    -- Test 5: 1.5 * 2.0 = 3.0
    (to_fp32("01", '0', "01111111", "10000000000000000000000"), -- 1.5
     to_fp32("01", '0', "10000000", "00000000000000000000000"), -- 2.0
     "MUL: 1.5 * 2.0 = 3.0                            "),
    -- Test 6: 5.0 * 4.0 = 20.0
    (to_fp32("01", '0', "10000001", "01000000000000000000000"), -- 5.0
     to_fp32("01", '0', "10000010", "00000000000000000000000"), -- 4.0
     "MUL: 5.0 * 4.0 = 20.0                           ")
  );

  signal test_index : integer := 0;
  signal tests_running : std_logic := '0';

begin

  -- Clock Generation
  clk <= not clk after CLK_PERIOD / 2;

  -- DUT
  DUT : entity work.FPMult_8_23_uid2_Freq200_uid3
    port map (
      clk => clk,
      X   => X,
      Y   => Y,
      R   => R
    );

  -- Test Stimulus
  stim : process
  begin
    -- Reset
    rst <= '1';
    X <= (others => '0');
    Y <= (others => '0');
    wait for CLK_PERIOD * 2;
    rst <= '0';
    wait until rising_edge(clk);

    report "========================================" severity note;
    report "FPMult_8_23_uid2_Freq200_uid3 (Kintex7) Testbench Starting" severity note;
    report "========================================" severity note;

    tests_running <= '1';

    -- Run test cases
    for i in test_cases'range loop
      test_index <= i;
      X <= test_cases(i).x_val;
      Y <= test_cases(i).y_val;

      report test_cases(i).name severity note;
      report "  X = " & to_hstring(X) & 
              " (EXC=" & to_hstring(X(33 downto 32)) & 
              ", SIGN=" & std_logic'image(X(31)) & 
              ", EXP=" & to_hstring(X(30 downto 23)) & 
              ", FRAC=" & to_hstring(X(22 downto 0)) & ")" severity note;
      report "  Y = " & to_hstring(Y) & 
              " (EXC=" & to_hstring(Y(33 downto 32)) & 
              ", SIGN=" & std_logic'image(Y(31)) & 
              ", EXP=" & to_hstring(Y(30 downto 23)) & 
              ", FRAC=" & to_hstring(Y(22 downto 0)) & ")" severity note;

      wait until rising_edge(clk);

      -- Wait for pipeline latency (MUL: ~2-3 cycles)
      for j in 0 to 2 loop
        wait until rising_edge(clk);
      end loop;
      
      -- Display result
      report "  Result: R = " & to_hstring(R) & 
              " (EXC=" & to_hstring(R(33 downto 32)) & 
              ", SIGN=" & std_logic'image(R(31)) & 
              ", EXP=" & to_hstring(R(30 downto 23)) & 
              ", FRAC=" & to_hstring(R(22 downto 0)) & ")" severity note;
      report "" severity note;
    end loop;

    report "========================================" severity note;
    report "All Tests Completed" severity note;
    report "========================================" severity note;

    -- Stop monitoring after tests complete
    tests_running <= '0';
    wait for CLK_PERIOD * 10;  -- Wait for pipeline to clear
    
    -- Finish simulation
    report "Simulation finished - stopping" severity note;
    assert false report "Simulation finished successfully" severity failure;
  end process;

  -- Monitor process (for debugging)
  monitor : process(clk)
  begin
    if rising_edge(clk) and rst = '0' and tests_running = '1' then
      report "Monitor: R = " & to_hstring(R) & 
              " (EXC=" & to_hstring(R(33 downto 32)) & 
              ", SIGN=" & std_logic'image(R(31)) & 
              ", EXP=" & to_hstring(R(30 downto 23)) & 
              ", FRAC=" & to_hstring(R(22 downto 0)) & ")" severity note;
    end if;
  end process;

end architecture;




