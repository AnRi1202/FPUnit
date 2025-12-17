--------------------------------------------------------------------------------
-- Testbench for FPMult_8_23_uid2_Freq1_uid3 (FPMult_Kin_f1_origin.vhdl)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fpmul_kintex is
end tb_fpmul_kintex;

architecture behavior of tb_fpmul_kintex is

    -- Component Declaration for the Unit Under Test (UUT)
    -- This matches the entity in research/flopoco_synth/rtl/src/FPMult_Kin_f1_origin.vhdl
    component FPMult_8_23_uid2_Freq1_uid3
    port(
         clk : in  std_logic;
         X : in  std_logic_vector(33 downto 0);
         Y : in  std_logic_vector(33 downto 0);
         R : out  std_logic_vector(33 downto 0)
        );
    end component;
    
    -- Input signals
    signal clk : std_logic := '0';
    signal X   : std_logic_vector(33 downto 0) := (others => '0');
    signal Y   : std_logic_vector(33 downto 0) := (others => '0');

    -- Output signals
    signal R   : std_logic_vector(33 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
 
    -- Instantiate the Unit Under Test (UUT)
    uut: FPMult_8_23_uid2_Freq1_uid3 PORT MAP (
          clk => clk,
          X => X,
          Y => Y,
          R => R
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset/wait state
        wait for 100 ns;	
        wait for clk_period*10;

        ------------------------------------------------------------
        -- Format: Exc(2) & Sign(1) & Exp(8) & Frac(23)
        -- Exc: 00=Zero, 01=Normal, 10=Inf/OF, 11=NaN
        -- Exp: Bias 127
        ------------------------------------------------------------

        -- Test Case 1: 1.0 * 1.0 = 1.0
        -- 1.0 = +1.0 * 2^0
        -- Sign=0, Exp=127 (0x7F), Frac=0, Exc=01
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 2: 2.0 * 1.0 = 2.0
        -- 2.0 = +1.0 * 2^1 -> Exp=128 (0x80)
        X <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; -- 2.0
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; -- 1.0
        wait for clk_period;

        -- Test Case 3: 3.0 * 2.0 = 6.0
        -- 3.0 = 1.5 * 2^1 = (1 + 0.5) * 2^1 -> Exp=128, Frac=0.5 (1000...)
        -- 2.0 = Exp=128 (0x80)
        -- Result 6.0 = 1.5 * 2^2 = (1+0.5) * 2^2 -> Exp=129 (0x81), Frac=0.5
        X <= "01" & "0" & x"80" & "100000" & x"0000" & "0"; -- 3.0
        Y <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; -- 2.0
        wait for clk_period;
        
        -- Test Case 4: 1.0 * -1.0 = -1.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; -- 1.0
        Y <= "01" & "1" & x"7F" & "000000" & x"0000" & "0"; -- -1.0
        wait for clk_period;

        -- Test Case 5: Zero * 5.0 = 0.0
        X <= "00" & "0" & x"00" & "000000" & x"0000" & "0"; -- 0.0
        Y <= "01" & "0" & x"81" & "010000" & x"0000" & "0"; -- 5.0 (approx)
        wait for clk_period;

        -- Test Case 6: 1.5 * 0.5 = 0.75
        -- 1.5 = 1.1 * 2^0 -> Exp=127, Frac=0.100...
        -- 0.5 = 1.0 * 2^-1 -> Exp=126, Frac=0.000...
        -- Result 0.75 = 1.1 * 2^-1 -> Exp=126, Frac=0.100...
        X <= "01" & "0" & x"7F" & "100000" & x"0000" & "0"; -- 1.5
        Y <= "01" & "0" & x"7E" & "000000" & x"0000" & "0"; -- 0.5
        wait for clk_period;

        -- Let the simulation run for a bit
        wait for clk_period * 10;
        
        -- Stop simulation
        assert false report "End of Simulation" severity failure;
        wait;
    end process;

    -- Monitor process to print results
    monitor_proc: process(clk)
        function to_hex_string(slv : std_logic_vector) return string is
            variable hex_str : string(1 to (slv'length + 3) / 4);
            variable digit : std_logic_vector(3 downto 0);
            variable hex_char : character;
            variable idx : integer;
            variable padded_slv : std_logic_vector(((slv'length + 3) / 4) * 4 - 1 downto 0);
        begin
            padded_slv := (others => '0');
            padded_slv(slv'length-1 downto 0) := slv;
            idx := 1;
            for i in padded_slv'length/4 - 1 downto 0 loop
                digit := padded_slv(i*4+3 downto i*4);
                case digit is
                    when "0000" => hex_char := '0';
                    when "0001" => hex_char := '1';
                    when "0010" => hex_char := '2';
                    when "0011" => hex_char := '3';
                    when "0100" => hex_char := '4';
                    when "0101" => hex_char := '5';
                    when "0110" => hex_char := '6';
                    when "0111" => hex_char := '7';
                    when "1000" => hex_char := '8';
                    when "1001" => hex_char := '9';
                    when "1010" => hex_char := 'A';
                    when "1011" => hex_char := 'B';
                    when "1100" => hex_char := 'C';
                    when "1101" => hex_char := 'D';
                    when "1110" => hex_char := 'E';
                    when "1111" => hex_char := 'F';
                    when others => hex_char := 'X';
                end case;
                hex_str(idx) := hex_char;
                idx := idx + 1;
            end loop;
            return hex_str;
        end function;
    begin
        if rising_edge(clk) then
             -- Wait a little for combinational logic to settle after input change (if inputs change on clk edges)
            if X /= (X'range => '0') or Y /= (Y'range => '0') then
                report "Time: " & time'image(now) & 
                       " X=" & to_hex_string(X) & 
                       " Y=" & to_hex_string(Y) & 
                       " R=" & to_hex_string(R);
            end if;
        end if;
    end process;

end behavior;
