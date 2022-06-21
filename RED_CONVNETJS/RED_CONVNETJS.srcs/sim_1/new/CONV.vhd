--------------------------- MODULO CONV----------------------------------------------------------------------------------
--Este modulo realiza la función de convolución que cosiste en la suma de cada multiplicación de una señal por su peso correspondiente
--según en que posición de la ventana del filtro se encuentr, se realiza sumando un 1 cada vez que el pulso de entrada indique que la señal no 
--es nula. Además si el pulso de entrada indica que la señal es negativa se invertirá el peso.
---ENTRADAS
-- data_in : los datos de entrada uno por uno como un pulso en serie
-- cont_s : indica si el pulso recibido es la señal, si es 0 o si es negativa/positiva
-- mul : indica en que parte del filtro nos encontramos, tendrá tamaño conv_col * conv_row * number_of_layers
-- weight : peso correspondiente a la parte del filtro en la que nos encontremos
-- next_pipeline_step : notifica de cuando termina una pasada del filtro y se pasa a la siguiente
--SALIDAS
--data_out : como salida se produce la acumulación de las señales de entrada multiplicadas por sus respectivos filtros

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
entity CONV is
    Port (data_in : in std_logic;
          clk : in std_logic;
          reset : in std_logic;
          cont_s : in unsigned(1 downto 0);
          next_pipeline_step : in std_logic;
          weight : in STD_LOGIC_VECTOR(weight_size - 1 downto 0);
          data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));
end CONV;
architecture Behavioral of CONV is
signal cero: STD_LOGIC := '0';
signal mac_out_next, mac_out_reg : signed(input_size+weight_size + 3 -1 downto 0) := (others => '0');  
signal mux_out, mux_aux1, mux_aux : signed (weight_size-1 downto 0);
begin 

-- Actualización del registro --
process (clk)
begin
	if rising_edge(clk) then
		if (reset = '1') then
			mac_out_reg <= (others => '0');
		else
			mac_out_reg <= mac_out_next;
		end if;
	end if;
end process;

process (data_in, cont_s)         --si la señal cont_s es 0, el contador es 0 y el bit entrante indica si el dato tiene valor nulo 
begin
    cero <= '0';
    if(cont_s = 0) then
		if (data_in = '0') then
			cero <= '1';
    	end if;
    end if;
end process;


process (data_in, weight, cont_s)    --si la señal cont_s es 1, el contador es 1 y el bit entrante indica si el dato es positivo o negativo, en cuyo caso invertimos el peso
begin
if(cont_s = 1 and data_in = '1' ) then         
	   mux_aux1 <= not(signed(weight)) + 1;
else
	   mux_aux1 <= signed(weight); 
end if;
end process;

process (cont_s, data_in, mux_aux1)    --si la señal cont_s es 2 todos los demas bits entrantes del dato son el valor numerico del mismo, si es 1 sumamos el peso
begin
    if(cont_s = 2) then                        
        if(data_in = '1') then
            mux_aux <= mux_aux1;
        else
            mux_aux<= (others => '0');
        end if;
    else     
        mux_aux<= (others => '0');
    end if;
end process;

process(mac_out_reg, cont_s, mux_out, next_pipeline_step)   --si la señal next-pipeline_step esta activa reseteamos el registro, si no lo es acumulamos el valor de las sumas
begin
	if (next_pipeline_step = '1') then
		mac_out_next <= (others => '0');
    else
        if(cont_s = 2) then
		  mac_out_next <= mac_out_reg + mux_out;
		else
		  mac_out_next <= mac_out_reg;
        end if;
     end if;
end process;

mux_out <= "00000000" when (cero = '1') else mux_aux;   --si el dato entrante es 0 asignamos al resultado el valor 0 directamente
data_out <= std_logic_vector(mac_out_reg);

 
end Behavioral;
