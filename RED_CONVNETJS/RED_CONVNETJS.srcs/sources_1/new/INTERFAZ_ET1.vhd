--------------------MODULO INTERFAZ ETAPA1----------------------
--Este modulo indica la dirección del dato de la RAM de entrada que necesitamos, el funcionamiento es identico
--a las interfaces de las otras etapas pero en este caso también se calcula la dirección, además no mandamos dato_cero
--por que el generador de esta etapa tendrá que procesaro un dato independientemente de si es cero o si proviene de la RAM
--ENTRADAS
--dato_in : señal que inidica la necesidad de calcular un nuevo dato en esta capa
--poolx_col : señal que indica la posicion de las columnas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe
--poolx_row : señal que indica la posicion de las filas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe
--convx_col : señal que indica la posicion de las columnas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe
--convx_row : señal que indica la posicion de las filas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe
--SALIDAS
--cero : señal que se mantiene a 1 o a cero dependiendo si el dato a procesar esta en zona padding o no, se le pasa a un multiplexador a la entrada del conversor par2ser
--dato_out : señal que indica si es necesario un nuevo dato, se le pasa al generador de la capa anterior
--address : dirección del dato necesario en la RAM
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
entity Interfaz_ET1 is
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      conv2_col : in unsigned(log2c(conv2_column) - 1 downto 0);
      conv2_fila : in  unsigned(log2c(conv2_row) - 1 downto 0);
      pool3_col : in unsigned(log2c(pool3_column) - 1 downto 0);
      pool3_fila : in  unsigned(log2c(pool3_row) - 1 downto 0);
      conv3_col : in unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : in  unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : in unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : in unsigned(log2c(pool4_row) - 1 downto 0);
      dato_out : out std_logic;
      cero : out std_logic;
      address : out std_logic_vector(log2c(number_of_inputs + 1) - 1 downto 0));
end Interfaz_ET1;

architecture Behavioral of Interfaz_ET1 is
type state_type is (idle , espera, s0, s1);
signal state_reg, state_next : state_type;
signal col_reg, col_next : unsigned(log2c(column_size + 2*(conv1_padding)) - 1 downto 0) := (others => '0');
signal row_reg, row_next :  unsigned(log2c(row_size + 2*(conv1_padding)) - 1 downto 0) := (others => '0');
-- CAPA 1
signal conv1_col_reg, conv1_col_next : unsigned(log2c(conv1_column) - 1 downto 0) := (others => '0');
signal conv1_row_reg, conv1_row_next : unsigned(log2c(conv1_row) - 1 downto 0) := (others => '0');
signal cuenta_capa_reg, cuenta_capa_next :  unsigned(log2c(number_of_layers1) - 1 downto 0) := (others => '0');
-- CAPA 2
signal pool2_col_reg, pool2_col_next : unsigned(log2c(pool2_column) - 1 downto 0) := (others => '0');
signal pool2_row_reg, pool2_row_next : unsigned(log2c(pool2_row) - 1 downto 0) := (others => '0');
--REGISTROS
signal address_reg , address_next :  unsigned(log2c(number_of_inputs + 1) - 1 downto 0) := (others => '0');
signal address2_reg , address2_next :  unsigned(log2c(number_of_inputs + 1) - 1 downto 0) := (others => '0');
signal address2 : unsigned ( 11 downto 0):= (others => '0');
signal primera_vuelta_reg, primera_vuelta_next, dato_out_reg, dato_out_next, cero_reg, cero_next : std_logic := '0';
--CONSTANTES
signal column_limit, row_limit : integer;
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
     pool2_col_reg <= pool2_col_next;
     pool2_row_reg <= pool2_row_next;
     conv1_col_reg <= conv1_col_next;
     conv1_row_reg <= conv1_row_next;
     cuenta_capa_reg <= cuenta_capa_next;
     address_reg <= address_next;
     address2_reg <= address2_next;
     primera_vuelta_reg <= primera_vuelta_next;
     dato_out_reg <= dato_out_next;
     cero_reg <= cero_next;
end if; 
end process;
 -- data path : routing multiplexer
 process (dato_in1,cero_reg, address_next, cuenta_capa_next, row_limit, column_limit,  address_reg, address2_reg, dato_out_reg, conv1_col_reg, conv1_row_reg,conv2_col, conv2_fila, pool2_col_reg, pool2_row_reg, conv3_col, conv3_fila, pool3_col, pool3_fila, pool4_col, pool4_fila, row_reg, col_reg, dato_in, cuenta_capa_reg, col_next, row_next, primera_vuelta_reg, state_reg)
