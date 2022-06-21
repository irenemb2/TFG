function ROM_Layer1(mul, pesos, num, bias_term)
   
    name = sprintf('ROM1_%d.vhd',num);
    fid = fopen(name, 'wt');
       
        % Escritura en fichero de las líneas comunes a todas las neuronas %    
        fprintf(fid, '----------------------MODULO MEMORIA ROM---------------\n');
        fprintf(fid, '--Este modulo almacena los pesos de cada uno de los filtros convolucionales\n');
        fprintf(fid, '--estos pesos se eligen según la posición del filtro en la que se encuentre\n');
        fprintf(fid, '--ENTRADAS\n');
        fprintf(fid, '--address : un numero entre 0 - tamaño del filtro que corresponde con la posición del filtro que se este operando en el momento\n');
        fprintf(fid, '--SALIDAS\n');
        fprintf(fid, '--bias_term: termino de bias de la neurona\n');
        fprintf(fid, '--weight : peso de la neurona correspondiente al address\n');
        fprintf(fid, 'library IEEE;\n');
        fprintf(fid, 'use IEEE.STD_LOGIC_1164.ALL;\n');
        fprintf(fid, 'use IEEE.NUMERIC_STD.ALL;\n');
        fprintf(fid, 'use work.tfg_irene_package.ALL;\n');
        fprintf(fid, 'entity ROM1_%d is\n', num);
        fprintf(fid, '\tPort ( address : in std_logic_vector(log2c(mult1) - 1 downto 0);\n');
        fprintf(fid, '\t\t     bias_term :out unsigned (input_size + weight_size + 3 - 1  downto 0); \n');
        fprintf(fid, '\t\t     weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));\n');
        fprintf(fid, 'end ROM1_%d; \n', num);
        fprintf(fid, 'architecture Behavioral of ROM1_%d is\n', num');
        fprintf(fid, 'begin\n');
        fprintf(fid, 'bias_term<= "%s" ;\n', dec2q(bias_term, 6, 12, 'bin'));
        fprintf(fid, 'with address select weight <= \n');
        
        for i = 0:mul -1
            fprintf(fid, '\t"%s" when "%s", -- %d\n', dec2q(pesos(i + 1), 1, 6, 'bin'), dec2bin(i, ceil(log2(mul))), i );
        end
        
        fprintf(fid, '\t"%s" when others; \n ', dec2q(0, 1, 6, 'bin'));
        fprintf(fid, 'end Behavioral;\n\n');        
    
    fclose(fid);
    
end  