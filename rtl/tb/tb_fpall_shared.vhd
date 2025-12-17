--------------------------------------------------------------------------------
-- Testbench for FPALL_Shared
-- Validates that the shared operator behaves correctly for:
-- opcode=00: Add
-- opcode=01: Mul
-- opcode=10: Sqrt
-- opcode=11: Div
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fpall_shared is
end tb_fpall_shared;

architecture behavior of tb_fpall_shared is

    -- Component Declaration for the Unit Under Test (UUT)
    component FPALL_Shared
    port(
        clk : in std_logic;
        opcode : in std_logic_vector(1 downto 0); -- 00: Add, 01: Mul, 10: Sqrt, 11: Div
        X : in std_logic_vector(33 downto 0);
        Y : in std_logic_vector(33 downto 0);
        R : out std_logic_vector(33 downto 0)
    );
    end component;
    
    -- Inputs
    signal clk : std_logic := '0';
    signal opcode : std_logic_vector(1 downto 0) := "00";
    signal X   : std_logic_vector(33 downto 0) := (others => '0');
    signal Y   : std_logic_vector(33 downto 0) := (others => '0');

    -- Outputs
    signal R   : std_logic_vector(33 downto 0);

    -- Simulation control
    signal sim_finished : boolean := false;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
 
    -- Instantiate the Unit Under Test (UUT)
    uut: FPALL_Shared PORT MAP (
          clk => clk,
          opcode => opcode,
          X => X,
          Y => Y,
          R => R
        );

    -- Clock process definitions
    clk_process :process
    begin
        while not sim_finished loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset/wait state
        wait for 100 ns;	
        wait for clk_period*10;

        report "Starting Simulation: Testbench for FPALL_Shared";

        --------------------------------------------------------------------------------
        -- PHASE 1: ADDER MODE (opcode = "00")
        --------------------------------------------------------------------------------
        opcode <= "00";
        report "Switched to ADDER MODE (opcode=00)";
        wait for clk_period;

        -- Test Case 1: 1.0 + 1.0 = 2.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 2: 2.0 + 1.0 = 3.0
        X <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 3: 1.0 - 1.0 = 0.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "1" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 4: Zero + 1.0 = 1.0
        X <= "00" & "0" & x"00" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 5: 3.5 + 2.25 = 5.75
        X <= "01" & "0" & x"80" & "110000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"80" & "001000" & x"0000" & "0"; 
        wait for clk_period;
        
        wait for clk_period * 5;

        --------------------------------------------------------------------------------
        -- PHASE 2: MULTIPLIER MODE (opcode = "01")
        --------------------------------------------------------------------------------
        opcode <= "01";
        report "Switched to MULTIPLIER MODE (opcode=01)";
        wait for clk_period;

        -- Test Case 1: 1.0 * 1.0 = 1.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 2: 2.0 * 1.0 = 2.0
        X <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 3: 3.0 * 2.0 = 6.0
        X <= "01" & "0" & x"80" & "100000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 4: 1.0 * -1.0 = -1.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "1" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 5: Zero * 5.0 = 0.0
        X <= "00" & "0" & x"00" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"81" & "010000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 6: 1.5 * 0.5 = 0.75
        X <= "01" & "0" & x"7F" & "100000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7E" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        wait for clk_period * 5;

        --------------------------------------------------------------------------------
        -- PHASE 3: SQRT MODE (opcode = "10")
        --------------------------------------------------------------------------------
        opcode <= "10";
        report "Switched to SQRT MODE (opcode=10)";
        wait for clk_period;

        -- Test Case 1: sqrt(1.0) = 1.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= (others => '0'); -- Y is not used for SQRT
        wait for clk_period;
        
        -- Test Case 2: sqrt(4.0) = 2.0
        X <= "01" & "0" & x"80" & "100000" & x"0000" & "0"; 
        Y <= (others => '0');
        wait for clk_period;

        -- Test Case 3: sqrt(9.0) = 3.0
        X <= "01" & "0" & x"81" & "001000" & x"0000" & "0"; 
        Y <= (others => '0');
        wait for clk_period;
        
        -- Test Case 4: sqrt(0.0) = 0.0
        X <= "00" & "0" & x"00" & "000000" & x"0000" & "0"; 
        Y <= (others => '0');
        wait for clk_period;

        wait for clk_period * 5;

        --------------------------------------------------------------------------------
        -- PHASE 4: DIV MODE (opcode = "11")
        --------------------------------------------------------------------------------
        opcode <= "11";
        report "Switched to DIV MODE (opcode=11)";
        wait for clk_period;

        -- Test Case 1: 1.0 / 1.0 = 1.0
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 2: 4.0 / 2.0 = 2.0
        X <= "01" & "0" & x"80" & "100000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        -- Test Case 3: 6.0 / 3.0 = 2.0
        X <= "01" & "0" & x"80" & "110000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"80" & "100000" & x"0000" & "0"; 
        wait for clk_period;
        
        -- Test Case 4: 1.0 / 2.0 = 0.5
        X <= "01" & "0" & x"7F" & "000000" & x"0000" & "0"; 
        Y <= "01" & "0" & x"80" & "000000" & x"0000" & "0"; 
        wait for clk_period;

        wait for clk_period * 10;
        
        -- Stop simulation
        report "End of Simulation";
        sim_finished <= true;
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
        
        function opcode_to_string(opc : std_logic_vector(1 downto 0)) return string is
        begin
            case opc is
                when "00" => return "ADD ";
                when "01" => return "MUL ";
                when "10" => return "SQRT";
                when "11" => return "DIV ";
                when others => return "UNKN";
            end case;
        end function;
    begin
        if rising_edge(clk) then
            if X /= (X'range => '0') or Y /= (Y'range => '0') then
                -- Report current mode and values
                report "Mode: " & opcode_to_string(opcode) & 
                       " | Time: " & time'image(now) & 
                       " | X=" & to_hex_string(X) & 
                       " | Y=" & to_hex_string(Y) & 
                       " | R=" & to_hex_string(R);
            end if;
        end if;
    end process;

end behavior;
