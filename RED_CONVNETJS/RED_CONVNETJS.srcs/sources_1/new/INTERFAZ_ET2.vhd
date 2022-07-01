--------------------MODULO INTERFAZ ETAPA2----------------------
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

entity Interfaz_ET2 is
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      dato_out : out std_logic;
      dato_cero : out std_logic;
      cero : out std_logic;
      conv2_col : out unsigned(log2c(conv2_column) - 1 downto 0);
      conv2_fila : out  unsigned(log2c(conv2_row) - 1 downto 0);
      pool3_col : out unsigned(log2c(pool3_column) - 1 downto 0);
      pool3_fila : out  unsigned(log2c(pool3_row) - 1 downto 0);
      conv3_col : in unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : in  unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : in unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : in unsigned(log2c(pool4_row) - 1 downto 0));
end Interfaz_ET2;

architecture Behavioral of Interfaz_ET2 is
type state_type is (idle , espera, s0);
signal state_reg, state_next : state_type;
signal col_reg, col_next : unsigned(log2c(column_size2 + 2*(conv2_padding)) - 1 downto 0) := (others => '0');
signal row_reg, row_next :  unsigned(log2c(row_size2 + 2*(conv2_padding)) - 1 downto 0) := (others => '0');
--SEGUNDA CAPA
signal conv2_col_reg, conv2_col_next : unsigned(log2c(conv2_column) - 1 downto 0) := (others => '0');
signal conv2_row_reg, conv2_row_next : unsigned(log2c(conv2_row) - 1 downto 0) := (others => '0');
--TERCERA CAPA
signal pool3_col_reg, pool3_col_next : unsigned(log2c(pool3_column) - 1 downto 0) := (others => '0');
signal pool3_row_reg, pool3_row_next : unsigned(log2c(pool3_row) - 1 downto 0) := (others => '0');
signal primera_vuelta_reg, primera_vuelta_next, cero_reg, cero_next: std_logic;
signal column_limit, row_limit, stride1, stride2, stride3, stride4: integer;
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
     conv2_col_reg <= conv2_col_next;
     conv2_row_reg <= conv2_row_next;
     pool3_col_reg <= pool3_col_next;
     pool3_row_reg <= pool3_row_next;
     primera_vuelta_reg <= primera_vuelta_next;
     cero_reg <= cero_next;

end if; 
end process;
 -- data path : routing multiplexer
 process (cero_reg, stride1, stride2,stride3, stride4, row_limit, column_limit,  state_reg, primera_vuelta_reg, conv2_col_reg, conv2_row_reg, conv3_col, conv3_fila, pool3_col_reg, pool3_row_reg, pool4_col, pool4_fila, row_reg, col_reg, dato_in, col_next, row_next)

 begin
     state_next <= state_reg;
     col_next <= col_reg;
     row_next <= row_reg;
     conv2_col_next <= conv2_col_reg;
     conv2_row_next <= conv2_row_reg;
     pool3_col_next <= pool3_col_reg;
     pool3_row_next <= pool3_row_reg;
     primera_vuelta_next <= primera_vuelta_reg;
     cero_next <= cero_reg;
 case state_reg is 
 when idle =>                                    
   col_next  <= (others => '0');
   row_next  <= (others => '0');
   conv2_col_next  <= (others => '0');
   conv2_row_next <= (others => '0');
   pool3_col_next <= (others => '0');
   pool3_row_next  <= (others => '0');   
   primera_vuelta_next <= '1';
   state_next <= espera;
   dato_out <= '0';
   dato_cero <= '1';
   cero_next <= '0';
when espera => 
   dato_cero <= '0';
   dato_out <= '0';
 if(dato_in = '1') then
    state_next <= s0;
 end if;
