----------------------------MODULO GENERADOR 4----------------------------
--Este modulo se encarga de producir todas las señales de control de su capa, que permiten sincronizar el funcionamiento de todos los modulos
--ENTRADAS
--dato_in : indica que hay un dato a procesar en la capa
--SALIDAS
--capa : indica la capa de la matriz resultado de la etapa anterior que estamos procesando en este momento
--dato_out :  señal que notifica de que se ha terminado de procesar un dato en esta capa
--index: señal que se le pasa al modulo relu para que transmita los datos almacenados
--next_dato_pool: indica que hay un nuevo dato para procesar al modulo pool 

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

entity GEN4 is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      dato_out : out std_logic;
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers4) - 1 downto 0);
      index : out std_logic;
      next_dato_pool : out std_logic);
end GEN4;

architecture Behavioral of GEN4 is
type state_type is (idle , espera, s0);
signal state_reg, state_next : state_type;
--REGISTROS
signal index_reg, index_next : unsigned (log2c(pool4_size) + 1  downto 0);
signal count_reg, count_next : unsigned(log2c(number_of_layers4) - 1 downto 0) := (others=> '0');
signal next_dato_pool_reg, next_dato_pool_next, dato_reg, dato_next: std_logic := '0';
-- register 
begin
process(clk, rst) 
begin 
     if (rst = '1') then 
      index_reg <= (others=>'0');
      state_reg <= idle;
      next_dato_pool_reg <= '0';
      dato_reg <= '0';
     elsif (clk'event and clk = '1') then 
      index_reg <= index_next;
      state_reg <= state_next;
      dato_reg <= dato_next;
      next_dato_pool_reg <= next_dato_pool_next;
      if(index_reg > pool4_size) then
         count_reg <= count_next;
      end if;
     end if; 
end process; 
--next-state logic 
process(state_reg, index_reg, dato_in, count_reg, next_dato_pool_reg, dato_reg)
begin
    count_next <= count_reg;
    index_next <= index_reg;
    state_next <= state_reg;
    next_dato_pool_next <= next_dato_pool_reg;
    dato_next <= dato_reg;
case state_reg is
when idle  =>
    next_dato_pool_next <= '0';
    index <= '0';
    count_next <= (others=>'0');
    index_next <= (others=>'0');
    dato_next <= '0';
    state_next <= espera;
when espera =>
     next_dato_pool_next <= '0';
     dato_next <= '0';
     index <= '0';
     if(dato_in = '1') then
     index_next <= (others=>'0');
     state_next <= s0;
     end if;    
when s0 =>
--SEÑALES RELU Y POOL
if(index_reg /= pool4_size + 1) then
   dato_next <= '0';
   index_next <= index_reg + 1;
   if(index_reg < pool4_size) then
      index <= '1';
      if(index_reg = pool4_size - 1 and next_dato_pool_reg = '0' ) then
         next_dato_pool_next <= '1';
      else
         next_dato_pool_next <= '0';
     end if;
   else
      index <= '0';
   end if;
else 
   index <= '0';
   index_next <= index_reg;
end if;
--SEÑALES MULTIPLEXOR
if(count_reg = number_of_layers4 - 1) then
   count_next <= (others => '0');
   dato_next <= '1';
   state_next <= espera;
elsif(count_reg = 1) then                   
   index_next <= (others=>'0');
   count_next <= count_reg + 1;
else
   count_next <= count_reg + 1;
end if;

end case;
end process;
--constantes
--output logic
capa <= std_logic_vector(count_reg);
next_dato_pool <= next_dato_pool_reg;
dato_out <= dato_reg;
end Behavioral;
