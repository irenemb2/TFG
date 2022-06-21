----------------------------MODULO GENERADOR 1----------------------------
--Este modulo se encarga de producir todas las señales de control de su capa, que permiten sincronizar el funcionamiento de todos los modulos
--ENTRADAS
--dato_in : indica que hay un dato a procesar en la capa
--SALIDAS
--capa : indica la capa de la matriz resultado de la etapa anterior que estamos procesando en este momento
--mul : indica la multiplicación del filtro que estemos realizando en ese momento
--count : contador de 0 hasta 2^(longitud señal) + 2 que pasamos al conversor paralelo serie para codificar la señal
--cont_s : señal que cuenta desde 0 a 2 y se mantiene hasta que termine count, se utiliza para indicar en que momento de count estoy en el conversor par2ser
--dato_out1 :  señal que notifica de que se ha terminado de procesar un dato en esta capa
--dato_out2 : señal que notifica de que hay un dato disponible para procesar en la siguiente capa

--next_pipeline_step: indica que ha terminado de preocesar un dato en la convolucion
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

entity GEN1 is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      cont_s : out unsigned(1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      mul: out std_logic_vector(log2c(mult1) - 1 downto 0);
      dato_out1: out std_logic;
      dato_out2 : out std_logic;
      next_pipeline_step : out std_logic);
end GEN1;

architecture Behavioral of GEN1 is
type state_type is (idle , espera, s0);
--REGISTROS
signal state_reg, state_next : state_type;
signal dato_reg , dato_next : std_logic := '0';
signal count_reg, count_next: unsigned(input_size + log2c(mult1) + log2c(pool2_size) downto 0) :=  (others=>'0');
signal count_r : unsigned( input_size downto 0);
signal c_reg , c_next : unsigned ( 1 downto 0);
signal next_pipeline_step_reg, next_pipeline_step_next, dato2_reg, dato2_next : std_logic;

--CONSTANTES
signal data_max : unsigned(input_size - 1 downto 0):=  (others=>'0');
signal count_max  : unsigned(input_size  downto 0):=  (others=>'0');
signal mul_max : unsigned(log2c(mult1)- 1 downto 0):=  (others=>'0');
 
begin
process(clk, rst) 
begin 
if (rst = '1') then 
      count_reg <= (others=>'0');
      c_reg <= (others=>'0');
      state_reg <= idle;
      dato_reg <= '0';
      dato2_reg <= '0';
elsif (clk'event and clk = '1') then 
      state_reg <= state_next;
      next_pipeline_step_reg <= next_pipeline_step_next;
      dato_reg <= dato_next;
      dato2_reg <= dato2_next;
      count_reg <= count_next;
      c_reg <= c_next;
end if;
end process; 
--next-state logic 
process(state_reg, dato_reg, data_max, count_max, dato_in, count_reg, c_reg, next_pipeline_step_reg, dato2_reg)
begin
count_next <= count_reg;
c_next <= c_reg;
state_next <= state_reg;
next_pipeline_step_next <= next_pipeline_step_reg;
dato_next <= dato_reg;
dato2_next <= dato2_reg;
case state_reg is
when idle  =>
     dato_next <= '0';
     dato2_next <= '0';
     next_pipeline_step_next <='0';
     count_next <= (others=>'0');
     c_next <= (others=>'0');
     state_next <= espera;
when espera =>
     next_pipeline_step_next <= '0';
     dato_next <= '0';
     dato2_next <= '0';
     if(dato_in = '1') then
        state_next <= s0;
     end if;
     next_pipeline_step_next <= '0';     
when s0 =>
next_pipeline_step_next <= '0';
if(c_reg < 2) then           --c_reg cuenta los dos primeros pulsos del pixel para indicar en la neurona si es cero y el signo
   c_next <= c_reg + 1;
end if;
if(count_reg(input_size downto 0) = count_max) then    --cuenta llega a 257 pasa un nuevo pixel y se reinicia la cuenta              
    if(count_reg(log2c(mult1) + input_size downto input_size + 1 )= mult1 - 1) then          --se pasa a una nueva multiplicación o se reinicia la cuenta
      if(count_reg(input_size + log2c(mult1) + log2c(pool2_size) downto log2c(mult1) + input_size + 1) = pool2_size - 1) then
         dato2_next <= '1';
         next_pipeline_step_next <= '1';
      else
         next_pipeline_step_next <= '1';
      end if;
      state_next <= espera;
      count_next <= count_reg + 27391;
    else
      count_next <= count_reg + 255;
      c_next <= (others=>'0');
      state_next <= espera;
   end if;
else
    if(count_reg(input_size  downto 0) = data_max) then     --pasamos el dato nuevo antes de que count llegue a count_max para tener el cuenta el retardo en producir la dirección que tiene Interfaz_Etapa
       if((count_reg(input_size + log2c(mult1) + log2c(pool2_size) downto log2c(mult1) + input_size + 1) = pool2_size - 1) and (count_reg(log2c(mult1) + input_size downto input_size + 1 )= mult1 - 1)) then
          dato_next <= '0';
       else
          dato_next <= '1';
       end if;
    else 
          dato_next <= '0';
    end if;
    count_next <= count_reg + 1;
end if;
end case;
end process;


--constantes
data_max <= (others => '1');
count_max <= ('0' & data_max)  + 2;
mul_max <=  (others => '1');        --cuenta máxima es igual al máximo tamaño de dato mas dos pulsos de cero y de signo
--output logic 
dato_out1 <= dato_reg;
dato_out2 <= dato2_reg;
count <= std_logic_vector(count_reg(input_size downto 0));
cont_s <= c_reg;
mul <= std_logic_vector(count_reg(log2c(mult1) + input_size downto input_size + 1 ));
next_pipeline_step <= next_pipeline_step_reg;    --e activa cuando el filtro halla multiplicado los datos de todas las capas

end Behavioral;
