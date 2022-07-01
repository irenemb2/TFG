library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package tfg_irene_package is
function log2c (n: integer) return integer;
--ENTRADA
--matriz de entrada
constant input_size: integer := 8;
constant row_size_entrada: integer := 32;
constant column_size_entrada: integer :=32;
constant number_of_layers1 : integer := 3;
constant number_of_inputs: integer := column_size_entrada * row_size_entrada * number_of_layers1;

--Neurona Conv1

constant number_of_neurons1 : integer := 16;
constant weight_size: integer := 8;
constant conv1_row: integer := 5;
constant conv1_column: integer := 5;
constant conv1_stride: integer := 1;
constant conv1_padding: integer := 2;
constant conv1_size: integer := conv1_row* conv1_column;
constant mult1 : integer := conv1_size * number_of_layers1;
constant row_size : integer := row_size_entrada + (2 * conv1_padding);
constant column_size : integer := column_size_entrada + (2 * conv1_padding);
constant numer_of_inputs_padding : integer := row_size * column_size;

--SEGUNDA CAPA

constant row_size2: integer := (row_size_entrada - conv1_row +2 * conv1_padding)/conv1_stride + 1;
constant column_size2: integer :=32;
constant number_of_layers2 : integer := 16;
constant number_of_inputs2: integer := column_size2 * row_size2 * number_of_layers2;
constant numer_of_inputs_padding_2 : integer := (column_size2) + 1 * (row_size2 + 1);
--Pool2
constant pool2_row: integer := 2;
constant pool2_column: integer := 2;
constant pool2_stride: integer := 2;
constant pool2_size : integer := pool2_column * pool2_row;
--Neurona Conv2
constant conv2_size: integer := 25;
constant conv2_row: integer := 5;
constant conv2_column: integer := 5;
constant conv2_mult : integer := conv2_size;
constant conv2_stride: integer := 1;
constant conv2_padding: integer := 2;
constant mult2 : integer := conv2_size;


--TERCERA CAPA
constant row_size3: integer := 8;
constant column_size3: integer :=8;
constant number_of_layers3 : integer := 20;
constant number_of_inputs_3: integer := column_size3 * row_size3 * number_of_layers3;
constant numer_of_inputs_padding_3 : integer := (column_size3) + 1 * (row_size3 + 1);
--Pool3
constant pool3_row: integer := 2;
constant pool3_column: integer := 2;
constant pool3_stride: integer := 2;
constant pool3_size : integer := pool3_column * pool3_row;
--Neurona Conv3
constant conv3_size: integer := 25;
constant conv3_row: integer := 5;
constant conv3_column: integer := 5;
constant conv3_mult : integer := number_of_layers3 * conv3_size;
constant conv3_stride: integer := 1;
constant conv3_padding: integer := 2;
constant mult3 : integer := conv3_size;

--CUARTA CAPA
--Pool4
constant number_of_layers4 : integer := 20;
--constant result_row : integer := 2;
--constant result_column : integer := 2;
constant pool4_row: integer := 2;
constant pool4_column: integer := 2;
constant pool4_stride: integer := 2;
constant pool4_size : integer := pool4_column * pool4_row;

type vector_relu is array (natural range<>) of STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
end package tfg_irene_package;


package body tfg_irene_package is
function log2c(n:integer) return integer is
	   variable m, p: integer;
	begin
	   m:=0;
	   p:= 1;
	   while p<n loop
	       m := m+1;
	       p := p*2;
	   end loop;
	   return m;
	end log2c;
end package body;
