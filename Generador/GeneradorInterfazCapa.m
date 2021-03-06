function [] = GeneradorInterfazCapa(num, capas)
        num_variables = (2 * ((capas ) - num));
        name = sprintf('Interfaz_ET%d.vhd', num);
        fid = fopen(name, 'wt');
        fprintf(fid,'--------------------MODULO INTERFAZ ETAPA%d---------------------\n', num);
        fprintf(fid,'--Este modulo indica que dato de cada filtro de esta capa estamos procesando en este momento, \n');
        fprintf(fid,'--informando sobre la posicion de las columnas y filas de cada filtro de esta capa y de las posteriores\n');
        fprintf(fid,'--Además informa sobre si el dato es 0 porque nos encontremos en zona padding o si es un dato de la matriz resultado de la capa anterior\n');
        fprintf(fid, ' --en cuyo caso informamos al generador de la capa anterior\n');
        fprintf(fid,'--ENTRADAS\n');
        fprintf(fid,'--dato_in : señal que inidica la necesidad de calcular un nuevo dato en esta capa\n');
        fprintf(fid,'--poolx_col : señal que indica la posicion de las columnas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid,'--poolx_row : señal que indica la posicion de las filas del filtro pool de las capa siguientes, si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid,'--convx_col : señal que indica la posicion de las columnas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid,'--convx_row : señal que indica la posicion de las filas del filtro de convolucion de la capa siguientes, si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid,'--SALIDAS\n');
        fprintf(fid,'--cero : señal que se mantiene a 1 o a cero dependiendo si el dato a procesar esta en zona padding o no, se le pasa a un multiplexador a la entrada del conversor par2ser\n');
        fprintf(fid,'--dato_out : señal que indica si es necesario un nuevo dato, se le pasa al generador de la capa anterior\n');
        fprintf(fid, '--poolx_col : señal que indica la posicion de las columnas del filtro pool de esta capa , si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid, '--poolx_row : señal que indica la posicion de las filas del filtro pool de esta capa , si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid, '--convx_col : señal que indica la posicion de las columnas del filtro de convolucion de esta capa , si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid, '--convx_row : señal que indica la posicion de las filas del filtro de convolucion de esta capa , si no hay otra capa esta señal de entrada no existe\n');
        fprintf(fid,'library IEEE;\n');
        fprintf(fid,'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid,'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid,'entity INTERFAZ_ET%d is\n', num);
        fprintf(fid,'Port (clk : in STD_LOGIC;\n');
        fprintf(fid,'      reset : in STD_LOGIC;\n');
        fprintf(fid,'      dato_in : in std_logic;\n');
        fprintf(fid,'      dato_out : out std_logic;\n');
        fprintf(fid,'      cero : out std_logic;\n');
        fprintf(fid,'      dato_cero : out std_logic;\n');
        for i = (num + 1) : capas - 1
        fprintf(fid,'      conv%d_col : in unsigned(log2c(conv%d_column) - 1 downto 0);\n', i, i);
        fprintf(fid,'      conv%d_fila : in  unsigned(log2c(conv%d_row) - 1 downto 0);\n', i, i);
        fprintf(fid,'      pool%d_col : in unsigned(log2c(pool%d_column) - 1 downto 0);\n', i+1, i+1);
        fprintf(fid,'      pool%d_fila : in  unsigned(log2c(pool%d_row) - 1 downto 0);\n', i+1, i+1);
        end
        for i = num : num+1
        fprintf(fid,'      conv%d_col : out unsigned(log2c(conv%d_column) - 1 downto 0);\n', i, i);
        fprintf(fid,'      conv%d_fila : out  unsigned(log2c(conv%d_row) - 1 downto 0);\n', i, i);
        fprintf(fid,'      pool%d_col : out unsigned(log2c(pool%d_column) - 1 downto 0);\n', i+1, i+1);
        fprintf(fid,'      pool%d_fila : out  unsigned(log2c(pool%d_row) - 1 downto 0);\n', i+1, i+1);
        end
        fprintf(fid,'end Interfaz_ET%d;\n', num);
        fprintf(fid,'architecture Behavioral of Interfaz_ET%d is\n', num);
         fprintf(fid,'type state_type is (idle , espera, s0, s1);\n');
        fprintf(fid,'signal state_reg, state_next : state_type;\n');
        fprintf(fid,'signal col_reg, col_next : unsigned(log2c(column_size%d + 2*(conv%d_padding)) - 1 downto 0) := (others => ''0'');\n', num, num);
        fprintf(fid,'signal row_reg, row_next :  unsigned(log2c(row_size%d + 2*(conv%d_padding)) - 1 downto 0) := (others => ''0'');\n', num, num);
        fprintf(fid,'--CAPA %d\n', num);
        fprintf(fid,'signal conv%d_col_reg, conv%d_col_next : unsigned(log2c(conv%d_column) - 1 downto 0) := (others => ''0'');\n', num , num);
        fprintf(fid,'signal con%d_row_reg, conv%d_row_next : unsigned(log2c(conv%d_row) - 1 downto 0) := (others => ''0'');\n', num, num);
        fprintf(fid,'-- CAPA %d\n', num+1);
        fprintf(fid,'signal pool%d_col_reg, pool%d_col_next : unsigned(log2c(pool%d_column) - 1 downto 0) := (others => ''0'');\n', num + 1, num + 1);
        fprintf(fid,'signal pool%d_row_reg, pool%d_row_next : unsigned(log2c(pool%d_row) - 1 downto 0) := (others => ''0'');\n', num + 1, num + 1);    
        fprintf(fid,'--REGISTROS\n');
        fprintf(fid,'signal primera_vuelta_reg, primera_vuelta_next, cero_reg, cero_next : std_logic := ''0'';\n');
        fprintf(fid,'--CONSTANTES\n');
        fprintf(fid,'signal column_limit, row_limit : integer;\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'process(clk, reset) \n');
        fprintf(fid,'begin \n');
        fprintf(fid,'if (reset = ''1'') then \n');
        fprintf(fid,'\t state_reg <= idle;\n');
        fprintf(fid,'elsif (clk''event and clk = ''1'') then \n');
        fprintf(fid,'\t state_reg <= state_next; \n');
        fprintf(fid,'\t col_reg <= col_next; \n');
        fprintf(fid,'\t row_reg <= row_next; \n');
        fprintf(fid,'\t pool%d_col_reg <= pool%d_col_next; \n', num+1, num+1);
        fprintf(fid,'\t pool%d_row_reg <= pool%d_row_next; \n', num+1, num+1);
        fprintf(fid,'\t conv%d_col_reg <= conv%d_col_next; \n', num, num);
        fprintf(fid,'\t conv%d_row_reg <= conv%d_row_next; \n', num, num);
        fprintf(fid,'\t primera_vuelta_reg <= primera_vuelta_next; \n');
        fprintf(fid,'\t cero_reg <= cero_next; \n');
        fprintf(fid,'end if; \n');
        fprintf(fid,'end process; \n');
        fprintf(fid, ' process ( cero_reg, row_limit, column_limit,  state_reg, primera_vuelta_reg, conv%d_col_reg, conv%d_row_reg, pool%d_col_reg, pool%d_row_reg, row_reg, col_reg, dato_in, col_next, row_next', num, num, num+1, num+1);
        for i = num : capas - 1
        fprintf(fid, ', conv%d_col', i);
        fprintf(fid, ', conv%d_fila', i);
        fprintf(fid, ', pool%d_col', i + 1);
        fprintf(fid, ', pool%d_fila', i + 1);
        end
        fprintf(fid,')\n');
        fprintf(fid,'variable stride1');
        for i = 2 : num_variables
        fprintf(fid, ', stride%d',i);
        end
        fprintf(fid,' : natural;\n');
        fprintf(fid,'variable col_resta1 ');
        for i = 2 : num_variables
        fprintf(fid, ', col_resta%d',i);
        end
        fprintf(fid,' : natural;\n');
        fprintf(fid,'variable row_resta1 ');
        for i = 2 : num_variables
        fprintf(fid, ', row_resta%d',i);
        end
        fprintf(fid,' : natural;\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'state_next <= state_reg;\n');
        fprintf(fid,'col_next <= col_reg;\n');
        fprintf(fid,'row_next <= row_reg;\n');
        fprintf(fid,'conv%d_col_next <= conv%d_col_reg;\n', num, num );
        fprintf(fid,'conv%d_row_next <= conv%d_row_reg;\n', num, num);
        fprintf(fid,'pool%d_col_next <= pool%d_col_reg;\n', num+1, num+1);
        fprintf(fid,'pool%d_row_next <= pool%d_row_reg;\n', num+1, num+1);
        fprintf(fid,'primera_vuelta_next <= primera_vuelta_reg;\n');
        fprintf(fid,'cero_next <= cero_reg;\n');
        fprintf(fid,' case state_reg is \n');
        fprintf(fid,' when idle =>  \n');
        fprintf(fid,'\t col_next  <= (others => ''0'');\n');
        fprintf(fid,'\t row_next  <= (others => ''0'');\n');
        fprintf(fid,'\t conv%d_col_next <= (others => ''0'');\n', num);
        fprintf(fid,'\t conv%d_row_next  <= (others => ''0'');\n', num);
        fprintf(fid,'\t pool%d_col_next  <= (others => ''0'');\n', num);
        fprintf(fid,'\t pool%d_row_next  <= (others => ''0'');\n', num);
        fprintf(fid,'\t cero_next <= ''0'';\n');
        fprintf(fid,'\t primera_vuelta_next <= ''0''; \n');
        fprintf(fid,'\t dato_out <= ''0'';\n');
        fprintf(fid,'\t dato_cero <= ''0'';\n');
        fprintf(fid,'\t state_next <= espera;\n');
        fprintf(fid,'when espera => \n');
        fprintf(fid,'\t dato_out <= ''0'';\n');
        fprintf(fid,'\t dato_cero <= ''0'';\n');
        fprintf(fid,'\t if(dato_in = ''1'') then\n');
        fprintf(fid,'\t \t state_next <= s0;\n');
        fprintf(fid,'\t end if;\n');
        fprintf(fid,'when s0 => \n');
        fprintf(fid,'dato_out_next <= ''0'';\n');
        fprintf(fid,'if(primera_vuelta_reg = ''1'') then\n');
        fprintf(fid,'   primera_vuelta_next <= ''0'';\n');
        fprintf(fid,'   dato_out <= ''0'';\n');
        fprintf(fid,'   dato_cero <= ''1'';\n');
        fprintf(fid,'   state_next <= espera;\n');
        fprintf(fid,'   cero_next <= ''1'';\n');
        fprintf(fid,'   else\n');
        fprintf(fid,'   if (conv%d_col_reg /= conv%d_column - 1) then\n', num, num);
        fprintf(fid,'    stride1 := 1;\n');
        fprintf(fid,'    col_resta1 := conv%d_column-1;\n', num);
        fprintf(fid,'    row_resta1 := conv%d_row - 1;\n', num);
        fprintf(fid,'    col_next <= col_reg + stride1;\n');
        fprintf(fid,'    conv%d_col_next <= conv%d_col_reg + 1;\n', num, num);
        fprintf(fid,'else\n');
        fprintf(fid,'   conv%d_col_next <= (others => ''0'');\n', num);
        fprintf(fid,'   if (conv%d_row_reg /= (conv%d_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos uno a la fila y devolvemos el valor original a las columnas\n', num, num);
        fprintf(fid,'      col_next <= col_reg - col_resta1;\n');
        fprintf(fid,'      row_next <= row_reg + stride1;\n');
        fprintf(fid,'      conv%d_row_next <= conv%d_row_reg + 1;\n', num, num);
        fprintf(fid,'   else\n');
        fprintf(fid,'     conv%d_row_next <= (others => ''0''); \n', num);
        fprintf(fid,'    if (pool%d_col_reg /= pool%d_column - 1) then      --si ha terminado de recorrer el tamaño del filtro en todas las capas, avanzamos el filtro un valor = a stride, tantas veces como columnas tenga el filtro siguiente\n', num+1, num+1);
        fprintf(fid,'       row_next <= row_reg- row_resta1;\n');
        fprintf(fid,'       col_next <= col_reg- col_resta1 + stride1;\n');
        fprintf(fid,'       pool%d_col_next <= pool%d_col_reg + 1;\n', num + 1, num + 1);
        fprintf(fid,'     else\n');
        fprintf(fid,'     pool%d_col_next <= (others => ''0'');\n', num+1);
        fprintf(fid,'     if (pool%d_row_reg /= (pool%d_row - 1)) then    --si no ha terminado de recorrer el tamaño del filtro sumamos stride a las filas y devolvemos el valor original a las columnas\n', num+1, num+1);
        fprintf(fid,'       col_resta2 := col_resta1 + (stride1 * (pool%d_column - 1));\n', num+1);
        fprintf(fid,'       row_next <= row_reg- row_resta1 + stride1;\n');
        fprintf(fid,'       col_next <= col_reg- col_resta2;    -- restamos las columnas del filtro actual * el stride del filtro anterior = (numero total de columnas recorridas)\n');
        fprintf(fid,'       pool%d_row_next <= pool%d_row_reg + 1;\n', num+1, num+1);
        fprintf(fid,'     else\n');
        for i = num + 1 : capas - 1
        fprintf(fid,'pool%d_row_next <= (others => ''0'');\n', i);
        fprintf(fid,'row_resta%d := row_resta%d + (stride%d * (pool%d_row - 1));\n', i - 1, i-2, i-2, i-1);
        fprintf(fid,'if (conv%d_col /= conv%d_column - 1) then\n', i, i);
        fprintf(fid,'  stride%d := stride%d * pool%d_stride;\n', i-1, i-2, i);
        fprintf(fid,'row_next <= row_reg - row_resta%d;\n', i - 1);
        fprintf(fid,'col_next <= col_reg - col_resta%d + stride%d\n', i - 1 , i -1 );
        fprintf(fid,'else\n');
        fprintf(fid,'if (conv%d_fila /= (conv%d_row - 1)) then\n', i, i);
        fprintf(fid,'col_resta%d:= col_resta%d + (stride%d * (conv%d_column-1));\n', i, i-1, i-1, i);
        fprintf(fid,'row_next <= row_reg - row_resta%d + stride%d;\n', i - 1,i - 1);
        fprintf(fid,'col_next <= col_reg - col_resta%d;\n', i);
        fprintf(fid,'else\n');
        fprintf(fid,'row_resta%d := row_resta%d + (stride%d * (conv%d_row-1));\n', i, i - 1, i - 1, i);
        fprintf(fid,'if (pool%d_col /= pool%d_column - 1) then\n', i+1, i+1);
        fprintf(fid,'stride%d := stride%d * conv%d_stride; \n', i+1, i, i+1);
        fprintf(fid,' row_next <= row_reg- row_resta%d;\n', i);
        fprintf(fid,' col_next <= col_reg - col_resta%d + stride%d;\n', i -1, i);
        fprintf(fid,' else\n');
        fprintf(fid,' if (pool%d_fila /= (pool%d_row - 1)) then \n', i + 1, i + 1);
        fprintf(fid,'col_resta%d:= col_resta%d + (stride%d * (pool%d_column-1));\n',i +1, i, i, i+1);
        fprintf(fid,' row_next <= row_reg - row_resta%d + stride%d;\n', i , i);
        fprintf(fid,'col_next <= col_reg - col_resta%d;\n', i );
        fprintf(fid,' else\n');
        fprintf(fid,'row_resta%d := row_resta%d + (stride%d * (pool%d_row - 1));\n',i +1, i, i, i+1);
        end
        fprintf(fid,'if(col_reg /= column_limit - 1) then\n');
        fprintf(fid,'stride%d := stride%d * pool%d_stride;\n', num_variables, num_variables - 1, capas);
        fprintf(fid,'row_next <= row_reg - row_resta%d;\n', num_variables);
        fprintf(fid,'col_next <= col_reg- col_resta%d + stride%d;\n', num_variables);
        fprintf(fid,'else \n');
        fprintf(fid,' row_next <= row_reg - row_resta%d + stride%d;\n', num_variables, num_variables);
        fprintf(fid,'col_next <= (others => ''0'');\n');
        fprintf(fid,'if(row_reg = row_limit) then\n');
        fprintf(fid,'row_next <= (others => ''0'');\n');
        fprintf(fid,'address_next <=(others => ''0'');\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end if;\n');
        for i = (((capas -1)- num ) * 4) 
        fprintf(fid,'end if;\n');
        end
        fprintf(fid,'if(conv%d_padding > col_next or col_next >= column_size%d + conv%d_padding or conv%d_padding > row_next or row_next >= column_size + conv%d_padding ) then\n', num, num, num, num);
        fprintf(fid,'cero_next <= ''1'';\n');
        fprintf(fid,'dato_cero <= ''1'';\n');
        fprintf(fid,'dato_out <= ''0'';\n');
        fprintf(fid,'else \n');
        fprintf(fid,'cero_next <= ''0'';\n');
        fprintf(fid,'dato_cero <= ''0'';\n');
        fprintf(fid,'dato_out <= ''1'';\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'state_next <= espera;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end case;\n');
        fprintf(fid,'end process;\n');
        fprintf(fid,'column_limit<= column_size%d + 2*(conv%d_padding);    --tenemos en cuenta el padding para los valores limites de columnas y filas\n', num, num);
        fprintf(fid,'row_limit<= row_size%d  + 2*(conv%d_padding);\n', num, num);
        fprintf(fid,'conv%d_col <= conv%d_col_reg;\n', num, num);
        fprintf(fid,'conv%d_fila <= conv%d_row_reg;\n', num, num);
        fprintf(fid,'pool%d_col <= pool%d_col_reg;\n', num+1, num+1);
        fprintf(fid,'pool%d_fila <= pool%d_row_reg;\n', num+1, num+1);
        fprintf(fid,'cero <= cero_reg;\n');
        fprintf(fid,'end Behavioral;\n');
        fclose(fid);
end

