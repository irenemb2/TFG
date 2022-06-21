----------------------MODULO MEMORIA ROM---------------
--Este modulo almacena los pesos de cada uno de los filtros convolucionales
--estos pesos se eligen según la posición del filtro en la que se encuentre
--ENTRADAS
--address : un numero entre 0 - tamaño del filtro que corresponde con la posición del filtro que se este operando en el momento
--SALIDAS
--bias_term: termino de bias de la neurona
--weight : peso de la neurona correspondiente al address
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.tfg_irene_package.ALL;
entity ROM1_10 is
	Port ( address : in std_logic_vector(log2c(mult1) - 1 downto 0);
		     bias_term :out unsigned (input_size + weight_size + 3 - 1  downto 0); 
		     weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM1_10; 
architecture Behavioral of ROM1_10 is
begin
bias_term<= "1111111110111010001" ;
with address select weight <= 
	"00000101" when "0000000", -- 0
	"00010110" when "0000001", -- 1
	"11111010" when "0000010", -- 2
	"00010011" when "0000011", -- 3
	"00011001" when "0000100", -- 4
	"00000101" when "0000101", -- 5
	"00000111" when "0000110", -- 6
	"00000110" when "0000111", -- 7
	"11111001" when "0001000", -- 8
	"11101101" when "0001001", -- 9
	"11100100" when "0001010", -- 10
	"11111010" when "0001011", -- 11
	"11110110" when "0001100", -- 12
	"11110110" when "0001101", -- 13
	"00000011" when "0001110", -- 14
	"00000011" when "0001111", -- 15
	"00000001" when "0010000", -- 16
	"11110000" when "0010001", -- 17
	"00000101" when "0010010", -- 18
	"00010010" when "0010011", -- 19
	"11111101" when "0010100", -- 20
	"00010110" when "0010101", -- 21
	"00001111" when "0010110", -- 22
	"00001111" when "0010111", -- 23
	"00000000" when "0011000", -- 24
	"11110110" when "0011001", -- 25
	"11111000" when "0011010", -- 26
	"11101100" when "0011011", -- 27
	"11100010" when "0011100", -- 28
	"00001011" when "0011101", -- 29
	"00001100" when "0011110", -- 30
	"00000101" when "0011111", -- 31
	"11100001" when "0100000", -- 32
	"00001000" when "0100001", -- 33
	"11111110" when "0100010", -- 34
	"11110111" when "0100011", -- 35
	"00001110" when "0100100", -- 36
	"00001010" when "0100101", -- 37
	"00010001" when "0100110", -- 38
	"11111011" when "0100111", -- 39
	"11110110" when "0101000", -- 40
	"00010101" when "0101001", -- 41
	"11100001" when "0101010", -- 42
	"11011111" when "0101011", -- 43
	"00010000" when "0101100", -- 44
	"00001010" when "0101101", -- 45
	"00001100" when "0101110", -- 46
	"11100010" when "0101111", -- 47
	"00001110" when "0110000", -- 48
	"00000111" when "0110001", -- 49
	"11101010" when "0110010", -- 50
	"00001111" when "0110011", -- 51
	"00000110" when "0110100", -- 52
	"11111010" when "0110101", -- 53
	"00000000" when "0110110", -- 54
	"00000111" when "0110111", -- 55
	"00100001" when "0111000", -- 56
	"11010001" when "0111001", -- 57
	"11101000" when "0111010", -- 58
	"00010100" when "0111011", -- 59
	"00001001" when "0111100", -- 60
	"00000111" when "0111101", -- 61
	"11100001" when "0111110", -- 62
	"00000111" when "0111111", -- 63
	"00000011" when "1000000", -- 64
	"11101001" when "1000001", -- 65
	"00010010" when "1000010", -- 66
	"00000100" when "1000011", -- 67
	"11111001" when "1000100", -- 68
	"11111111" when "1000101", -- 69
	"00001011" when "1000110", -- 70
	"00001110" when "1000111", -- 71
	"11011010" when "1001000", -- 72
	"11110111" when "1001001", -- 73
	"00100011" when "1001010", -- 74
	"00000000" when others; 
 end Behavioral;

