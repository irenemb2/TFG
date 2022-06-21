--------------------MODULO INTERFAZ ETAPA3----------------------
--Este modulo indica que dato de cada filtro de esta capa estamos procesando en este momento, 
--informando sobre la posicion de las columnas y filas de cada filtro de esta capa y de las posteriores
--Además informa sobre si el dato es 0 porque nos encontremos en zona padding o si es un dato de la matriz resultado de la capa anterior
--en cuyo caso informamos al generador de la capa anterior
--ENTRADAS
--dato_in : señal que inidica la necesidad de calcular un nuevo dato en esta capa
--poolx_col : señal que indica la posicion de las columnas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe
--poolx_row : señal que indica la posicion de las filas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe
--convx_col : señal que indica la posicion de las columnas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe
--convx_row : señal que indica la posicion de las filas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe
--SALIDAS
--dato_cero : señal que indica si el dato a procesar esta en zona padding o no, se le pasa al generador de esta misma capa
--cero : señal que se mantiene a 1 o a cero dependiendo si el dato a procesar esta en zona padding o no, se le pasa a un multiplexador a la entrada del conversor par2ser
--dato_out : señal que indica si es necesario un nuevo dato, se le pasa al generador de la capa anterior
--poolx_col : señal que indica la posicion de las columnas del filtro pool de esta capa , si no hay otra capa esta señal de entrada no existe
--poolx_row : señal que indica la posicion de las filas del filtro pool de esta capa , si no hay otra capa esta señal de entrada no existe
--convx_col : señal que indica la posicion de las columnas del filtro de convolucion de esta capa , si no hay otra capa esta señal de entrada no existe
--convx_row : señal que indica la posicion de las filas del filtro de convolucion de esta capa , si no hay otra capa esta señal de entrada no existe


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.tfg_irene_package.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Interfaz_ET3 is
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      dato_cero : out std_logic;
      cero : out std_logic;
      dato_out : out std_logic;
      conv3_col : out unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : out unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : out unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : out unsigned(log2c(pool4_row) - 1 downto 0));    
end Interfaz_ET3;

architecture Behavioral of Interfaz_ET3 is
type state_type is (idle , espera, s0);
signal state_reg, state_next : state_type;
signal col_reg, col_next : unsigned(log2c(column_size3 + 2*(conv3_padding)) - 1 downto 0) := (others => '0');
signal row_reg, row_next :  unsigned(log2c(row_size3 + 2*(conv3_padding)) - 1 downto 0) := (others => '0');
--TERCERA CAPA
signal conv3_col_reg, conv3_col_next : unsigned(log2c(conv3_column) - 1 downto 0) := (others => '0');
signal conv3_row_reg, conv3_row_next : unsigned(log2c(conv3_row) - 1 downto 0) := (others => '0');
--CUARTA CAPA
signal pool4_col_reg, pool4_col_next : unsigned(log2c(pool4_column) - 1 downto 0) := (others => '0');
signal pool4_row_reg, pool4_row_next : unsigned(log2c(pool4_row) - 1 downto 0) := (others => '0');
--CONSTANTES
signal column_limit, row_limit, stride1, stride2, stride3, stride4, stride5, stride6 : integer;
signal primera_vuelta_reg, primera_vuelta_next, cero_reg, cero_next : std_logic;
begin
--control path: state register
process(clk, reset) 
begin 
if (reset = '1') then 
    state_reg <= idle;
