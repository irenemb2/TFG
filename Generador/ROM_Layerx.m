function ROM_Layerx(mul, pesos, num, bias_term, layer, number_of_layers)
   
    name = sprintf('ROM%d_%d.vhd',layer, num);
    fid = fopen(name, 'wt');
       
   
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
        fprintf(fid, 'entity ROM%d_%d is\n',layer, num);
        fprintf(fid, '\tPort (address : in STD_LOGIC_VECTOR(log2c(mult%d) + log2c(number_of_layers%d) - 1 downto 0);\n', layer, layer);
        fprintf(fid, '\t\t    bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); \n');
        fprintf(fid, '\t\t    weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));\n');
        fprintf(fid, 'end ROM%d_%d; \n',layer, num);
        fprintf(fid, 'architecture Behavioral of  ROM%d_%d is\n',layer, num);
        fprintf(fid, 'begin\n');
        fprintf(fid, 'bias_term<= "%s" ;\n', dec2q(bias_term, 6, 12, 'bin'));
        fprintf(fid, '\twith address select weight <= \n');
        o = 1;
        for i = 0:mul -1
            for j = 0 : number_of_layers -1
            fprintf(fid, '\t\t "%s" when "%s%s", -- %d \n', dec2q(pesos(o), 1, 6, 'bin'),  dec2bin(i, ceil(log2(mul - 1))), dec2bin(j, ceil(log2(number_of_layers - 1))), o );
            o = o+ 1;
            end 
        end
        
        fprintf(fid, '\t\t "%s" when others; \n ', dec2q(0, 1, 6, 'bin'));
        fprintf(fid, 'end Behavioral;\n\n');        
    
    fclose(fid);
    
end  