variable stride1, stride2, stride3, stride4, stride5, stride6 : natural;
variable col_resta1, col_resta2, col_resta3, col_resta4, col_resta5, col_resta6 : natural;
variable row_resta1, row_resta2, row_resta3, row_resta4, row_resta5, row_resta6 : natural;
begin
     state_next <= state_reg;
     col_next <= col_reg;
     row_next <= row_reg;
     conv1_col_next <= conv1_col_reg;
     conv1_row_next <= conv1_row_reg;
     cuenta_capa_next <= cuenta_capa_reg;
     pool2_col_next <= pool2_col_reg;
     pool2_row_next <= pool2_row_reg;
     address_next <= address_reg;
     address2_next <= address2_reg;
     primera_vuelta_next <= primera_vuelta_reg;
     dato_out_next <= dato_out_reg;
     cero_next <= cero_reg;
 case state_reg is 
 when idle =>                                    
     col_next  <= (others => '0');
     row_next  <= (others => '0');
     conv1_col_next <= (others => '0');
     conv1_row_next  <= (others => '0');
     cuenta_capa_next  <= (others => '0');
     pool2_col_next  <= (others => '0');
     pool2_row_next  <= (others => '0');
     address_next  <= (others => '0');
     address2_next  <= (others => '0'); 
     cero_next <= '0'; 
     primera_vuelta_next <= '0';   
     dato_out_next <= '0';   
     state_next <= espera;

when espera => 

 dato_out_next <= '0';
 if(dato_in = '1') then
    state_next <= s0;
 end if;
 
when s0 => 

