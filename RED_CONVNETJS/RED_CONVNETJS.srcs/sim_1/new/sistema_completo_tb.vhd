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

entity sistema_completo_tb is
end sistema_completo_tb;
architecture Behavioral of sistema_completo_tb is
component sistema_completo
      Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          wea : IN STD_LOGIC;
          ena : IN STD_LOGIC;
          dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          address_uart : in STD_LOGIC_VECTOR(11 downto 0);
          dato_ready : out std_logic;
          start : in std_logic;
          data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));
end component;
signal clk,rst, wea, ena, dato_ready, start : STD_LOGIC;
signal dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal address_uart: STD_LOGIC_VECTOR(11 downto 0);
signal data_out : STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
constant T : time := 10 ns;
begin
U1 : sistema_completo
port map(
         start => start,
         clk => clk,
         rst => rst,
         wea => wea,
         ena => ena,
         dina => dina,
         address_uart => address_uart,
         dato_ready => dato_ready,
         data_out => data_out);
reset_process: process
begin 
      rst <= '1';
      wait for T/5;
      rst <= '0';
      wait;
end process;
clk_process : process
begin 
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
end process;
escribir_process : process
begin
ena <= '1';
wait for T * 75;
ena <= '0';
wait for T;
ena <= '1';
wait;
end process;
wea_process : process
begin
wea <= '1';
wait for T*75;
wea <= '0';
wait;
end process;
dina_process : process
begin
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000";--2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000";--1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000";--2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000";--1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000";--2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00000000";--0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000";--1
wait for T;
dina <= "00000000"; --0
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00001000"; --1
wait for T;
dina <= "00010000"; --2
wait for T;
dina <= "00000000";--0
wait;
end process;
address_process : process
begin
address_uart <= "000000000000"; --0
wait for T;
address_uart <= "000000000001"; --1
wait for T;
address_uart <= "000000000010"; --2
wait for T;
address_uart <= "000000000011"; --3
wait for T;
address_uart <= "000000000100";--4
wait for T;
address_uart <= "000000100000"; --32
wait for T;
address_uart <= "000000100001"; --33
wait for T;
address_uart <= "000000100010"; --34
wait for T;
address_uart <= "000000100011"; --35
wait for T;
address_uart <= "000000100100";--36
wait for T;
address_uart <= "000001000000"; --64
wait for T;
address_uart <= "000001000001"; --65
wait for T;
address_uart <= "000001000010"; --66
wait for T;
address_uart <= "000001000011"; --67
wait for T;
address_uart <= "000001000100";--68
wait for T;
address_uart <= "000001100000"; --96
wait for T;
address_uart <= "000001100001"; --97
wait for T;
address_uart <= "000001100010"; --98
wait for T;
address_uart <= "000001100011"; --99
wait for T;
address_uart <= "000001100100";--100
wait for T;
address_uart <= "000010000000"; --128
wait for T;
address_uart <= "000010000001"; --129
wait for T;
address_uart <= "000010000010"; --130
wait for T;
address_uart <= "000010000011"; --131
wait for T;
address_uart <= "000010000100";--132
wait for T;
--
address_uart <= "010000000000"; --1024
wait for T;
address_uart <= "010000000001"; --1025
wait for T;
address_uart <= "010000000010"; --1026
wait for T;
address_uart <= "010000000011"; --1027
wait for T;
address_uart <= "010000000100";--1028
wait for T;
address_uart <= "010000100000"; --1056
wait for T;
address_uart <= "010000100001"; --1057
wait for T;
address_uart <= "010000100010"; --1058
wait for T;
address_uart <= "010000100011"; --1059
wait for T;
address_uart <= "010000100100";--1060
wait for T;
address_uart <= "010001000000"; --1088
wait for T;
address_uart <= "010001000001"; --1089
wait for T;
address_uart <= "010001000010"; --1090
wait for T;
address_uart <= "010001000011"; --1091
wait for T;
address_uart <= "010001000100";--1092
wait for T;
address_uart <= "010001100000"; --1120
wait for T;
address_uart <= "010001100001"; --1121
wait for T;
address_uart <= "010001100010"; --1122
wait for T;
address_uart <= "010001100011"; --1123
wait for T;
address_uart <= "010001100100";--1124
wait for T;
address_uart <= "010010000000"; --1152
wait for T;
address_uart <= "010010000001"; --1153
wait for T;
address_uart <= "010010000010"; --1154
wait for T;
address_uart <= "010010000011"; --1155
wait for T;
address_uart <= "010010000100";--1156
wait for T;
--
address_uart <= "100000000000"; --2048
wait for T;
address_uart <= "100000000001"; --2049
wait for T;
address_uart <= "100000000010"; --2050
wait for T;
address_uart <= "100000000011"; --2051
wait for T;
address_uart <= "100000000100";--2052
wait for T;
address_uart <= "100000100000"; --2080
wait for T;
address_uart <= "100000100001"; --2081
wait for T;
address_uart <= "100000100010"; --2082
wait for T;
address_uart <= "100000100011"; --2083
wait for T;
address_uart <= "100000100100";--2084
wait for T;
address_uart <= "100001000000"; --2112
wait for T;
address_uart <= "100001000001"; --2113
wait for T;
address_uart <= "100001000010"; --2114
wait for T;
address_uart <= "100001000011"; --2115
wait for T;
address_uart <= "100001000100";--2116
wait for T;
address_uart <= "100001100000"; --1120
wait for T;
address_uart <= "100001100001"; --1121
wait for T;
address_uart <= "100001100010"; --1122
wait for T;
address_uart <= "100001100011"; --1123
wait for T;
address_uart <= "100001100100";--1124
wait for T;
address_uart <= "100010000000"; --2144
wait for T;
address_uart <= "100010000001"; --2145
wait for T;
address_uart <= "100010000010"; --2146
wait for T;
address_uart <= "100010000011"; --2147
wait for T;
address_uart <= "100010000100";--2148
wait for T;
end process;
main_process : process
begin
start <= '0';
wait for T*75;
start <= '1';
wait for T;
start <= '0';
wait;
end process;
end Behavioral;
