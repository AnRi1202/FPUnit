library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IntMultiplier_24x24_48_Freq400_uid5 is
    port (clk : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(23 downto 0);
          R : out  std_logic_vector(47 downto 0)   );
end entity;
architecture arch of IntMultiplier_24x24_48_Freq400_uid5 is
   signal Mfull : std_logic_vector(47 downto 0);
   signal Mfull_d1, Mfull_d2 : std_logic_vector(47 downto 0);
begin
   Mfull <= std_logic_vector(unsigned(X) * unsigned(Y));
   process(clk)
   begin
      if clk'event and clk = '1' then
         Mfull_d1 <= Mfull;
         Mfull_d2 <= Mfull_d1;
      end if;
   end process;
   R <= Mfull_d2;
end architecture;