dato_out_next <= '0';
  if(primera_vuelta_reg = '0') then
   primera_vuelta_next <= '1';
   state_next <= s1;
   cero_next <= '1';
   else
 if (conv1_col_reg /= conv1_column - 1) then     --si no ha terminado de recorrer las columnas del primer filtro de convolucion sumamos uno a las columnas
     stride1 := 1;
     col_resta1 := conv1_column-1;
     row_resta1 := conv1_row - 1;
     col_next <= col_reg + stride1;
     conv1_col_next <= conv1_col_reg + 1;
     address_next <= address_reg + stride1; 
 else
     conv1_col_next <= (others => '0');
   if (conv1_row_reg /= (conv1_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas
      col_next <= col_reg - col_resta1;
      row_next <= row_reg + stride1;
      conv1_row_next <= conv1_row_reg + 1;
      address_next <= address_reg - col_resta1 + stride1*row_size;
   else
      conv1_row_next <= (others => '0');         --repetimos para el número de capas que tenga nuestra imagen de entrada
      if(cuenta_capa_reg /= number_of_layers1 - 1) then 
       address_next <= address_reg - (row_size * row_resta1 ) - col_resta1;
       cuenta_capa_next <= cuenta_capa_reg + 1;  
       col_next <= col_reg - col_resta1;
       row_next<= row_reg - row_resta1;
     else
        cuenta_capa_next <=(others => '0');     
        if (pool2_col_reg /= pool2_column - 1) then      --si ha terminado de recorrer el tamaño del filtro en todas las capas, avanzamos el filtro un valor = a stride, tantas veces como columnas tenga el filtro siguiente
           row_next <= row_reg- row_resta1;
           col_next <= col_reg- col_resta1 + stride1;
           pool2_col_next <= pool2_col_reg + 1;
           address_next <= address_reg - (row_size * row_resta1 ) - col_resta1 + stride1;
       else
       pool2_col_next <= (others => '0');
       if (pool2_row_reg /= (pool2_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos stride a las filas y devolvemos el valor original a las columnas
         col_resta2 := col_resta1 + (stride1 * (pool2_column - 1));
         row_next <= row_reg- row_resta1 + stride1;
         col_next <= col_reg- col_resta1;    -- restamos las columnas del filtro actual * el stride del filtro anterior = (numero total de columnas recorridas)
         pool2_row_next <= pool2_row_reg + 1;
         address_next <= address_reg - (row_size * row_resta1 ) - col_resta2 + (row_size * stride1 );
      else
        pool2_row_next <= (others => '0');          --REPETIMOS TANTAS VECES COMO FILTROS HAYA EN LA RED
        row_resta2 := row_resta1 + (stride1 * (pool2_row - 1));
         if (conv2_col /= conv2_column - 1) then   
             stride2 := stride1 * pool2_stride;
             row_next <= row_reg - row_resta2;
             col_next <= col_reg - col_resta2 + stride2;   
             address_next <= address_reg - (row_size * row_resta2 ) - col_resta2 + stride2;
         else
             if (conv2_fila /= (conv2_row - 1)) then    
              col_resta3:= col_resta2 + (stride2 * (conv2_column-1));
               row_next <= row_reg - row_resta2 + stride2;
               col_next <= col_reg - col_resta2;
                address_next <= address_reg - (row_size * row_resta2 ) - col_resta3   + (row_size*stride3);
             else 
                row_resta3 := row_resta2 + (stride2 * (conv2_row-1));   
                if (pool3_col /= pool3_column - 1) then  
                    stride3 := stride2 * conv2_stride; 
                    row_next <= row_reg- row_resta3;
                    col_next <= col_reg - col_resta3 + stride3;
                    address_next <=  address_reg - (row_size * row_resta3) - col_resta3 + stride3;
                else
                    if (pool3_fila /= (pool3_row - 1)) then    
                         col_resta4:= col_resta3 + (stride3 * (pool3_column-1));
                         row_next <= row_reg - row_resta3 + stride3;
                         col_next <= col_reg - col_resta4;
                        address_next <= address_reg - (row_size * row_resta3 ) - col_resta4  + (row_size*stride3);
                   else
                         row_resta4 := row_resta3 + (stride3 * (pool3_row - 1));
                         if (conv3_col /= conv3_column - 1) then  
                         stride4 := stride3 * pool3_stride;
                         row_next <= row_reg - row_resta4;
                         col_next <= col_reg - col_resta4 + stride4;
                         address_next <= address_reg - (row_size * row_resta4) - col_resta4  + stride4;
                          else
                         if (conv3_fila /= (conv3_row - 1)) then    
                            col_resta5 := col_resta4 + (stride4 * (conv3_column-1));
                            row_next <= row_reg - row_resta4 + stride4;
                            col_next <= col_reg - col_resta5;
                            address_next <= address_reg - (row_size * row_resta4 ) - col_resta5  + (row_size*stride4);
                         else
                           row_resta5 := row_resta4 +  (stride4 * (conv3_row - 1));
                           if (pool4_col /= pool4_column - 1) then  
                           stride5 := stride4 * conv3_stride;
                            row_next <= row_reg- row_resta5;
                            col_next <= col_reg- col_resta5 + stride5;
                            address_next <= address_reg - (row_size * row_resta5 ) - col_resta5 + stride5;
                           else
                             if (pool4_fila /= (pool4_row - 1)) then 
                              col_resta6 := col_resta5 + (stride5 * (pool4_row - 1));   
                              row_next <= row_reg - row_resta5 + stride5;
                              col_next <= col_reg - col_resta6;
                              address_next <= address_reg - (row_size * row_resta5 ) - col_resta6  + (row_size*stride5);
                               else
                               row_resta6 := row_resta5 +  (stride5 * (conv3_row - 1));
                                if(col_reg /= column_limit - 1) then
                                   stride6 := stride5 * pool4_stride; 
                                   row_next <= row_reg - row_resta6;
                                   col_next <= col_reg- col_resta6 + stride6;
                                   address_next <= address_reg - (row_size * row_resta6 ) - col_resta6  + stride6;
                                else 
                                   row_next <= row_reg - row_resta6 + stride6;
                                   col_next <= (others => '0');
                                   address_next <= address_reg - (row_size * row_resta6) - col_resta6  + (row_size*stride6);
                                   if(row_reg = row_limit) then
                                      row_next <= (others => '0');
                                      address_next <=(others => '0');
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
               end if;
             end if;
           end if;
        end if;
     end if;
if(conv1_padding > col_next or col_next >= column_size + conv1_padding or conv1_padding > row_next or row_next >= column_size + conv1_padding ) then
cero_next <= '1';
else 
cero_next <= '0';
address2_next <= address_next - (conv1_padding + (row_size * conv1_padding) + ( 2 * conv1_padding * (row_next - conv1_padding))) + (cuenta_capa_next & "0000000000");
end if;
state_next <= s1;
end if;
when s1 =>
state_next <= espera;
dato_out_next <= '1';
end case;
end process;

 -- constantes
column_limit<= column_size + 2*(conv1_padding);    --tenemos en cuenta el padding para los valores limites de columnas y filas
row_limit<= row_size  + 2*(conv1_padding);

 -- señales de salida
address <= std_logic_vector(address2_reg);
dato_out <= dato_out_reg;
cero <= cero_reg;
end Behavioral;
