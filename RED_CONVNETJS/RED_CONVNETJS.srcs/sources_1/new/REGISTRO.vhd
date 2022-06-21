library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tfg_irene_package.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTRO is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in unsigned(log2c(conv2_column) - 1 downto 0);
      dato_out : out unsigned(log2c(conv2_column) - 1 downto 0));
end REGISTRO;


architecture Behavioral of REGISTRO is
signal dato_reg, dato_next  : unsigned(log2c(conv2_column) - 1 downto 0) := (others => '0');

-- register 

begin
process(clk,rst) 
begin 
if (rst = '1') then 
   dato_reg <= (others => '0');
elsif (clk'event and clk = '1') then 
   dato_reg <= dato_next;
    end if;
end process;

dato_next <= dato_reg;
dato_out <= dato_reg;

end Behavioral;