----------------------------MODULO GENERADOR 3----------------------------
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
--index: señal que se le pasa al modulo relu para que transmita los datos almacenados
--en_neurona: señal que se mantiene a 1 cuando la neurona esta recibiendo datos, se pasa a un multiplexor en la salida del conversor par2ser porque
--este mandaría un pulso fuera de tiempo. 
--next_dato_pool: indica que hay un nuevo dato para procesar al modulo pool 
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

entity GEN3 is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
      mul: out std_logic_vector(log2c(mult3) - 1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      cont_s : out unsigned(1 downto 0);
      dato_out1 : out std_logic;
      dato_out2 : out std_logic;
      index : out std_logic;
      en_neurona : out std_logic;
      next_dato_pool : out std_logic;
      next_pipeline_step : out std_logic);
end GEN3;

architecture Behavioral of GEN3 is
type state_type is (idle , espera, s0);
signal state_reg, state_next : state_type;

--REGISTROS
signal index_reg, index_next : unsigned (log2c(pool3_size) + 1  downto 0);
signal count_reg, count_next: unsigned(input_size + log2c(mult3) + log2c(pool3_size) + log2c(number_of_layers3)  downto 0) :=  (others=>'0');
signal c_reg , c_next : unsigned ( 1 downto 0);
signal primera_vuelta_reg, primera_vuelta_next, next_dato_pool_reg, next_dato_pool_next, en_neurona_reg, en_neurona_next, next_pipeline_step_reg, next_pipeline_step_next,dato_reg, dato_next,  dato2_reg, dato2_next : std_logic := '0';

