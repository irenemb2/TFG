---------------------------------MODULO RELU-----------------------------------
--Este modulo se encarga de realizar la operación de ReLU, almacena los datos necesarios para la capa Pool del próximo filtro y suma el termino de bias
--Los datos se almacenan si una vez sumado el termino de bias el resultado es positivo, si es negativo se almacena un cero en su lugar
--ENTRADAS
--data_in : como entrada recibe la salida de la operación convolucional
--bias_term : recibe el termino bias de cada filtro porque realizamos la suma de este en la ReLU
--index : esta señal sirve para transmitir todos los datos almacenados desde la relu a la próxima capa, cuando haya que procesarlos
--SALIDAS
--data_out : manda las señales almacenadas con el termino de bias y la ReLU aplicadas, una vez la siguiente capa notifique que las puede procesar
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

entity RELU is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      next_pipeline_step : in STD_LOGIC;
      index : in std_logic;
      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
      bias_term : in unsigned (input_size + weight_size + 3 -1  downto 0);
      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));
end RELU;

architecture Behavioral of RELU is
signal c_aux  :unsigned(input_size + weight_size + 3 downto 0) := (others => '0');
signal dato_reg : vector_relu(0 to pool2_size - 1);
signal dato_next : vector_relu(0 to pool2_size - 1);
signal index2 : natural := 0;
signal suma : unsigned(2 downto 0) := "000";
-- register 

begin
process(clk,rst) 
begin 
if (rst = '1') then 
   for i in 0 to pool2_size - 1 loop
      dato_reg(i) <= (others=>'0');
   end loop;
elsif (clk'event and clk = '1') then 
   if(index = '1') then          --si index = 1 incrementamos index2 para mandar por data_out los datos guardados en ReLu
     if(index2 = pool2_size - 1) then
        index2 <= 0;
     else
        index2 <= index2 + 1;
     end if;
   end if;
   if(next_pipeline_step = '1') then     --si next_pipeline_step se activa actualizamos el registro con un dato nuevo de la neurona          
     for i in 0 to pool2_size - 1 loop
        dato_reg(i) <= dato_next(i);
     end loop;
    end if;
end if;
end process; 
--next-state logic 
process(data_in, bias_term, c_aux, suma)          --si el dato es negativo se guarda un cero, en caso contrario guardamos el dato mas el bias term
begin    
c_aux <= (others => '0'); 
   if((data_in(input_size + weight_size + 3 - 1 ) = '0') and (bias_term(input_size + weight_size + 3 - 1 ) = '0')) then
       c_aux <= ('0' & unsigned(data_in)) + ('0' & bias_term);
   elsif((data_in(input_size + weight_size + 3 - 1 ) = '1') and (bias_term(input_size + weight_size + 3 - 1 ) = '0')) then
       if(unsigned(data_in) < unsigned(bias_term)) then
          c_aux <= ('0' & unsigned(data_in)) + ('0' & bias_term);
       end if;
   elsif((data_in(input_size + weight_size + 3 - 1 ) = '0') and (bias_term(input_size + weight_size + 3 - 1 ) = '1')) then
       if(unsigned(data_in) > unsigned(bias_term)) then
          c_aux <= ('0' & unsigned(data_in)) + ('0' & bias_term);
        end if;
   end if;
end process;

process(dato_reg, c_aux, dato_next)                   --guardamos los datos entrantes en registros consecutivos                               
begin
     for i in pool2_size - 1 downto 0 loop 
     if(i = pool2_size - 1) then
          dato_next(i) <= std_logic_vector(c_aux(input_size + weight_size + 3 -1 downto 0));
     else
      dato_next(i) <= dato_reg(i + 1);
     end if;
     end loop;
end process;

data_out <= dato_reg(index2);

end Behavioral;