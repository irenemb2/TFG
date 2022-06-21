fileName = "C:\Users\irene\Desktop\TFG\Matlab\Generador\pesos_sintratar_def.txt"; % filename in JSON extension
fid = fopen(fileName); % Opening the file
raw = fread(fid,inf); % Reading the contents
str = char(raw'); % Transformation
fclose(fid); % Closing the file
data = jsondecode(str); % Using the jsondecode function to parse JSON from string
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% SELECCIÓN DE PARÁMETROS%%%%%%%%%%%%%%%%%%%%%%
%----Parámetros de entrada
input_size = 8;                      %Tamaño de dato de entrada en bits
weight_size = 8;                     %Tamaño de peso de entrada
row_size_entrada = 32;               %Tamaño fila de imágen de entrada
column_size_entrada =32;             %Tamaño columna de imágen de entrada
capas = 4;                           %Tamaño de capas totales de la red
%----Parámetros de los filtros  (rellenar arrays con las dimensiones
%deseadas)
number_of_layers = [3; 16; 20; 20 ]; %Dimensión z de los filtros convolucionales
number_of_neurons = [16; 20; 20];    %Número de neuronas por capa
conv_row = [5;5;5];                  %Tamaño de filas de los filtros convolucionales
conv_column = [5;5;5];               %Tamaño de columnas de los filtros convolucionales
stride =[1;1;1];                     %Stride de los filtros convolucionales               
padding =[2;2;2];                    %Padding de los filtros convolucionales
pool_size = [2;2;2];                 %Tamaño de los filtros MaxPool (col*row)
pool_row = [2;2;2];                  %Tamaño de filas de los filtros MaxPool
pool_column = [2;2;2];               %Tamaño de las columnas de los filtros MaxPool
pool_stride = [2;2;2];               %Stride de los filtros MaxPool
mult = [75; 24;24];                  %Parámetro mult de cada filtro convolucional (filas * columnas * z)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%% GENERADOR MODULOS COMUNES %%%%%%%%%%%%%%%%%%%%%
GeneradorPar2Ser();
GeneradorConv();
GeneradorPool();
GeneradorReLU();
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GENERADOR ROMS %%%%%%%%%%%%%%%%%%%%%%%%%%%
pesos = zeros(mult(1), number_of_neurons(1));
bias_term = zeros(number_of_neurons(1), 1);
fn = fieldnames(data.layers{2,1}.filters(1).w);
fn1 = fieldnames(data.layers{2,1}.biases.w);
for c = 1 : number_of_neurons(1)
a = 1;
fn = fieldnames(data.layers{2,1}.filters(c).w);
for j = 1 : number_of_layers(1)
    for h = 1 : conv_row(1)
        for u = 1: conv_column(1)
          if( isnumeric(data.layers{2,1}.filters(c).w.(fn{a})) )
             pesos(a, c) = data.layers{2,1}.filters(c).w.(fn{a});
             a = a + 1 ; 
          end
        end
    end
end
bias_term(c) = data.layers{2,1}.biases.w.(fn1{c});
ROM_Layer1(mult(1), pesos(:,c), c, bias_term(c));

end
for i = 2 : capas - 1
pesos2 = zeros(mult(i) * number_of_neurons(i), number_of_neurons(i));
bias_term2 = zeros(number_of_neurons(i), 1);
indice = 5 + (3 * (i-2))
fn1 = fieldnames(data.layers{indice,1}.biases.w);
a = 1;
for c = 1 : number_of_neurons(i)
o = 0;
a = 1;
fn = fieldnames(data.layers{indice,1}.filters(c).w);
for j = 1 : conv_row(i)  
    for h = 1 : conv_column(i)
        o = o + 1;
        for u=1:number_of_layers(i)
        if( isnumeric(data.layers{indice,1}.filters(c).w.(fn{o + (25*(u-1))})) )
        pesos2(a, c) = data.layers{indice,1}.filters(c).w.(fn{o + (25*(u-1))});   
            a = a + 1;
        end
        end
    end      
end

bias_term2(c) = data.layers{indice,1}.biases.w.(fn1{c});
ROM_Layerx(mult(i), pesos2(:,c), c, bias_term2(c), i, number_of_layers(i+1));
end
end
%%
%%%%%%%%%%%%%%%%%%%%%%% GENERADOR MULTIPLEXADORES %%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : (capas - 1)
    GeneradorMux(i,number_of_layers(i + 1));
end
%%
%%%%%%%%%%%%%%%%%%%%%% GENERADOR INTERFACES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GeneradorInterfazCapa1(capas)
for i = 2 : capas - 1
GeneradorInterfazCapa(i, capas)
end
    
%%
%%%%%%%%%%%%%%%%%%%%%% GENERADOR SEÑALES DE CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%
 GeneradorControlCapa1(input_size, mult, pool_size(i));
for i = 2 : capas - 1
   GeneradorControlCapa(i,pool_size(i), mult(i), input_size, number_of_layers(i+1))
end
GeneradorControlUltimaCapa(capas);
%%
%%%%%%%%%%%%%%%%%%%%%%GENERADOR SISTEMA COMPLETO%%%%%%%%%%%%%%%%%%%%%%%%%%%
GeneradorSistemaCompleto(number_of_layers, capas, number_of_neurons);
GeneradorLibreria(input_size, row_size_entrada, column_size_entrada, number_of_layers, number_of_neurons, weight_size, conv_column, conv_row, stride, padding, pool_row, pool_column, pool_stride, capas)