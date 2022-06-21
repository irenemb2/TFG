--------------------------MODULO PAR2SER------------------------------------
--Este modulo se encarga de transformar la señal que entra en paralelo en un pulso en serie
--El pulso de salida informa sobre si la señal es 0, si es positiva o negativa y de su valor.
--El primer pulso que coincide con count = 0 indica si la señal es nula o no, el segundo con count = 1 indica si la señal es positiva/negativa
--El resto del pulso será 1 mientras sea mayor que la señal count y a 0 el resto del tiempo
--ENTRADAS
--data_in: señal a transformar
--count: contador que utilizamos para comparar la señal y así codificarla
--SALIDAS
--data_out: manda la salida en serie
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tfg_irene_package.ALL;
use IEEE.NUMERIC_STD.ALL;
entity PAR2SER is
	 Port (data_in : in STD_LOGIC_VECTOR(input_size - 1 downto 0);
		    count : in STD_LOGIC_VECTOR( input_size downto 0);
		    serial_out : out STD_LOGIC);
end PAR2SER; 
architecture Behavioral of PAR2SER is
signal data_extended : unsigned(input_size downto 0) := (others=>'0');
signal data : unsigned(input_size - 1 downto 0);
begin
process(count, data_in, data_extended)
begin
if(count = "000000000" ) then 
	 if(data_in = "00000000") then
		 serial_out <= '0';
	else
		 serial_out <= '1';
	 end if;
elsif (count = "000000001" ) then   --cuando count es 1 mandamos 0 si el dato es positivo y 1 en caso contrario, el dato se pasa a valor absoluto
if(data_in(input_size - 1) = '0') then
	 serial_out <= '0';
else
	 serial_out <= '1';
end if;
else                                 --para los demas valores de count mandamos un pulso correspondiente al dato de enrada + 2 para compensar por count = 0 y count = 1
    if(data_extended > unsigned(count)) then
     serial_out <='1';
else
     serial_out <='0';
    end if;
end if;
end process;
process (data_in)
begin
	 if(data_in(input_size - 1) = '0') then
		 data <= unsigned(data_in);
	 elsif(data_in = "10000000") then
	 	 data<= "01111111";
	 else
	 	  data<= unsigned(not(data_in)) + 1;
	 end if;
end process;
data_extended <= unsigned('0' & data) + 2;
end Behavioral;