elsif (clk'event and clk = '1') then 
     state_reg <= state_next;
     col_reg <= col_next;
     row_reg <= row_next;
     conv3_col_reg <= conv3_col_next;
     conv3_row_reg <= conv3_row_next;
     pool4_col_reg <= pool4_col_next;
     pool4_row_reg <= pool4_row_next;
     primera_vuelta_reg <= primera_vuelta_next;
     cero_reg <= cero_next;

end if; 
end process;
 -- data path : routing multiplexer
 process ( cero_reg, primera_vuelta_reg, state_reg, row_limit, column_limit,conv3_col_reg, conv3_row_reg, pool4_col_reg, pool4_row_reg, row_reg, col_reg, dato_in, col_next, row_next)
variable stride, stride1 : integer;
variable col_resta, col_resta1 : integer;
variable row_resta, row_resta1 : integer;
 begin
     state_next <= state_reg;
     col_next <= col_reg;
     row_next <= row_reg;
     conv3_col_next <= conv3_col_reg;
     conv3_row_next <= conv3_row_reg;
     pool4_col_next <= pool4_col_reg;
     pool4_row_next <= pool4_row_reg;
     primera_vuelta_next <= primera_vuelta_reg;
     cero_next <= cero_reg;
 case state_reg is 
 when idle =>           
   dato_out <= '0';    
   dato_cero <= '0';                     
   col_next  <= (others => '0');
   row_next  <= (others => '0');
   conv3_col_next  <= (others => '0');
   conv3_row_next  <= (others => '0');
   pool4_col_next <= (others => '0');
   pool4_row_next  <= (others => '0');  
   primera_vuelta_next <= '1';     
   state_next <= espera;
   cero_next <= '0';
when espera => 
   dato_out <= '0';
   
   dato_cero <= '0';
   if(dato_in = '1') then
      state_next <= s0;
   end if;
when s0 => 
if(primera_vuelta_reg = '1' ) then
        dato_cero <= '1';
        cero_next <= '1';
        state_next <= espera;
        primera_vuelta_next <= '0';
        dato_out <= '0';
        else
        if (conv3_col_reg /= conv3_column - 1) then     --si no ha terminado de recorrer el tamaño del filtro sumamos uno a las columnas
             stride := conv3_stride;
             col_resta := conv3_column - 1;
             row_resta := conv3_row - 1;
             col_next <= col_reg + stride;
             conv3_col_next <= conv3_col_reg + 1;
        else
             conv3_col_next <= (others => '0');
             if (conv3_row_reg /= (conv3_row - 1)) then       --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
                  col_next <= col_reg - col_resta;
                  row_next <= row_reg + stride;
                  conv3_row_next <= conv3_row_reg + 1;
             else
                  conv3_row_next <= (others => '0');  
                  if (pool4_col_reg /= pool4_column - 1) then       --devolvemos los valores originales a las columnas y las filas y le sumamos el stride
                      row_next <= row_reg- row_resta;     
                      col_next <= col_reg - col_resta + stride;
                      pool4_col_next <= pool4_col_reg + 1;
                  else
                      pool4_col_next <= (others => '0');
                      col_resta1 := col_resta + (stride * (pool4_row - 1));
                      if (pool4_row_reg /= (pool4_row - 1)) then      -- restamos las columnas del filtro actual * el stride del filtro anterior = (numero total de columnas recorridas)
                          row_next <= row_reg- row_resta  + stride;
                          col_next <= col_reg- col_resta1;    
                          pool4_row_next <= pool4_row_reg + 1;
                      else
                         pool4_row_next <= (others => '0'); 
                         --REPETIMOS TANTAS VECES COMO FILTROS HAYA EN LA RED (A PARTIR DEL FILTRO DE ESTA ETAPA)
                         row_resta1 := row_resta + (stride * (pool4_row - 1));
                         stride1 := stride * pool4_stride;
                         if(col_reg /= column_limit - 1) then
                           row_next <= row_reg - row_resta1;
                           col_next <= col_reg - col_resta1 + stride1;   
                        else 
                            row_next <= row_reg - row_resta1 + stride1;
                            col_next <= (others => '0');
                            if(row_reg = row_limit - 1) then
                               row_next <= (others => '0');
                            end if;
                       end if;
                    end if;
                 end if;
              end if;
        end if;
        if(conv3_padding > col_next or col_next >= column_size3 + conv3_padding or conv3_padding > row_next or row_next >= column_size3 + conv3_padding ) then
           dato_out <= '0';
           dato_cero <= '1';
           cero_next <= '1';
           state_next <= espera;
        else 
           dato_out <= '1';
           dato_cero <= '0';
           cero_next <= '0';
           state_next <= espera;
        end if;
state_next <= espera;
end if;
end case;
end process;

 -- constantes
column_limit<= column_size3 + 2*(conv3_padding);    --tenemos en cuenta el padding para los valores limites de columnas y filas
row_limit<= row_size3  + 2*(conv3_padding);
--stride1 <= conv3_stride;
--stride2 <= stride1 * pool4_stride;


 -- señales de salida
conv3_col <= conv3_col_reg;
conv3_fila <= conv3_row_reg;
pool4_col <= pool4_col_reg;
pool4_fila <= pool4_row_reg;
cero <= cero_reg;
end Behavioral;
