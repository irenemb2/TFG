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
entity ROM1_6 is
	Port ( address : in std_logic_vector(log2c(mult1) - 1 downto 0);
		     bias_term :out unsigned (input_size + weight_size + 3 - 1  downto 0); 
		     weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end ROM1_6; 
architecture Behavioral of ROM1_6 is
begin
bias_term<= "1111111110110100111" ;
with address select weight <= 
	"11110100" when "0000000", -- 0
	"00001110" when "0000001", -- 1
	"00000000" when "0000010", -- 2
	"00001100" when "0000011", -- 3
	"11101001" when "0000100", -- 4
	"00001100" when "0000101", -- 5
	"00000111" when "0000110", -- 6
	"11100010" when "0000111", -- 7
	"00000111" when "0001000", -- 8
	"00010110" when "0001001", -- 9
	"11111110" when "0001010", -- 10
	"00000011" when "0001011", -- 11
	"11110011" when "0001100", -- 12
	"00000110" when "0001101", -- 13
	"00000000" when "0001110", -- 14
	"11110100" when "0001111", -- 15
	"00001000" when "0010000", -- 16
	"11110010" when "0010001", -- 17
	"00001110" when "0010010", -- 18
	"11110010" when "0010011", -- 19
	"00011011" when "0010100", -- 20
	"11100100" when "0010101", -- 21
	"11010001" when "0010110", -- 22
	"11110000" when "0010111", -- 23
	"00100100" when "0011000", -- 24
	"00010100" when "0011001", -- 25
	"00010101" when "0011010", -- 26
	"11100011" when "0011011", -- 27
	"11110100" when "0011100", -- 28
	"11100101" when "0011101", -- 29
	"11110001" when "0011110", -- 30
	"00011111" when "0011111", -- 31
	"00000010" when "0100000", -- 32
	"00001110" when "0100001", -- 33
	"00010000" when "0100010", -- 34
	"00010101" when "0100011", -- 35
	"11001110" when "0100100", -- 36
	"10100110" when "0100101", -- 37
	"11010100" when "0100110", -- 38
	"01001111" when "0100111", -- 39
	"01001001" when "0101000", -- 40
	"01001001" when "0101001", -- 41
	"11100001" when "0101010", -- 42
	"11111101" when "0101011", -- 43
	"11011000" when "0101100", -- 44
	"00001110" when "0101101", -- 45
	"00011001" when "0101110", -- 46
	"11110111" when "0101111", -- 47
	"00000010" when "0110000", -- 48
	"00000010" when "0110001", -- 49
	"00011101" when "0110010", -- 50
	"11000110" when "0110011", -- 51
	"10100011" when "0110100", -- 52
	"11000110" when "0110101", -- 53
	"01100110" when "0110110", -- 54
	"01100111" when "0110111", -- 55
	"01000001" when "0111000", -- 56
	"11001001" when "0111001", -- 57
	"11101000" when "0111010", -- 58
	"11000101" when "0111011", -- 59
	"11101101" when "0111100", -- 60
	"00010110" when "0111101", -- 61
	"00001101" when "0111110", -- 62
	"00000111" when "0111111", -- 63
	"11111001" when "1000000", -- 64
	"00000110" when "1000001", -- 65
	"11011110" when "1000010", -- 66
	"10111111" when "1000011", -- 67
	"11011111" when "1000100", -- 68
	"00111110" when "1000101", -- 69
	"00111110" when "1000110", -- 70
	"00110001" when "1000111", -- 71
	"11101110" when "1001000", -- 72
	"11110001" when "1001001", -- 73
	"11011101" when "1001010", -- 74
	"00000000" when others; 
 end Behavioral;

