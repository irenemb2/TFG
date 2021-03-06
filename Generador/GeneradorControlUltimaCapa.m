function [] = GeneradorControlUltimaCapa(capas)
 name = sprintf('GEN%d.vhd', capas);
        fid = fopen(name, 'wt');
        fprintf(fid, '----------------------------MODULO GENERADOR %d----------------------------\n', capas);
        fprintf(fid, '--Este modulo se encarga de producir todas las señales de control de su capa, que permiten sincronizar el funcionamiento de todos los modulos\n');
        fprintf(fid, '--ENTRADAS\n');
        fprintf(fid, '--dato_in : indica que hay un dato a procesar en la capa\n');
        fprintf(fid, '--SALIDAS\n');
        fprintf(fid, '--capa : indica la capa de la matriz resultado de la etapa anterior que estamos procesando en este momento\n');
        fprintf(fid, '--dato_out :  señal que notifica de que se ha terminado de procesar un dato en esta capa\n');
        fprintf(fid, '--next_dato_pool: indica que hay un nuevo dato para procesar al modulo pool \n');
        fprintf(fid, '--index: señal que se le pasa al modulo relu para que transmita los datos almacenados\n');
        fprintf(fid, 'library IEEE;\n');
        fprintf(fid, 'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid, 'use work.tfg_irene_package.ALL;\n');
        fprintf(fid, 'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid, 'entity GEN%d is\n', capas);
        fprintf(fid, '\t Port (clk : in std_logic;\n');
        fprintf(fid, '\t\t     rst : in std_logic;\n');
        fprintf(fid, '\t\t     dato_in : in std_logic;\n');
        fprintf(fid, '\t\t     capa: out std_logic_vector(log2c(number_of_layers%d) - 1 downto 0);\n', capas);
        fprintf(fid, '\t\t     dato_out: out std_logic; \n');
        fprintf(fid, '\t\t     index : out std_logic;\n');
        fprintf(fid, '\t\t      next_dato_pool : out std_logic);\n');
        fprintf(fid, 'end GEN%d; \n', capas);
        fprintf(fid, 'architecture Behavioral of GEN%d is\n', capas);
        fprintf(fid, 'type state_type is (idle , espera, s0);\n');
        fprintf(fid, '--REGISTROS\n');
        fprintf(fid, 'signal state_reg, state_next : state_type;\n');
        fprintf(fid, 'signal index_reg, index_next : unsigned (log2c(pool%d_size) + 1  downto 0);\n', capas);
        fprintf(fid, 'signal count_reg, count_next: unsigned(log2c(number_of_layers%d) - 1 downto 0) := (others=> ''0'');\n', capas);
        fprintf(fid, 'signal next_dato_pool_reg, next_dato_pool_next, dato_reg, dato_next: std_logic := ''0'';\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'process(clk, rst) \n');
        fprintf(fid,'begin \n');
        fprintf(fid,'if (rst = ''1'') then \n');
        fprintf(fid,'\t index_reg <= (others=>''0'');\n');
        fprintf(fid,'\t state_reg <= idle;\n');
        fprintf(fid,'\t next_dato_pool_reg <= ''0'';\n');
        fprintf(fid,'\t dato_reg <= ''0'';\n');
        fprintf(fid,'elsif (clk''event and clk = ''1'') then \n');
        fprintf(fid,'\t state_reg <= state_next;\n');
        fprintf(fid,'\t index_reg <= index_next;\n');
        fprintf(fid,'\t next_dato_pool_reg <= next_dato_pool_next;\n');
        fprintf(fid,'\t dato_reg <= dato_next;\n');
        fprintf(fid,'\t if(index_reg > pool4_size) then\n');
        fprintf(fid,'\t \t count_reg <= count_next;\n');
        fprintf(fid,'\t end if;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end process;\n');
        fprintf(fid,'--next-state logic \n');
        fprintf(fid,'process(state_reg, index_reg, dato_in, count_reg, next_dato_pool_reg, dato_reg)\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'count_next <= count_reg;\n');
        fprintf(fid,'state_next <= state_reg;\n');
        fprintf(fid,'next_dato_pool_next <= next_dato_pool_reg;\n');
        fprintf(fid,'dato_next <= dato_reg;\n');
        fprintf(fid,'index_next <= index_reg;\n');
        fprintf(fid,'case state_reg is\n');
        fprintf(fid,'when idle  =>\n');
        fprintf(fid,'\t dato_next <= ''0'';\n');
        fprintf(fid,'\t index <= ''0'';\n');
        fprintf(fid,'\t index_next <= (others=>''0'');;\n');
        fprintf(fid,'\t next_dato_pool_next <=''0'';\n');
        fprintf(fid,'\t count_next <= (others=>''0'');\n');
        fprintf(fid,'\t state_next <= espera;\n');
        fprintf(fid,'when espera =>\n');
        fprintf(fid,'\t next_dato_pool_next <= ''0'';\n');
        fprintf(fid,'\t dato_next <= ''0'';\n');
         fprintf(fid,'\t index <= ''0'';\n');
        fprintf(fid,'\t if(dato_in = ''1'') then\n');
        fprintf(fid,'\t index_next <= (others=>''0'');;\n');
        fprintf(fid,'\t \t state_next <= s0; \n');
        fprintf(fid,'\t end if;\n');
        fprintf(fid,'when s0 =>\n');
        fprintf(fid,'--SEÑALES RELU Y POOL\n');
        fprintf(fid,'if(index_reg /= pool%d_size + 1) then\n', capas);
        fprintf(fid,'\t dato_next <= ''0'';\n');
        fprintf(fid,'\t index_next <= index_reg + 1;\n');
        fprintf(fid,'\t \t if(index_reg < pool%d_size) then \n', capas);
        fprintf(fid,'\t \t \t index <= ''1'';\n');
        fprintf(fid,'\t \t \t if(index_reg = pool%d_size - 1 and next_dato_pool_reg = ''0'' ) then\n', capas);
        fprintf(fid,'\t \t \t next_dato_pool_next <= ''1'';\n');
        fprintf(fid,'\t \t else \n');
        fprintf(fid,'\t \t \t next_dato_pool_next <= ''0'';\n');
        fprintf(fid,'\t \t end if;\n');
        fprintf(fid,'else\n');
        fprintf(fid,'\t index <= ''0'';\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'else\n');
        fprintf(fid,'\t index <= ''0'';\n');
        fprintf(fid,'\t index_next <= index_reg;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'--SEÑALES MULTIPLEXOR \n');
        fprintf(fid,'if(count_reg = number_of_layers%d - 1) then\n', capas);
        fprintf(fid,'\t  count_next <= (others => ''0'');\n');
        fprintf(fid,'\t  dato_next <= ''1'';\n');
        fprintf(fid,'\t state_next <= espera;\n');
        fprintf(fid,'elsif(count_reg = 1) then  \n');
        fprintf(fid,'\t index_next <= (others=>''0'');\n');
        fprintf(fid,'\t count_next <= count_reg + 1;\n');
        fprintf(fid,'else;\n');
        fprintf(fid,'count_next <= count_reg + 1;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end case;\n'); 
        fprintf(fid,'end process;\n');
        fprintf(fid,'capa <= std_logic_vector(count_reg); \n'); 
        fprintf(fid,'next_dato_pool <= next_dato_pool_reg;\n');
        fprintf(fid,'dato_out <= dato_reg;\n');
        fprintf(fid, 'end Behavioral;\n');
        fclose(fid);
           
end

