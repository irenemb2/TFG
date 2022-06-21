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

entity Interfaz_et2_tb is
end Interfaz_et2_tb;
architecture Behavioral of Interfaz_et2_tb is
component INTERFAZ_ET2
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      dato_out : out std_logic;
      cero : out std_logic;
      conv2_col : out unsigned(log2c(conv2_column) - 1 downto 0);
      conv2_fila : out  unsigned(log2c(conv2_row) - 1 downto 0);
      pool3_col : out unsigned(log2c(pool3_column) - 1 downto 0);
      pool3_fila : out  unsigned(log2c(pool3_row) - 1 downto 0);
      conv3_col : in unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : in  unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : in unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : in unsigned(log2c(pool4_row) - 1 downto 0));   
end component;
signal clk,reset, dato_in, dato_out, cero : STD_LOGIC;
signal conv2_col : unsigned(log2c(conv3_column) - 1 downto 0);
signal conv2_row : unsigned(log2c(conv3_row) - 1 downto 0);
signal pool3_col : unsigned(log2c(pool4_column) - 1 downto 0);
signal pool3_row : unsigned(log2c(pool4_row) - 1 downto 0);
signal conv3_col : unsigned(log2c(conv3_column) - 1 downto 0);
signal conv3_row : unsigned(log2c(conv3_row) - 1 downto 0);
signal pool4_col : unsigned(log2c(pool4_column) - 1 downto 0);
signal pool4_row : unsigned(log2c(pool4_row) - 1 downto 0);
constant T : time := 10 ns;
begin
U1 : INTERFAZ_ET2
port map(
         clk => clk,
         reset => reset,
         dato_in => dato_in,
         dato_out => dato_out,
         cero => cero,
         conv2_col => conv2_col,
         conv2_fila => conv2_row,
         pool3_fila => pool3_row,
         pool3_col => pool3_col,
         conv3_col => conv3_col,
         conv3_fila => conv3_row,
         pool4_fila => pool4_row,
         pool4_col => pool4_col);
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
main_in_process : process
begin 
         conv3_col <= (others=>'0');
         conv3_row <= (others=>'0');
         pool4_row <= (others=>'0');
         pool4_col <= (others=>'0');
         wait;
end process;
end Behavioral;