--CONSTANTES
signal data_max : unsigned(input_size - 1 downto 0):=  (others=>'0');
signal count_max  : unsigned(input_size  downto 0):=  (others=>'0');
signal mul_max : unsigned(log2c(mult3)- 1 downto 0):=  (others=>'0');
signal mult : integer := mult2;
signal number_of_layers : integer := number_of_layers2 ;
-- register 
begin
process(clk, rst) 
begin 
     if (rst = '1') then 
      count_reg <= (others=>'0');
      c_reg <= (others=>'0');
      index_reg <= (others=>'0');
      state_reg <= idle;
      next_dato_pool_reg <= '0';
      dato2_reg <= '0';
      primera_vuelta_reg <= '0';
      dato_reg <= '0';
     elsif (clk'event and clk = '1') then 
      index_reg <= index_next;
      state_reg <= state_next;
      dato_reg <= dato_next;
      dato2_reg <= dato2_next;
      next_dato_pool_reg <= next_dato_pool_next;
      next_pipeline_step_reg <= next_pipeline_step_next;
      en_neurona_reg <= en_neurona_next;
      primera_vuelta_reg <= primera_vuelta_next;
      if(index_reg > 4) then
      count_reg <= count_next;
      c_reg <= c_next;
      end if;
     end if; 
end process; 
--next-state logic 
process(state_reg, count_max, en_neurona_reg, index_reg, dato_in, count_reg, c_reg, next_dato_pool_reg, next_pipeline_step_reg, dato2_reg, primera_vuelta_reg, dato_reg, mult, number_of_layers)
begin
    count_next <= count_reg;
    c_next <= c_reg;
    en_neurona_next <= en_neurona_reg;
    index_next <= index_reg;
    state_next <= state_reg;
    next_dato_pool_next <= next_dato_pool_reg;
    next_pipeline_step_next <= next_pipeline_step_reg;
    dato2_next<= dato2_reg;
    primera_vuelta_next <= primera_vuelta_reg;
    dato_next <= dato_reg;
case state_reg is
when idle  =>
    next_dato_pool_next <= '0';
    next_pipeline_step_next <='0';
    en_neurona_next <= '0';
    index <= '0';
    count_next <= (others=>'0');
    c_next <= (others=>'0');
    index_next <= (others=>'0');
    state_next <= espera;
    dato2_next <= '0';
    primera_vuelta_next <= '1';
    dato_next<= '0';
when espera =>
     next_dato_pool_next <= '0';
     next_pipeline_step_next <= '0';
     en_neurona_next <= '0';
     index <= '0';
     dato2_next <= '0';
     dato_next <= '0';
     next_pipeline_step_next <= '0';
      if(dato_in = '1') then
         index_next <= (others=>'0');
         state_next <= s0;
     end if;
when s0 =>
    if(c_reg < 2) then                          --c_reg cuenta los dos primeros pulsos del pixel para indicar en la neurona si es cero y el signo
        c_next <= c_reg + 1;
    end if;
    
--NOTIFICACIÓN DATOS PROCESADOS
    
     if(count_reg = 0 and dato2_reg = '0' and primera_vuelta_reg = '0') then    --manda 1 si hay un dato disponible para la siguiente etapa
        dato2_next <= '1';
     else
        dato2_next <= '0';
     end if;
     if(count_reg(log2c(number_of_layers3) + input_size downto input_size + 1) = number_of_layers3 - 1 and count_reg(input_size downto 0) = count_max) then   --manda 1 si se ha procesado un dato en esta capa
        dato_next <= '1';
     else
        dato_next <= '0';
     end if;
     
--SEÑALES RELU Y POOL
 
if(index_reg /= pool3_size + 1) then   --la señal index se encarga de pasar los datos de la relu a la pool, cuenta hasta el número de ciclos igual al tamaño del filtro pool, y luego manda un 1 en la señal nex_dato_pool
   index_next <= index_reg + 1;
   if(index_reg < pool3_size) then
      index <= '1';
   else
      index <= '0';
   end if;
else 
   en_neurona_next <= '1';
   index <= '0';
   index_next <= index_reg;
end if;
if(index_reg = pool3_size - 1 and next_dato_pool_reg = '0' ) then       --señal que notifica al módulo MAXPOOL de que el dato está procesado
   next_dato_pool_next <= '1';
else
   next_dato_pool_next <= '0';
end if;

--SEÑALES CONV
if(count_reg(input_size downto 0) = count_max ) then   
   if( count_reg(log2c(number_of_layers3) + input_size downto input_size + 1) = number_of_layers3 - 1 ) then           
    if(count_reg(log2c(mult3)+ log2c(number_of_layers3) + input_size downto log2c(mult3)+ input_size)= mult3 - 1) then          --se pasa a una nueva multiplicación o se reinicia la cuenta
      if(count_reg(input_size + log2c(mult3) + log2c(number_of_layers3) + log2c(pool4_size) downto log2c(number_of_layers3) + log2c(mult3) + input_size + 1) = pool4_size - 1) then
          state_next <= espera;
          count_next <= count_reg + 57599; --sumamos 1 si es potencia de 2 y si no calculamos el número necesario para que sature al siguiente bit
       else
          count_next <= count_reg + 57599;  --sumamos 1 si es potencia de 2 y si no calculamos el número necesario para que sature al siguiente bit
          next_pipeline_step_next <= '1';
          state_next <= espera;
        end if;
     else
        state_next <= espera;
        count_next <= count_reg + 6399;      --sumamos 1 si es potencia de 2 y si no calculamos el número necesario para que sature al siguiente bit
     end if;
   else
    primera_vuelta_next <= '0';
    count_next <= count_reg + 255;     --sumamos 1 si es potencia de 2 y si no calculamos el número necesario para que sature al siguiente bit
    index_next <= (others=>'0');
    c_next <= (others=>'0');
    en_neurona_next <= '0';
    end if;
else
 count_next <= count_reg + 1;
end if;
end case;
end process;

--constantes 

data_max <= (others => '1');         --maximo valor que toma cuenta
count_max <= ('0' & data_max)  + 2;  --cuenta máxima es igual al máximo tamaño de dato mas dos pulsos que corresponden a cero y de signo
mul_max <=  (others => '1');         --maximo valor que toma mul
 
--output logic
count <= std_logic_vector(count_reg(input_size downto 0));
cont_s <= c_reg;
mul <= std_logic_vector(count_reg(log2c(number_of_layers3) + log2c(mult3) + input_size downto log2c(number_of_layers3) + input_size + 1 ));
capa <= std_logic_vector(count_reg(log2c(number_of_layers3)  + input_size downto  + input_size + 1 ));
next_pipeline_step <= next_pipeline_step_reg;
next_dato_pool <= next_dato_pool_reg;
en_neurona <= en_neurona_reg;
dato_out1 <= dato_reg;
dato_out2 <= dato2_reg;
end Behavioral;
