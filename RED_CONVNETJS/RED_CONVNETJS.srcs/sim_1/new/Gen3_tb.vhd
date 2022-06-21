-- Engineer: 
-- 
-- Create Date: 24.11.2021 20:51:27
-- Design Name: 
-- Module Name: registro - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
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

entity Gen3_tb is
end Gen3_tb;
architecture Behavioral of Gen3_tb is
component GEN3
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
      cont_s : out unsigned(1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      mul: out std_logic_vector(log2c(mult3) - 1 downto 0);
      dato_out1 : out std_logic;
      dato_out2 : out std_logic;
      index : out std_logic;
      en_neurona : out std_logic;
      next_dato_pool : out std_logic;
      next_pipeline_step : out std_logic);
end component;
signal clk,reset, dato_in, dato_out1, dato_out2, next_pipeline_step, index, en_neurona, next_dato_pool : STD_LOGIC;
signal cont_s :  unsigned(1 downto 0);
signal mul :  std_logic_vector(log2c(mult3) - 1 downto 0);
signal count : STD_LOGIC_VECTOR( input_size   downto 0);
signal capa : STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);

constant T : time := 10 ns;
begin
U1 : GEN3
port map(
         clk => clk,
         rst => reset,
         dato_in => dato_in,
         dato_out1 => dato_out1,
         dato_out2 => dato_out2,
         next_pipeline_step => next_pipeline_step,
         mul => mul,
         count => count,
         cont_s => cont_s,
         capa => capa,
         index => index,
         en_neurona => en_neurona,
         next_dato_pool => next_dato_pool);
reset_process: process
begin 
      reset <= '1';
      wait for T/5;
      reset <= '0';
      wait;
end process;
dato_in_process: process
begin 
      dato_in <= '1';
      wait for T * 2;
      dato_in <= '0';
      wait for T * 2;
end process;
clk_process : process
begin 
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
end process;

end Behavioral;
