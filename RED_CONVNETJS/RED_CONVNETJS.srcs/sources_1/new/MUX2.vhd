-------------MODULO MUX---------
--Este modulo selecciona la señal de salida para transmitir cada una de las señales de salida de los filtros de una capa
--como señal de entrada a los filtros de la siguiente capa. De esta manera transmitimos la matriz resultado a la siguiente capa
--ENTRADAS
--data_inx : señal de salida del filtro convolucional, una para cada filtro
--index: señal que selecciona la señal de salida, su valor va desde 0 hasta el número de capas
--SALIDAS
--data_out: señal seleccionada de salida 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.tfg_irene_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX2 is
    Port ( data_in0 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in1 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in2 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in3 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in4 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in5 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in6 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in7 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in8 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in9 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in10 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in11 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in12 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in13:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in14 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in15:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in16:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in17:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in18:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in19:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           index : in  STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
           data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));
end MUX2;
architecture Behavioral of MUX2 is
begin
data_out <=  data_in0 when index = "00000" else
             data_in1 when index = "00001" else
             data_in2 when index = "00010" else
             data_in3 when index = "00011" else
             data_in4 when index = "00100" else
             data_in5 when index = "00101" else
             data_in6 when index = "00110" else
             data_in7 when index = "00111" else
             data_in8 when index = "01000" else
             data_in9 when index = "01001" else
             data_in10 when index = "01010" else
             data_in11 when index = "01011" else
             data_in12 when index = "01100" else
             data_in13 when index = "01101" else
             data_in14 when index = "01110" else
             data_in15 when index = "01111" else
             data_in16 when index = "10000" else
             data_in17 when index = "10001" else
             data_in18 when index = "10010" else
             data_in19 when index = "10011" else 
             (others=>'0');
end Behavioral;