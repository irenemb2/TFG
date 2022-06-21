function [] = GeneradorSistemaCompleto(number_of_layers, capas, number_of_neurons)
 name = sprintf('SISTEMA_COMPLETO.vhd');
        fid = fopen(name, 'wt');
        fprintf(fid, '-----------------------------------SISTEMA COMPLETO-------------------------------------\n');
        fprintf(fid, '--ESTE SISTEMA CORRESPONDE A UNA RED NEURONAL CONVOLUCIONAL CON LAS DIMENSIONES QUE SE ESPECIFIQUEN EN LA LIBRERIA\n');
        fprintf(fid, '--ENTRADAS\n');
        fprintf(fid, '--wea : permite la escritura en la memoria RAM de entrada, proviene de la uart\n');
        fprintf(fid, '--ena : el enable de la RAM, también viene de la UART\n');
        fprintf(fid, '--dina : señal de entrada a la memoria que se corresponderá con los pixeles de la imágen a analizar\n');
        fprintf(fid, '--address_uart : dirección de la memoria de entrada que se escribe en cada momento, viene de la UART\n');
        fprintf(fid, '--start : señal que empieza la ejecución del programa entero\n');
        fprintf(fid, '--SALIDAS\n');
        fprintf(fid, '--dato_ready: señal que indica que hay un dato disponible en la red\n');
        fprintf(fid, '--dato_out: dato procesado por la última capa de la neurona\n');
        fprintf(fid, 'library IEEE;\n');
        fprintf(fid, 'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid, 'use work.tfg_irene_package.ALL;\n');
        fprintf(fid, 'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid, 'entity SISTEMA_COMPLETO is\n');
        fprintf(fid, 'Port (clk : in STD_LOGIC;\n');
        fprintf(fid, '      rst : in STD_LOGIC;\n');
        fprintf(fid, '      wea : in STD_LOGIC;\n');
        fprintf(fid, '      ena : in STD_LOGIC;\n');
        fprintf(fid, '      start : in std_logic;\n');
        fprintf(fid, '      dina : in STD_LOGIC_VECTOR(input_size - 1 DOWNTO 0);\n');
        fprintf(fid, '      address_uart : in STD_LOGIC_VECTOR(log2c(number_of_inputs + 1) - 1  downto 0);\n');
        fprintf(fid, '      dato_ready : out std_logic;\n');
        fprintf(fid, '      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));\n');
        fprintf(fid, 'end SISTEMA_COMPLETO;\n');
        fprintf(fid, 'architecture Behavioral of SISTEMA_COMPLETO is\n');
        fprintf(fid, '--MODULOS COMUNES\n');
        fprintf(fid, 'component RAM\n');
        fprintf(fid, 'Port(\n');
        fprintf(fid, '   clka : IN STD_LOGIC;\n');
        fprintf(fid, '   ena : IN STD_LOGIC;\n');
        fprintf(fid, '   wea : IN STD_LOGIC;\n');
        fprintf(fid, '   addra : IN STD_LOGIC_VECTOR(log2c(number_of_inputs)-1 DOWNTO 0);\n');
        fprintf(fid, '   dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);\n');
        fprintf(fid, '   douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)\n');
        fprintf(fid, '  );\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, 'component PAR2SER\n');
        fprintf(fid, 'Port (data_in : in STD_LOGIC_VECTOR(input_size - 1 downto 0);\n');
        fprintf(fid, '      count : in STD_LOGIC_VECTOR( input_size downto 0);\n');
        fprintf(fid, '      serial_out : out STD_LOGIC);\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, 'component CONV\n');
        fprintf(fid, 'Port (data_in : in std_logic;\n');
        fprintf(fid, '      clk : in std_logic\n');
        fprintf(fid, '      reset : in std_logic;\n');
        fprintf(fid, '      cont_s : in unsigned(1 downto 0);\n');
        fprintf(fid, '      next_pipeline_step : in std_logic;\n');
        fprintf(fid, '      weight : in STD_LOGIC_VECTOR(weight_size - 1 downto 0);\n');
        fprintf(fid, '      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, 'component RELU\n');
        fprintf(fid, 'Port (clk : in STD_LOGIC;\n');
        fprintf(fid, '      rst : in STD_LOGIC;\n');
        fprintf(fid, '      next_pipeline_step : in STD_LOGIC;\n');
        fprintf(fid, '      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, '      bias_term : in unsigned (input_size + weight_size + 3 -1  downto 0);\n');
        fprintf(fid, '      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);\n');
        fprintf(fid, '      index : in std_logic);\n');
        fprintf(fid, 'end component; \n');
        fprintf(fid, 'component MAXPOOL\n');
        fprintf(fid, 'Port (clk : in STD_LOGIC;\n');
        fprintf(fid, '      rst : in STD_LOGIC;\n');
        fprintf(fid, '      next_dato_pool : in STD_LOGIC;\n');
        fprintf(fid, '      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, '      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, '--MODULOS CAPA1\n');
        fprintf(fid, 'component GEN1\n');
        fprintf(fid, '\t Port (clk : in std_logic;\n');
        fprintf(fid, '\t\t     reset : in std_logic;\n');
        fprintf(fid, '\t\t     dato_in : in std_logic;\n');
        fprintf(fid, '\t\t     cont_s : out unsigned(1 downto 0);\n');
        fprintf(fid, '\t\t     count : out STD_LOGIC_VECTOR( input_size   downto 0);\n');
        fprintf(fid, '\t\t     mul: out std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, '\t\t     dato_out1: out std_logic; \n');
        fprintf(fid, '\t\t     dato_out2 : out std_logic;\n');
        fprintf(fid, '\t\t      next_pipeline_step : out std_logic);\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, 'component INTERFAZ_ET1\n');
        fprintf(fid,'Port (clk : in STD_LOGIC;\n');
        fprintf(fid,'      reset : in STD_LOGIC;\n');
        fprintf(fid,'      dato_in : in std_logic;\n');
        for i = 2 : capas - 1
        fprintf(fid,'       conv%d_col : in unsigned(log2c(conv%d_column) - 1 downto 0);\n', i, i);
        fprintf(fid,'       conv%d_fila : in  unsigned(log2c(conv%d_row) - 1 downto 0);\n', i, i);
        fprintf(fid,'       pool%d_col : in unsigned(log2c(pool%d_column) - 1 downto 0);\n', i+1, i+1);
        fprintf(fid,'       pool%d_fila : in  unsigned(log2c(pool%d_row) - 1 downto 0);\n', i+1, i+1);
        end
        fprintf(fid,'dato_out : out std_logic;\n');
        fprintf(fid,'cero : out std_logic;\n');
        fprintf(fid,' address : out std_logic_vector(log2c(number_of_inputs + 1) - 1 downto 0));\n');
        fprintf(fid, 'end component;\n');
        for i = 1 : number_of_layers(2)
        fprintf(fid, 'component ROM1_%d\n', i);
        fprintf(fid, 'Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, 'bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); \n');       
        fprintf(fid, 'weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));\n');
        fprintf(fid, 'end component;\n');
        end
        for num = 2 : (capas - 1)
        fprintf(fid, 'component GEN%d\n', num);
        fprintf(fid, '\t Port (clk : in std_logic;\n');
        fprintf(fid, '\t\t     rst : in std_logic;\n');
        fprintf(fid, '\t\t     dato_in : in std_logic;\n');
        fprintf(fid, '\t\t     cont_s : out unsigned(1 downto 0);\n');
        fprintf(fid, '\t\t     count : out STD_LOGIC_VECTOR( input_size   downto 0);\n');
        fprintf(fid, '\t\t     mul: out std_logic_vector(log2c(mult%d) - 1 downto 0);\n', i);
        fprintf(fid, '\t\t     dato_out1: out std_logic; \n');
        fprintf(fid, '\t\t     dato_out2 : out std_logic;\n');
        fprintf(fid, '\t\t     index : out std_logic;\n');
        fprintf(fid, '\t\t     en_neurona : out std_logic;\n');
        fprintf(fid, '\t\t     next_dato_pool : out std_logic;\n');
        fprintf(fid, '\t\t     next_pipeline_step : out std_logic);\n');
        fprintf(fid, 'end component\n');
        fprintf(fid, 'component INTERFAZ_ET%d\n', num);
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
        fprintf(fid,'      conv%d_col : out unsigned(log2c(conv%d_column) - 1 downto 0);\n', num, num);
        fprintf(fid,'      conv%d_fila : out  unsigned(log2c(conv%d_row) - 1 downto 0);\n', num, num);
        fprintf(fid,'      pool%d_col : out unsigned(log2c(pool%d_column) - 1 downto 0);\n',num+1, num+1);
        fprintf(fid,'      pool%d_fila : out  unsigned(log2c(pool%d_row) - 1 downto 0);\n', num+1, num+1);
        fprintf(fid, 'end component\n');      
        fprintf(fid, 'component MUX_%d\n',num);
        fprintf(fid, '\tPort( \n');
        for i = 0: number_of_layers(num) - 1
        fprintf(fid, '\tdata_in%d : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0); \n', i );
        end
        fprintf(fid, '\t index : in  STD_LOGIC_VECTOR(log2c(number_of_layers%d) - 1 downto 0); \n', num);
        fprintf(fid, '\tdata_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));\n');
        fprintf(fid, 'end component;\n');
        for j = 1 : number_of_layers(num + 1)
        fprintf(fid, 'component ROM%d_%d\n', num, j);
        fprintf(fid, 'Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, 'bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); \n');       
        fprintf(fid, 'weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));\n');
        fprintf(fid, 'end component;\n');
        end
        end
        fprintf(fid, '--MODULO CAPA %d\n', capas);
        fprintf(fid, 'component MUX_%d\n', capas);
        fprintf(fid, '\tPort( \n');
        for i = 0: number_of_layers(capas) - 1
        fprintf(fid, '\tdata_in%d : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0); \n', i );
        end
        fprintf(fid, '\t index : in  STD_LOGIC_VECTOR(log2c(number_of_layers%d) - 1 downto 0); \n', capas);
        fprintf(fid, '\tdata_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, 'component GEN%d\n', capas);
        fprintf(fid, 'Port (clk : in STD_LOGIC;\n');
        fprintf(fid, '      rst : in STD_LOGIC;\n');
        fprintf(fid, '      dato_in : in std_logic;\n');
        fprintf(fid, '      dato_out : out std_logic;\n');
        fprintf(fid, '      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers%d) - 1 downto 0);\n', capas);
        fprintf(fid, '      index : out std_logic;\n');
        fprintf(fid, '      next_dato_pool : out std_logic);\n');
        fprintf(fid, 'end component;\n');
        fprintf(fid, '----------------SEÑALES AUXILIARES-------------------\n');
        fprintf(fid, '--MEMORIA DE ENTRADA\n');
        fprintf(fid, 'signal address_ram : std_logic_vector(log2c(number_of_inputs + 1) - 1  downto 0);\n');
        fprintf(fid, 'signal address_interfaz : std_logic_vector(log2c(number_of_inputs + 1) - 1  downto 0);;\n');
        fprintf(fid, 'signal data_in : std_logic_vector(input_size - 1 downto 0);\n');
        fprintf(fid, 'signal padding_aux : std_logic;\n');
        fprintf(fid, '--CAPA 1\n');
        fprintf(fid, 'signal dato_in_1, dato_procesado1, dato_in_gen1, next_pipeline_step1, cero1, nuevo_dato2, nuevo_dato_et2 : std_logic;\n');
        fprintf(fid, 'signal count1 : std_logic_vector(input_size downto 0 );\n');
        fprintf(fid, 'signal mul1 : std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, 'signal cont_s1 : unsigned (1 downto 0);\n');
        for i = 2 : capas - 1
        fprintf(fid,'signal conv%d_col : unsigned(log2c(conv%d_column) - 1 downto 0);\n', i, i);
        fprintf(fid,'signal conv%d_fila : unsigned(log2c(conv%d_row) - 1 downto 0);\n', i, i);
        fprintf(fid,'signal pool%d_col : unsigned(log2c(pool%d_column) - 1 downto 0);\n', i+1, i+1);
        fprintf(fid,'signal pool%d_fila : unsigned(log2c(pool%d_row) - 1 downto 0);\n', i+1, i+1);
        end
        fprintf(fid, 'signal data_in_capa1 : std_logic_vector(input_size - 1 downto 0);\n');
        fprintf(fid, 'signal data_in_filtro1 : std_logic;\n');
        fprintf(fid, 'signal data_in_relu1 ');
        for i = 2 : number_of_neurons(1)
        fprintf(fid, ', data_in_relu%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, 'signal data_out_relu1 ');
        for i = 2 : number_of_neurons(1)
        fprintf(fid, ', data_out_relu%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, 'signal weight_aux_1 ');
        for i = 2 : number_of_neurons(1)
        fprintf(fid, ', weight_aux%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(weight_size - 1 downto 0);\n');
         fprintf(fid, 'signal bias_term_aux1 ');
        for i = 2 : number_of_neurons(1)
        fprintf(fid, ', bias_term_aux%d', i);
        end
        fprintf(fid, ': unsigned (input_size + weight_size + 3 -1  downto 0);\n');
        for j = 2 : capas - 1
        fprintf(fid, '--CAPA %d\n', j);
        fprintf(fid, 'signal dato_in_%d, dato_procesado%d, dato_in_gen%d, next_pipeline_step%d, cero%d, nuevo_dato%d, nuevo_dato_et%d : std_logic;\n', j, j, j, j, j, j+1, j+1);
        fprintf(fid, 'signal count%d : std_logic_vector(input_size downto 0 );\n', j);
        fprintf(fid, 'signal mul%d : std_logic_vector(log2c(mult%d) - 1 downto 0);\n', j, j);
        fprintf(fid, 'signal cont_s%d : unsigned (1 downto 0);\n', j);
        fprintf(fid, 'signal capa%d : std_logic_vector(log2c(number_of_layers%d) - 1 downto 0);\n', j);
        fprintf(fid, 'signal data_in_pool%d , data_out_pool%d: std_logic_vector (input_size + weight_size + 3 - 1 downto 0);\n', j, j);
        fprintf(fid, 'signal data_pool%d, data_in_capa%d: std_logic_vector(input_size - 1 downto 0);\n', j, j);
        fprintf('     signal address%d : std_logic_vector ( log2c(mult%D) + log2c(number_of_layers%d) - 1 downto 0);\n', j, j, j);
        fprintf(fid, 'signal data_in_filtro%d, data_out_par2ser%d: std_logic;\n', j, j);
        fprintf(fid, 'signal data_in_relu21 ');
        for i = 2 : number_of_neurons(j)
        fprintf(fid, ', data_in_relu2%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, 'signal data_out_relu21 ');
        for i = 2 : number_of_neurons(j)
        fprintf(fid, ', data_out_relu2%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);\n');
        fprintf(fid, 'signal weight_aux_21 ');
        for i = 2 : number_of_neurons(j)
        fprintf(fid, ', weight_aux2%d', i);
        end
        fprintf(fid, ': STD_LOGIC_VECTOR(weight_size - 1 downto 0);\n');
         fprintf(fid, 'signal bias_term_aux21 ');
        for i = 2 : number_of_neurons(j)
        fprintf(fid, ', bias_term_aux2%d', i);
        end
        fprintf(fid, ': unsigned (input_size + weight_size + 3 -1  downto 0);\n');
        end
        fprintf(fid, '--CAPA %d\n', capas);
        fprintf(fid, 'signal index%d, next_dato_pool%d : std_logic;\n', capas, capas);
        fprintf(fid, 'signal capa%d : std_logic_vector(log2c(number_of_layers%d) - 1 downto 0);\n', capas, capas);
        fprintf(fid, 'signal data_in_pool%d : std_logic_vector (input_size + weight_size + 3 - 1 downto 0);\n', capas);
        fprintf(fid, 'begin\n');
        fprintf(fid, '--MEMORIA DE ENTRADA\n');
        fprintf(fid, 'address_ram <= address_uart when (wea = ''1'') else address_interfaz;\n');
        fprintf(fid, 'RAM_MEMORY: RAM\n');
        fprintf(fid, 'Port map(\n');
        fprintf(fid, '  dina => dina,\n');
        fprintf(fid, '  clka => clk,\n');
        fprintf(fid, '  wea => wea,\n');
        fprintf(fid, '  ena => ena,\n');
        fprintf(fid, '  addra => address_ram,\n');
        fprintf(fid, '  douta => data_in\n');
        fprintf(fid, ');\n');
        fprintf(fid, '----CAPA 1\n');
        fprintf(fid, 'dato_in_1 <= nuevo_dato2 or dato_procesado1 ;\n');
        fprintf(fid, 'GEN_ENABLE: GEN1 \n');
        fprintf(fid, 'port map(\n');
        fprintf(fid, '  clk => clk,\n');
        fprintf(fid, '  rst => rst,\n');
        fprintf(fid, '  dato_in => dato_in_gen1,\n');
        fprintf(fid, '  count => count1,\n');
        fprintf(fid, '  mul => mul1,\n');
        fprintf(fid, '  cont_s => cont_s1,\n');
        fprintf(fid, '  dato_out1 => dato_procesado1,\n');
        fprintf(fid, '  dato_out2 => nuevo_dato_et2,\n');
        fprintf(fid, '  next_pipeline_step => next_pipeline_step1\n');
        fprintf(fid, ');\n');
        fprintf(fid, 'INTERFAZ_1: INTERFAZ_ET1\n');
        fprintf(fid, 'Port map(\n');
        fprintf(fid, '  clk => clk,\n');
        fprintf(fid, '  reset => rst,\n');
        fprintf(fid, '  dato_in => dato_in_1\n');
        fprintf(fid, '  address => address_interfaz,\n');
        fprintf(fid, '  cero => cero1,\n');
        fprintf(fid, '  dato_out => dato_in_gen1\n');
        for i = 2 : capas-1
        fprintf(fid, ',\n    conv%d_col => conv%d_col', i);
        fprintf(fid, ',\n    conv%d_fila => conv%d_fila,', i);
        fprintf(fid, ',\n    pool%d_col => pool%d_col,', i+1);
        fprintf(fid, ',\n    pool%d_fila => pool%d_fila,\n', i+1);
        end 
        fprintf(fid, '\n');
        fprintf(fid, 'data_in_capa1 <= data_in when (cero1 = ''0'') else (others=>''0'');\n');
        fprintf(fid, 'CONVERSOR : par2ser  \n');
        fprintf(fid, 'port map(\n');
        fprintf(fid, '  data_in => data_in_capa1,\n');
        fprintf(fid, '  count => count1,\n');
        fprintf(fid, '  serial_out => data_in_filtro1\n');
        fprintf(fid, ');\n');
        for i = 1 : number_of_layers(2)
        fprintf(fid, 'MEMROM1_%d : ROM1_%d\n', i, i);
        fprintf(fid, '   port map (\n');
        fprintf(fid, '        address => mul%d,\n', i);
        fprintf(fid, '        weight => weight_aux%d,\n', i);
        fprintf(fid, '        bias_term => bias_term_aux%d);\n', i);
        fprintf(fid, 'CONV1_%d : CONV\n', i);
        fprintf(fid, '    port map(\n');
        fprintf(fid, '        clk => clk,\n');
        fprintf(fid, '        Reset => rst,\n');
        fprintf(fid, '        data_in => data_in_filtro%d,\n', i);
        fprintf(fid, '        weight => weight_aux%d,\n', i);
        fprintf(fid, '        cont_s =>cont_s%d,\n', i);
        fprintf(fid, '        next_pipeline_step => next_pipeline_step%d,\n', i);
        fprintf(fid, '        data_out => data_in_relu%d);\n', i);
        fprintf(fid, 'RELU1_%d : RELU\n', i);
        fprintf(fid, '    port map(\n');
        fprintf(fid, '    clk => clk,\n');
        fprintf(fid, '    rst => rst,\n');
        fprintf(fid, '    next_pipeline_step => next_pipeline_step%d,\n', i);
        fprintf(fid, '    data_in => data_in_relu%d,\n', i);
        fprintf(fid, '    bias_term => bias_term_aux%d,\n', i);
        fprintf(fid, '    index => index%d,\n', i+1);
        fprintf(fid, '    data_out => data_out_relu%d);  \n', i);
        end
        for i = 2:capas - 1
                    fprintf(fid, '----CAPA %d\n', i);
        if ( i == capas - 1)
        fprintf(fid, 'dato_in_%d <= start or next_pipeline_step%d or dato_procesado%d ;\n', i , i, i);
        else
        fprintf(fid, 'dato_in_%d <= nuevo_dato%d or dato_procesado%d ;\n', i , i+1, i);
        end
        fprintf(fid, 'GEN_ENABLE%d: GEN%d \n', i, i);
        fprintf(fid, 'port map(\n');
        fprintf(fid, '  clk => clk,\n');
        fprintf(fid, '  rst => rst,\n');
        fprintf(fid, '  capa => capa%d,\n', i);
        fprintf(fid, '  dato_in => dato_in_gen%d,\n', i);
        fprintf(fid, '  count => count%d,\n', i);
        fprintf(fid, '  cont_s => cont_s%d,\n', i);
        fprintf(fid, '  mul => mul%d,\n', i);
        fprintf(fid, '  en_neurona => en_neurona%d,\n', i);
        fprintf(fid, '  index => index%d,\n', i);
        fprintf(fid, '  next_dato_pool => next_dato_pool%d,\n', i);
        fprintf(fid, '  dato_out1 => dato_procesado%d,\n', i);
        fprintf(fid, '  dato_out2 => nuevo_dato_et%d,\n', i+1);
        fprintf(fid, '  next_pipeline_step => next_pipeline_step%d\n', i);
        fprintf(fid, ');\n');
        fprintf(fid, 'dato_in_gen%d <= (dato_cero%d or nuevo_dato_et%d);\n', i, i, i);
        fprintf(fid, 'INTERFAZ_%d: INTERFAZ_ET%d\n', i, i);
        fprintf(fid, 'Port map(\n');
        fprintf(fid, '  clk => clk,\n');
        fprintf(fid, '  reset => rst,\n');
        fprintf(fid, '  dato_in => dato_in_%d\n', i);
        fprintf(fid, '  dato_cero => dato_cero%d,\n', i);
        fprintf(fid, '  cero => cero%d,\n', i);
        fprintf(fid, '  dato_out => nuevo_dato%d', i);
        for o = i : capas-1
        fprintf(fid, ',\n    conv%d_col => conv%d_col', o, o);
        fprintf(fid, ',\n    conv%d_fila => conv%d_fila,', o, o);
        fprintf(fid, ',\n    pool%d_col => pool%d_col,', o+1, o+1);
        fprintf(fid, ',\n    pool%d_fila => pool%d_fila,\n', o+1, o+1);
        end 
        fprintf(fid, ');\n');
        fprintf(fid, 'MUX_%d : MUX\n', i);
        fprintf(fid, '   port map(\n');
        for j = 1 : number_of_layers(i+1)
        fprintf(fid, 'data_in%d=> data_out_relu%d,\n', j-1, j);
        end
        fprintf(fid, '    index => capa%d,\n', i);
        fprintf(fid, '    data_out => data_in_pool%d);\n', i);
        fprintf(fid, 'POOL%d : MAXPOOL\n', i);
        fprintf(fid, '   port map(\n');
        fprintf(fid, '   clk => clk,\n');
        fprintf(fid, '   rst => rst,\n');
        fprintf(fid, '   data_in => data_in_pool%d,\n', i);
        fprintf(fid, '   next_dato_pool => next_dato_pool%d,\n', i);
        fprintf(fid, '   data_out => data_out_pool%d);\n', i);
        fprintf(fid, 'data_pool%d<= data_out_pool%d(input_size + weight_size - 3 downto input_size - 3 + 1);\n', i, i);
        fprintf(fid, 'data_in_capa%d<= data_pool%d when (cero%d = ''0'') else (others=>''0'');\n',i, i, i);
        fprintf(fid, 'CONVERSOR : par2ser  \n');
        fprintf(fid, 'port map(\n');
        fprintf(fid, '  data_in => data_in_capa%d,\n', i);
        fprintf(fid, '  count => count%d,\n', i);
        fprintf(fid, '  serial_out => data_out_par2ser%d\n', i);
        fprintf(fid, ');\n');
        fprintf(fid, 'data_in_filtro%d <= data_out_par2ser%d when en_neurona%d= ''1'' else ''0'';\n', i, i, i);
        fprintf(fid, 'address%d <= capa%d & mul%d;\n', i, i, i);
        for j = 1 : number_of_layers(i+1)
        fprintf(fid, 'MEMROM%d_%d : ROM%d_%d\n',i, j,i, j);
        fprintf(fid, '   port map (\n');
        fprintf(fid, '        address => address%d,\n', i);
        fprintf(fid, '        weight => weight_aux%d%d,\n', i, j);
        fprintf(fid, '        bias_term => bias_term_aux%d%d);\n',i, j);
        fprintf(fid, 'CONV%d_%d : CONV\n',i, j);
        fprintf(fid, '    port map(\n');
        fprintf(fid, '        clk => clk,\n');
        fprintf(fid, '        Reset => rst,\n');
        fprintf(fid, '        data_in => data_in_filtro%d,\n', i);
        fprintf(fid, '        weight => weight_aux%d%d,\n',i, j);
        fprintf(fid, '        cont_s =>cont_s%d,\n', j);
        fprintf(fid, '        next_pipeline_step => next_pipeline_step%d,\n', j);
        fprintf(fid, '        data_out => data_in_relu%d%d);\n',i, j);
        fprintf(fid, 'RELU%d_%d : RELU\n',i, j);
        fprintf(fid, '    port map(\n');
        fprintf(fid, '    clk => clk,\n');
        fprintf(fid, '    rst => rst,\n');
        fprintf(fid, '    next_pipeline_step => next_pipeline_step%d,\n', j);
        fprintf(fid, '    data_in => data_in_relu%d%d,\n', i, j);
        fprintf(fid, '    bias_term => bias_term_aux%d%d,\n',i, j);
        fprintf(fid, '    index => index%d,\n', j+1);
        fprintf(fid, '    data_out => data_out_relu2%d);  \n', j);
        end
        end
        fprintf(fid, 'GENERADOR%d : GEN%d\n', capas, capas);
        fprintf(fid, 'port map(\n');
        fprintf(fid, '     clk => clk,\n');
        fprintf(fid, '     rst => rst,\n');
        fprintf(fid, '     dato_in => nuevo_dato%d,\n', capas);
        fprintf(fid, '     dato_out => dato_ready,\n');
        fprintf(fid, '     capa => capa%d,\n', capas);
        fprintf(fid, '     index => index%d,\n', capas);
        fprintf(fid, '     next_dato_pool => next_dato_pool%d);\n', capas);
        fprintf(fid, 'MUX_%d : MUX%d\n', capas, capas);
        fprintf(fid, 'port map(\n');
        for j = 1 : number_of_layers(capas)
        fprintf(fid, 'data_in%d=> data_out_relu%d,\n', j-1, j);
        end
        fprintf(fid, '    index => capa%d,\n', capas);
        fprintf(fid, '    data_out => data_in_pool%d); \n', capas);
        fprintf(fid, 'POOL%d : MAXPOOL\n', capas);
        fprintf(fid, '   port map(\n');
        fprintf(fid, '   clk => clk,\n');
        fprintf(fid, '   rst => rst,\n');
        fprintf(fid, '   data_in => data_in_pool%d,\n', capas);
        fprintf(fid, '   next_dato_pool  => next_dato_pool%d,\n', capas);
        fprintf(fid, '   data_out => data_out); \n');
        fprintf(fid, 'end Behavioral;\n');
        fclose(fid);
end