when s0 => 
   if(primera_vuelta_reg = '1' ) then
        dato_cero <= '1';
        state_next <= espera;
        primera_vuelta_next <= '0';
        dato_out <= '0';
        cero_next <= '1';

        else
         if (conv2_col_reg /= conv2_column - 1) then     --si no ha terminado de recorrer el tamaño del filtro sumamos uno a las columnas
             col_next <= col_reg + stride1;
             conv2_col_next <= conv2_col_reg + 1;
         else
             conv2_col_next <= (others => '0');
             if (conv2_row_reg /= (conv2_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
              col_next <= col_reg - (conv2_column-1);
              row_next <= row_reg + stride1;
              conv2_row_next <= conv2_row_reg + 1;
             else
                conv2_row_next <= (others => '0');  
                if (pool3_col_reg /= pool3_column - 1) then     --si no ha terminado de recorrer el tamaño del filtro sumamos uno a las columnas
                    row_next <= row_reg - (conv2_row - 1);
                    col_next <= col_reg- (conv2_column-1) + stride1;
                    pool3_col_next <= pool3_col_reg + 1;
                else
                    pool3_col_next <= (others => '0');

                    if (pool3_row_reg /= (pool3_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
                         row_next <= row_reg - (conv2_row - 1)+ stride1 ;
                         col_next <= col_reg - (conv2_column-1)- (stride1* (pool3_column - 1));    -- restamos las columnas del filtro actual * el stride del filtro anterior = (numero total de columnas recorridas)
                         pool3_row_next <= pool3_row_reg + 1;
                   else
                         pool3_row_next <= (others => '0'); 
                         if (conv3_col /= conv3_column - 1) then     --si no ha terminado de recorrer el tamaño del filtro sumamos uno a las columnas
                        row_next <= row_reg - (conv2_row - 1) - (stride1* (pool3_row - 1));
                        col_next <= col_reg - (conv2_column-1)- (stride1* (pool3_column - 1)) + stride2;   
                        else
                         if (conv3_fila /= (conv3_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
                            row_next <= row_reg - (conv2_row - 1) - (stride1* (pool3_row - 1)) + stride2;
                            col_next <= col_reg - (conv2_row - 1) - (stride1* (pool3_row - 1))-(stride2 * (conv3_column-1));
                           else 
                           if (pool4_col /= pool4_column - 1) then     --si no ha terminado de recorrer el tamaño del filtro sumamos uno a las columnas
                           row_next <= row_reg - (conv2_row - 1) - (stride1* (pool3_row - 1)) - (stride2 * (conv3_row-1));
                           col_next <= col_reg -(conv2_row - 1) - (stride1* (pool3_row - 1))-(stride2 * (conv3_column-1))+ stride3;
                            else
                             if (pool4_fila /= (pool4_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
                              row_next <= row_reg - (conv2_row - 1) - (stride1* (pool3_row - 1)) - (stride2 * (conv3_row-1)) + stride3;
                              col_next <= col_reg - (conv2_row - 1) - (stride1* (pool3_row - 1))-(stride2 * (conv3_column-1)) - (stride3 * (pool4_column-1));
                                 else
                                if(col_reg /= column_limit - 1) then
                                  row_next <= row_reg - (conv2_row - 1) - (stride1* (pool3_row - 1)) - (stride2 * (conv3_row-1))- (stride4 * (pool4_row - 1)) ;
                                  col_next <= col_reg- (conv2_row - 1) - (stride1* (pool3_row - 1))-(stride2 * (conv3_column-1)) - (stride3 * (pool4_column-1)) + stride4;
                                 else 
                                  row_next <= row_reg- (conv2_row - 1) - (stride1* (pool3_row - 1)) - (stride2 * (conv3_row-1))- (stride4 * (pool4_row - 1)) + stride4;
                                  col_next <= (others => '0');
                                   if(row_reg = row_limit) then
                                      row_next <= (others => '0');
                               end if;
                           end if;
                       end if;
                   end if;
                 end if;
               end if;
             end if;
           end if;
        end if;
     end if;
if(conv2_padding > col_next or col_next >= column_size2 + conv2_padding or conv2_padding > row_next or row_next >= column_size2 + conv2_padding ) then
dato_out <= '0';
dato_cero <= '1';
cero_next <= '1';
else 
dato_out<= '1';
dato_cero <= '0';
cero_next <= '0';
end if;
state_next <= espera;
end if;
end case;
end process;

 -- constantes
column_limit<= column_size2 + 2*(conv2_padding);    --tenemos en cuenta el padding para los valores limites de columnas y filas
row_limit<= row_size2  + 2*(conv2_padding);
stride1 <= conv2_stride;
stride2 <= stride1 * pool3_stride;
stride3 <= stride2 * conv3_stride;
stride4 <= stride3 * pool3_stride;

 -- señales de salida
conv2_col <= conv2_col_reg;
conv2_fila <= conv2_row_reg;
pool3_col <= pool3_col_reg;
pool3_fila <= pool3_row_reg;
cero <= cero_reg;
end Behavioral;
