function [] = GeneradorMux(num,number_of_layers)
    name = sprintf('MUX_%d.vhd',num);
    fid = fopen(name, 'wt');  
        fprintf(fid, '---------------MODULO MUX---------------\n');
        fprintf(fid, '--Este modulo selecciona la señal de salida para transmitir cada una de las señales de salida de los filtros de una capa\n');
        fprintf(fid, '--como señal de entrada a los filtros de la siguiente capa. De esta manera transmitimos la matriz resultado a la siguiente capa\n');
        fprintf(fid, '--index: señal que selecciona la señal de salida, su valor va desde 0 hasta el número de capas\n');
        fprintf(fid, '--ENTRADAS\n');
        fprintf(fid, '--data_inx : señal de salida del filtro convolucional, una para cada filtro\n');
        fprintf(fid, '--SALIDAS\n');
        fprintf(fid, '--data_out: señal seleccionada de salida \n');
        fprintf(fid, 'library IEEE;\n');
        fprintf(fid, 'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid, 'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid, 'use work.tfg_irene_package.ALL;\n');
        fprintf(fid, 'entity  MUX_%d is\n', num);
        fprintf(fid, '\tPort( \n');
         for i = 0: number_of_layers - 1
            fprintf(fid, '\tdata_in%d : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0); \n', i );
        end
        fprintf(fid, '\t index : in  STD_LOGIC_VECTOR(log2c(number_of_layers%d) - 1 downto 0); \n', num);
        fprintf(fid, '\tdata_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));\n');
        fprintf(fid, 'end MUX_%d; \n', num);
        fprintf(fid, 'architecture Behavioral of MUX_%d is\n', num');
        fprintf(fid, 'begin\n');
         for i = 0: number_of_layers - 1
             if ( i == 0)
            fprintf(fid, 'data_out <=   data_in%d when index = "%s" else \n', i, dec2bin(i, 4));
             else
                 fprintf(fid, '\t data_in%d when index = "%s" else \n', i, dec2bin(i, 4));
             end
        end
        fprintf(fid, '\t (others => ''0'');\n');
        fprintf(fid, 'end Behavioral;\n\n');        
    
    fclose(fid);
end

