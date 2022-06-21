function [] = GeneradorControlCapa1(input_size, mult1, pool2_size)
        name = sprintf('GEN1.vhd');
        fid = fopen(name, 'wt');
        fprintf(fid, '----------------------------MODULO GENERADOR 1----------------------------\n');
        fprintf(fid, '--Este modulo se encarga de producir todas las señales de control de su capa, que permiten sincronizar el funcionamiento de todos los modulos\n');
        fprintf(fid, '---ENTRADAS\n');
        fprintf(fid, '--dato_in : indica que hay un dato a procesar en la capa\n');
        fprintf(fid, '---SALIDAS\n');
        fprintf(fid, '--mul : indica la multiplicación del filtro que estemos realizando en ese momento\n');
        fprintf(fid, '--cont_s : señal que cuenta desde 0 a 2 y se mantiene hasta que termine count, se utiliza para indicar en que momento de count estoy en el conversor par2ser\n');
        fprintf(fid, '--count : contador de 0 hasta 2^(longitud señal) + 2 que pasamos al conversor paralelo serie para codificar la señal\n');
        fprintf(fid, '--dato_out1 :  señal que notifica de que se ha terminado de procesar un dato en esta capa\n');
        fprintf(fid, '--dato_out2 : señal que notifica de que hay un dato disponible para procesar en la siguiente capa\n');
        fprintf(fid, '--next_pipeline_step: indica que ha terminado de preocesar un dato en la convolucion\n');
        fprintf(fid, 'library IEEE;\n');
        fprintf(fid, 'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid, 'use work.tfg_irene_package.ALL;\n');
        fprintf(fid, 'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid, 'entity GEN1 is\n');
        fprintf(fid, '\t Port (clk : in std_logic;\n');
        fprintf(fid, '\t\t     reset : in std_logic;\n');
        fprintf(fid, '\t\t     dato_in : in std_logic;\n');
        fprintf(fid, '\t\t     cont_s : out unsigned(1 downto 0);\n');
        fprintf(fid, '\t\t     count : out STD_LOGIC_VECTOR( input_size   downto 0);\n');
        fprintf(fid, '\t\t     mul: out std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, '\t\t     dato_out1: out std_logic; \n');
        fprintf(fid, '\t\t     dato_out2 : out std_logic;\n');
        fprintf(fid, '\t\t      next_pipeline_step : out std_logic);\n');
        fprintf(fid, 'end GEN1; \n');
        fprintf(fid, 'architecture Behavioral of GEN1 is\n');
        fprintf(fid, 'type state_type is (idle , espera, s0);\n');
        fprintf(fid, '--REGISTROS\n');
        fprintf(fid, 'signal state_reg, state_next : state_type;\n');
        fprintf(fid, 'signal dato_reg , dato_next : std_logic := ''0'';\n');
        fprintf(fid, 'signal count_reg, count_next: unsigned(input_size + log2c(mult1) + log2c(pool2_size) downto 0) :=  (others=>''0'');\n');
        fprintf(fid, 'signal count_r : unsigned( input_size downto 0);\n');
        fprintf(fid, 'signal c_reg , c_next : unsigned ( 1 downto 0);\n');
        fprintf(fid, 'signal next_pipeline_step_reg, next_pipeline_step_next, dato2_reg, dato2_next : std_logic;\n');
        fprintf(fid,'--CONSTANTES\n');
        fprintf(fid,'signal data_max : unsigned(input_size - 1 downto 0):=  (others=>''0'');\n');
        fprintf(fid,'signal count_max  : unsigned(input_size  downto 0):=  (others=>''0'');\n');
        fprintf(fid,'signal mul_max : unsigned(log2c(mult1)- 1 downto 0):=  (others=>''0'');\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'process(clk, rst) \n');
        fprintf(fid,'begin \n');
        fprintf(fid,'if (rst = ''1'') then \n');
        fprintf(fid,'\t count_reg <= (others=>''0'');\n');
        fprintf(fid,'\t c_reg <= (others=>''0'');\n');
        fprintf(fid,'\t state_reg <= idle;\n');
        fprintf(fid,'\t dato_reg <= ''0'';\n');
        fprintf(fid,'\t dato2_reg <= ''0'';\n');
        fprintf(fid,'elsif (clk''event and clk = ''1'') then \n');
        fprintf(fid,'\t state_reg <= state_next;\n');
        fprintf(fid,'\t next_pipeline_step_reg <= next_pipeline_step_next\n');
        fprintf(fid,'\t dato_reg <= dato_next;\n');
        fprintf(fid,'\t dato2_reg <= dato2_next;\n');
        fprintf(fid,'\t count_reg <= count_next;\n');
        fprintf(fid,'\t c_reg <= c_next;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end process;\n');
        fprintf(fid,'--next-state logic \n');
        fprintf(fid,'process(state_reg, dato_reg, data_max, count_max, dato_in, count_reg, c_reg, next_pipeline_step_reg, dato2_reg)\n');
        fprintf(fid,'begin\n');
        fprintf(fid,'count_next <= count_reg;\n');
        fprintf(fid,'c_next <= c_reg;\n');
        fprintf(fid,'state_next <= state_reg;\n');
        fprintf(fid,'next_pipeline_step_next <= next_pipeline_step_reg;\n');
        fprintf(fid,'dato_next <= dato_reg;\n');
        fprintf(fid,'dato2_next <= dato2_reg;\n');
        fprintf(fid,'case state_reg is\n');
        fprintf(fid,'when idle  =>\n');
        fprintf(fid,'\t dato_next <= ''0'';\n');
        fprintf(fid,'\t dato2_next <= ''0'';\n');
        fprintf(fid,'\t next_pipeline_step_next <=''0'';\n');
        fprintf(fid,'\t count_next <= (others=>''0'');\n');
        fprintf(fid,'\t c_next <= (others=>''0'');\n');
        fprintf(fid,'\t state_next <= espera;\n');
        fprintf(fid,'when espera =>\n');
        fprintf(fid,'\t next_pipeline_step_next <= ''0'';\n');
        fprintf(fid,'\t dato_next <= ''0'';\n');
        fprintf(fid,'\t dato2_next <= ''0'';\n');
        fprintf(fid,'\t if(dato_in = ''1'') then\n');
        fprintf(fid,'\t \t state_next <= s0; \n');
        fprintf(fid,'\t end if;\n');
        fprintf(fid,'\t next_pipeline_step_next <= ''0'';  \n');
        fprintf(fid,'when s0 =>\n');
        fprintf(fid,'next_pipeline_step_next <= ''0'';\n');
        fprintf(fid,'if(c_reg < 2) then           --c_reg cuenta los dos primeros pulsos del pixel para indicar en la neurona si es cero y el signo\n');
        fprintf(fid,' c_next <= c_reg + 1;\n');
        fprintf(fid,'end if; \n');
        fprintf(fid,' if(count_reg(input_size downto 0) = count_max) then    --cuenta llega a 257 pasa un nuevo pixel y se reinicia la cuenta \n');
        fprintf(fid,'\t  if(count_reg(log2c(mult1) + input_size downto input_size + 1 )= mult1 - 1) then          --se pasa a una nueva multiplicación o se reinicia la cuenta\n');
        fprintf(fid,'\t \t   if(count_reg(input_size + log2c(mult1) + log2c(pool2_size) downto log2c(mult1) + input_size + 1) = pool2_size - 1) then\n');
        fprintf(fid,'\t \t \t  dato2_next <= ''1'';\n');
        fprintf(fid,'\t \t \t next_pipeline_step_next <= ''1'';\n');
        fprintf(fid,'\t \t state_next <= espera;\n');
        a = strcat(num2str(dec2bin(pool2_size - 1)), num2str(dec2bin(mult1 - 1)), num2str(dec2bin((2 ^input_size)+2)));
        num = ((2^(length(a)) - bin2dec(a))) + 1;
        fprintf(fid,'\t \t count_next <= count_reg + %d;\n', num);
        fprintf(fid,'\t \t else\n');
        fprintf(fid,'\t \t \t next_pipeline_step_next <= ''1'';\n');
         a = strcat(num2str(dec2bin(mult1 - 1)), num2str(dec2bin((2 ^input_size)+2)));
         num = ((2^(length(a)) - bin2dec(a))) + 1;
         fprintf(fid,'\t \t count_next <= count_reg + %d;\n', num);
         fprintf(fid,'\t \t state_next <= espera;\n');
        fprintf(fid,'\t \t end if;\n');
        fprintf(fid,'\t else\n');
         a = strcat(num2str(dec2bin((2 ^input_size)+2)));
         num = ((2^(length(a)) - bin2dec(a))) + 1;
        fprintf(fid,'\t \t count_next <= count_reg + %d;\n', num);
        fprintf(fid,'\t \t c_next <= (others=>''0'');\n');
        fprintf(fid,'\t \tstate_next <= espera; \n');
        fprintf(fid,'\t end if;\n');
        fprintf(fid,'else\n');
        fprintf(fid,'\t if(count_reg(input_size  downto 0) = data_max) then     --pasamos el dato nuevo antes de que count llegue a count_max para tener el cuenta el retardo en producir la dirección que tiene Interfaz_Etapa\n');
        fprintf(fid,'\t \t if((count_reg(input_size + log2c(mult1) + log2c(pool2_size) downto log2c(mult1) + input_size + 1) = pool2_size - 1) and (count_reg(log2c(mult1) + input_size downto input_size + 1 )= mult1 - 1)) then\n');
        fprintf(fid,'\t \t \t  dato_next <= ''0'';\n');
        fprintf(fid,'\t \t else\n');
        fprintf(fid,'\t \t \t dato_next <= ''1'';\n');
        fprintf(fid,'\t \t end if;\n');
        fprintf(fid,'\t else \n');
        fprintf(fid,'\t \t dato_next <= ''0'';\n');
        fprintf(fid,'\t end if\n');
        fprintf(fid,'\t count_next <= count_reg + 1;\n');
        fprintf(fid,'end if;\n');
        fprintf(fid,'end case;\n');
        fprintf(fid,'end process;\n');
        fprintf(fid,'--constantes\n');
        fprintf(fid,'data_max <= (others => ''1'');\n');
        fprintf(fid,'count_max <= (''0'' & data_max)  + 2;\n');
        fprintf(fid,'mul_max <=  (others => ''1'');        --cuenta máxima es igual al máximo tamaño de dato mas dos pulsos de cero y de signo\n');
        fprintf(fid,'--output logic \n');
        fprintf(fid,'dato_out1 <= dato_reg;\n');
        fprintf(fid,'dato_out2 <= dato2_reg;\n');
        fprintf(fid,'count <= std_logic_vector(count_reg(input_size downto 0));\n');
        fprintf(fid,'cont_s <= c_reg;\n');
        fprintf(fid,'mul <= std_logic_vector(count_reg(log2c(mult1) + input_size downto input_size + 1 ));\n');
        fprintf(fid,'next_pipeline_step <= next_pipeline_step_reg;    --e activa cuando el filtro halla multiplicado los datos de todas las capas\n');
        fprintf(fid, 'end Behavioral;\n');
        fclose(fid);
           
end
