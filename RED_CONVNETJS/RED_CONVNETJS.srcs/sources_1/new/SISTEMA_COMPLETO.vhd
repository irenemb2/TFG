-----------------------------------SISTEMA COMPLETO-------------------------------------
--ESTE SISTEMA CORRESPONDE A UNA RED NEURONAL CONVOLUCIONAL CON LAS DIMENSIONES QUE SE ESPECIFIQUEN EN LA LIBRERIA
--ENTRADAS
--wea : permite la escritura en la memoria RAM de entrada, proviene de la uart
--ena : el enable de la RAM, también viene de la UART
--dina : señal de entrada a la memoria que se corresponderá con los pixeles de la imágen a analizar
--address_uart : dirección de la memoria de entrada que se escribe en cada momento, viene de la UART
--start : señal que empieza la ejecución del programa entero
--SALIDAS
--dato_ready: señal que indica que hay un dato disponible en la red
--dato_out: dato procesado por la última capa de la neurona
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tfg_irene_package.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SISTEMA_COMPLETO is
    Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          wea : IN STD_LOGIC;
          ena : IN STD_LOGIC;
          dina : IN STD_LOGIC_VECTOR(input_size - 1 DOWNTO 0);
          start : in std_logic;
          dato_ready : out std_logic);
end SISTEMA_COMPLETO;

architecture Behavioral of SISTEMA_COMPLETO is
--MODULOS COMUNES

component RAM
Port(
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component PAR2SER
Port (data_in : in STD_LOGIC_VECTOR(input_size - 1 downto 0);
      count : in STD_LOGIC_VECTOR( input_size downto 0);
      serial_out : out STD_LOGIC);
end component;

component CONV
    Port (data_in : in std_logic;
          clk : in std_logic;
          reset : in std_logic;
          cont_s : in unsigned(1 downto 0);
          next_pipeline_step : in std_logic;
          weight : in STD_LOGIC_VECTOR(weight_size - 1 downto 0);
          data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));
end component;

component RELU
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      next_pipeline_step : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
      bias_term : in unsigned (input_size + weight_size + 3 -1  downto 0);
      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
      index : in std_logic);
end component; 

component MAXPOOL
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      next_dato_pool : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));
end component;

--MODULOS CAPA1

component GEN1
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      cont_s : out unsigned(1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      mul: out std_logic_vector(log2c(mult1) - 1 downto 0);
      dato_out1: out std_logic;
      dato_out2 : out std_logic;
      dato_in : in std_logic;
      next_pipeline_step : out std_logic);
end component;
component INTERFAZ_ET1
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
end component;
component ROM1_1
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;

component ROM1_2
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_3
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_4
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_5
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_6
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_7
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_8
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_9
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_10
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_11
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_12
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_13
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_14
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_15
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM1_16
Port (address : in std_logic_vector(log2c(mult1) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;

--MODULOS CAPA 2

component GEN2
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      cont_s : out unsigned(1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers2) - 1 downto 0);
      mul: out std_logic_vector(log2c(mult2) - 1 downto 0);
      dato_out1 : out std_logic;
      dato_out2 : out std_logic;
      index : out std_logic;
      en_neurona : out std_logic;
      next_dato_pool : out std_logic;
      next_pipeline_step : out std_logic);
end component;

component INTERFAZ_ET2
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      dato_out : out std_logic;
      dato_cero : out std_logic;
      cero : out std_logic;
      conv2_col : out unsigned(log2c(conv2_column) - 1 downto 0);
      conv2_fila : out  unsigned(log2c(conv2_row) - 1 downto 0);
      pool3_col : out unsigned(log2c(pool3_column) - 1 downto 0);
      pool3_fila : out  unsigned(log2c(pool3_row) - 1 downto 0);
      conv3_col : in unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : in  unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : in unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : in unsigned(log2c(pool4_row) - 1 downto 0));
end component;

component MUX
     Port (data_in0 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in1 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in2 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in3 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in4 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in5 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in6 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in7 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in8 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in9 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in10 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in11 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in12 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in13:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in14 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in15:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           index : in  STD_LOGIC_VECTOR(log2c(number_of_layers2) - 1 downto 0);
           data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1  downto 0));
end component;

component ROM2_1
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_2
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_3
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_4
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_5
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_6
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_7
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_8
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_9
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_10
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_11
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_12
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_13
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_14
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_15
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_16
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_17
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_18
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_19
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM2_20
Port (address : in STD_LOGIC_VECTOR(log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
	  bias_term :out UNSIGNED(input_size + weight_size + 3 - 1  downto 0); 
	  weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;

--MODULOS CAPA 3

component GEN3
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
      cont_s : out unsigned(1 downto 0);
      count : out STD_LOGIC_VECTOR( input_size   downto 0);
      mul: out std_logic_vector(log2c(mult3) - 1 downto 0);
      dato_out1 : out std_logic;
      dato_out2 : out std_logic;
      index : out std_logic;
      en_neurona : out std_logic;
      next_dato_pool : out std_logic;
      next_pipeline_step : out std_logic);
end component;

component INTERFAZ_ET3
Port (clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      dato_in : in std_logic;
      dato_cero : out std_logic;
      cero : out std_logic;
      dato_out : out std_logic;
      conv3_col : out unsigned(log2c(conv3_column) - 1 downto 0);
      conv3_fila : out unsigned(log2c(conv3_row) - 1 downto 0);
      pool4_col : out unsigned(log2c(pool4_column) - 1 downto 0);
      pool4_fila : out unsigned(log2c(pool4_row) - 1 downto 0));    
end component;

component MUX2
     Port (data_in0 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in1 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in2 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in3 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in4 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in5 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in6 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in7 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in8 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in9 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in10 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in11 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in12 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in13:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in14 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in15:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in16:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in17:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in18:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in19:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           index : in  STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
           data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));
end component;
component ROM3_1
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_2
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_3
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_4
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_5
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_6
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_7
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_8
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_9
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_10
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_11
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_12
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_13
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_14
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_15
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_16
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_17
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_18
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_19
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;
component ROM3_20
Port (address : in STD_LOGIC_VECTOR(log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
      bias_term :out unsigned (input_size + weight_size + 3 -1  downto 0); 
      weight : out STD_LOGIC_VECTOR(weight_size - 1 downto 0));
end component;

--MODULO CAPA 4
component MUX3
    Port ( data_in0 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in1 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in2 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in3 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in4 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in5 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in6 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in7 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in8 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in9 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in10 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in11 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in12 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in13:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in14 : in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in15:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in16:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in17:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in18:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           data_in19:  in STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
           index : in  STD_LOGIC_VECTOR(log2c(number_of_layers3) - 1 downto 0);
           data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0));
end component;
component GEN4
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      dato_in : in std_logic;
      dato_out : out std_logic;
      capa : out STD_LOGIC_VECTOR(log2c(number_of_layers4) - 1 downto 0);
      index : out std_logic;
      next_dato_pool : out std_logic);
end component;
----------------SEÑALES AUXILIARES-------------------
signal data_out : STD_LOGIC_VECTOR(input_size + weight_size + 3 -1  downto 0);
signal address_uart : STD_LOGIC_VECTOR(log2c(number_of_inputs + 1) - 1  downto 0);
--MEMORIA DE ENTRADA

signal address_ram : std_logic_vector(11 downto 0);
signal address_interfaz : std_logic_vector(11 downto 0);
signal data_in : std_logic_vector(input_size - 1 downto 0);
signal padding_aux : std_logic;
--CAPA 1

signal dato_in_1, dato_procesado1, dato_in_gen1, next_pipeline_step1, cero1, nuevo_dato2, nuevo_dato_et2 : std_logic;
signal count1 : std_logic_vector(input_size downto 0 );
signal mul1 : std_logic_vector(log2c(mult1) - 1 downto 0);
signal cont_s1 : unsigned (1 downto 0);
signal conv2_col:  unsigned(log2c(conv2_column) - 1 downto 0);
signal conv2_fila :  unsigned(log2c(conv2_row) - 1 downto 0);
signal pool3_col : unsigned(log2c(pool3_column) - 1 downto 0);
signal pool3_fila : unsigned(log2c(pool3_row) - 1 downto 0);
signal conv3_col :  unsigned(log2c(conv3_column) - 1 downto 0);
signal conv3_fila :  unsigned(log2c(conv3_row) - 1 downto 0);
signal pool4_col : unsigned(log2c(pool4_column) - 1 downto 0);
signal pool4_fila : unsigned(log2c(pool4_row) - 1 downto 0);
signal data_in_capa1 : std_logic_vector(input_size - 1 downto 0);
signal data_in_filtro1 : std_logic;
signal data_in_relu1, data_in_relu2, data_in_relu3, data_in_relu4, data_in_relu5, data_in_relu6, data_in_relu7, data_in_relu8, data_in_relu9, data_in_relu10, data_in_relu11, data_in_relu12, data_in_relu13, data_in_relu14, data_in_relu15, data_in_relu16 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
signal data_out_relu1, data_out_relu2, data_out_relu3, data_out_relu4, data_out_relu5, data_out_relu6, data_out_relu7, data_out_relu8, data_out_relu9, data_out_relu10, data_out_relu11, data_out_relu12, data_out_relu13, data_out_relu14, data_out_relu15, data_out_relu16 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
signal weight_aux1, weight_aux2, weight_aux3, weight_aux4, weight_aux5, weight_aux6, weight_aux7, weight_aux8, weight_aux9, weight_aux10, weight_aux11, weight_aux12, weight_aux13, weight_aux14, weight_aux15, weight_aux16: STD_LOGIC_VECTOR(weight_size - 1 downto 0);
signal bias_term_aux1, bias_term_aux2, bias_term_aux3, bias_term_aux4, bias_term_aux5, bias_term_aux6, bias_term_aux7, bias_term_aux8, bias_term_aux9, bias_term_aux10, bias_term_aux11, bias_term_aux12, bias_term_aux13, bias_term_aux14, bias_term_aux15, bias_term_aux16 : unsigned (input_size + weight_size + 3 -1  downto 0);

--CAPA 2

signal dato_cero2, dato_in_2, dato_procesado2, dato_in_gen2, next_pipeline_step2, cero2, en_neurona2, index2, next_dato_pool2, nuevo_dato3, nuevo_dato_et3 : std_logic;
signal count2 : std_logic_vector(input_size downto 0 );
signal mul2 : std_logic_vector(log2c(mult2) - 1 downto 0);
signal cont_s2 : unsigned (1 downto 0);
signal capa2 : std_logic_vector(log2c(number_of_layers2) - 1 downto 0);
signal data_in_pool2 , data_out_pool2: std_logic_vector (input_size + weight_size + 3 - 1 downto 0);
signal data_pool2, data_in_capa2 : std_logic_vector(input_size - 1 downto 0);
signal data_in_filtro2, data_out_par2ser2: std_logic;
signal address2 : std_logic_vector ( log2c(mult2) + log2c(number_of_layers2) - 1 downto 0);
signal weight_aux21, weight_aux22, weight_aux23, weight_aux24, weight_aux25, weight_aux26, weight_aux27, weight_aux28, weight_aux29, weight_aux210, weight_aux211, weight_aux212, weight_aux213, weight_aux214, weight_aux215, weight_aux216,  weight_aux217,  weight_aux218,  weight_aux219,  weight_aux220: STD_LOGIC_VECTOR(weight_size - 1 downto 0);
signal bias_term_aux21, bias_term_aux22, bias_term_aux23, bias_term_aux24, bias_term_aux25, bias_term_aux26, bias_term_aux27, bias_term_aux28, bias_term_aux29, bias_term_aux210, bias_term_aux211, bias_term_aux212, bias_term_aux213, bias_term_aux214, bias_term_aux215, bias_term_aux216, bias_term_aux217, bias_term_aux218, bias_term_aux219, bias_term_aux220 : unsigned (input_size + weight_size + 3 -1  downto 0);
signal data_in_relu21, data_in_relu22, data_in_relu23, data_in_relu24, data_in_relu25, data_in_relu26, data_in_relu27, data_in_relu28, data_in_relu29, data_in_relu210, data_in_relu211, data_in_relu212, data_in_relu213, data_in_relu214, data_in_relu215, data_in_relu216, data_in_relu217, data_in_relu218, data_in_relu219, data_in_relu220 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
signal data_out_relu21, data_out_relu22, data_out_relu23, data_out_relu24, data_out_relu25, data_out_relu26, data_out_relu27, data_out_relu28, data_out_relu29, data_out_relu210, data_out_relu211, data_out_relu212, data_out_relu213, data_out_relu214, data_out_relu215, data_out_relu216, data_out_relu217, data_out_relu218, data_out_relu219, data_out_relu220 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);


--CAPA 3

signal dato_cero3, dato_in_3, dato_procesado3, dato_in_gen3, next_pipeline_step3, cero3, en_neurona3, index3, next_dato_pool3, nuevo_dato4, nuevo_dato_et4 : std_logic;
signal count3 : std_logic_vector(input_size downto 0 );
signal mul3 : std_logic_vector(log2c(mult3) - 1 downto 0);
signal cont_s3 : unsigned (1 downto 0);
signal capa3 : std_logic_vector(log2c(number_of_layers3) - 1 downto 0);
signal data_in_pool3 , data_out_pool3: std_logic_vector (input_size + weight_size + 3 - 1 downto 0);
signal data_pool3, data_in_capa3 : std_logic_vector(input_size - 1 downto 0);
signal data_in_filtro3, data_out_par2ser3: std_logic;
signal address3 : std_logic_vector ( log2c(mult3) + log2c(number_of_layers3) - 1 downto 0);
signal weight_aux31, weight_aux32, weight_aux33, weight_aux34, weight_aux35, weight_aux36, weight_aux37, weight_aux38, weight_aux39, weight_aux310, weight_aux311, weight_aux312, weight_aux313, weight_aux314, weight_aux315, weight_aux316,  weight_aux317,  weight_aux318,  weight_aux319,  weight_aux320: STD_LOGIC_VECTOR(weight_size - 1 downto 0);
signal bias_term_aux31, bias_term_aux32, bias_term_aux33, bias_term_aux34, bias_term_aux35, bias_term_aux36, bias_term_aux37, bias_term_aux38, bias_term_aux39, bias_term_aux310, bias_term_aux311, bias_term_aux312, bias_term_aux313, bias_term_aux314, bias_term_aux315, bias_term_aux316, bias_term_aux317, bias_term_aux318, bias_term_aux319, bias_term_aux320 : unsigned (input_size + weight_size + 3 -1  downto 0);
signal data_in_relu31, data_in_relu32, data_in_relu33, data_in_relu34, data_in_relu35, data_in_relu36, data_in_relu37, data_in_relu38, data_in_relu39, data_in_relu310, data_in_relu311, data_in_relu312, data_in_relu313, data_in_relu314, data_in_relu315, data_in_relu316, data_in_relu317, data_in_relu318, data_in_relu319, data_in_relu320 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
signal data_out_relu31, data_out_relu32, data_out_relu33, data_out_relu34, data_out_relu35, data_out_relu36, data_out_relu37, data_out_relu38, data_out_relu39, data_out_relu310, data_out_relu311, data_out_relu312, data_out_relu313, data_out_relu314, data_out_relu315, data_out_relu316, data_out_relu317, data_out_relu318, data_out_relu319, data_out_relu320 : STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);


--CAPA 4
signal index4, next_dato_pool4 : std_logic;
signal capa4 : std_logic_vector(log2c(number_of_layers4) - 1 downto 0);
signal data_in_pool4 : std_logic_vector (input_size + weight_size + 3 - 1 downto 0);
begin
--MEMORIA DE ENTRADA
address_ram <= address_uart when (wea = '1') else address_interfaz;
RAM_MEMORY: RAM
Port map(
  dina => dina,
  clka => clk,
  wea => wea,
  ena => ena, 
  addra => address_ram,
  douta => data_in
);
----CAPA 1

dato_in_1 <= nuevo_dato2 or dato_procesado1 ;

GEN_ENABLE: GEN1 
port map(
  clk => clk,
  rst => rst,
  dato_in => dato_in_gen1,
  count => count1,
  mul => mul1,
  cont_s => cont_s1,
  dato_out1 => dato_procesado1,
  dato_out2 => nuevo_dato_et2,

  next_pipeline_step => next_pipeline_step1
);

INTERFAZ_1: INTERFAZ_ET1
Port map(
  clk => clk,
  reset => rst,
  dato_in => dato_in_1,
  conv2_col => conv2_col,
  conv2_fila => conv2_fila,
  pool3_col => pool3_col,
  pool3_fila => pool3_fila,
  conv3_col => conv3_col,
  conv3_fila => conv3_fila,
  pool4_col => pool4_col,
  pool4_fila => pool4_fila,
  address => address_interfaz,
  cero => cero1,
  dato_out => dato_in_gen1
);

data_in_capa1 <= data_in when (cero1 = '0') else (others=>'0');

CONVERSOR : par2ser      
port map(
  data_in => data_in_capa1,
  count => count1,
  serial_out => data_in_filtro1
); 


MEMROM1_1 : ROM1_1
    port map (
        address => mul1,
        weight => weight_aux1,
        bias_term => bias_term_aux1);
              
CONV1_1 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux1,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu1);
RELU1_1 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu1,
    bias_term => bias_term_aux1,
    index => index2,
    data_out => data_out_relu1);  
    
MEMROM1_2 : ROM1_2
    port map (
        address => mul1,
        weight => weight_aux2,
        bias_term => bias_term_aux2);           
CONV1_2 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux2,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu2);
RELU1_2 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu2,
    bias_term => bias_term_aux2,
    index => index2,
    data_out => data_out_relu2);     
        
MEMROM1_3 : ROM1_3
    port map (
        address => mul1,
        weight => weight_aux3,
        bias_term => bias_term_aux3);  
CONV1_3 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux3,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu3);
RELU1_3 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu3,
    bias_term => bias_term_aux3,
    index => index2,
    data_out => data_out_relu3);  

MEMROM1_4 : ROM1_4
    port map (
        address => mul1,
        weight => weight_aux4,
        bias_term => bias_term_aux4);       
CONV1_4 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux4,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu4);
 RELU1_4 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu4,
    bias_term => bias_term_aux4,
    index => index2,
    data_out => data_out_relu4); 
  
MEMROM1_5 : ROM1_5
    port map (
        address => mul1,
        weight => weight_aux5,
        bias_term => bias_term_aux5);       
CONV1_5 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux5,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu5);
RELU1_5 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu5,
    bias_term => bias_term_aux5,
    index => index2,
    data_out => data_out_relu5);  
        
MEMROM1_6 : ROM1_6
    port map (
        address => mul1,
        weight => weight_aux6,
        bias_term => bias_term_aux6);       
CONV1_6 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux6,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu6);
RELU1_6 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu6,
    bias_term => bias_term_aux6,
    index => index2,
    data_out => data_out_relu6); 
    
MEMROM1_7 : ROM1_7
    port map (
        address => mul1,
        weight => weight_aux7,
        bias_term => bias_term_aux7);  
CONV1_7 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux7,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu7);
RELU1_7 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu7,
    bias_term => bias_term_aux7,
    index => index2,
    data_out => data_out_relu7); 

MEMROM1_8 : ROM1_8
    port map (
        address => mul1,
        weight => weight_aux8,
        bias_term => bias_term_aux8);           
CONV1_8 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux8,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu8);
RELU1_8 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu8,
    bias_term => bias_term_aux8,
    index => index2,
    data_out => data_out_relu8); 
           
MEMROM1_9 : ROM1_9
    port map (
        address => mul1,
        weight => weight_aux9,
        bias_term => bias_term_aux9);       
CONV1_9 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux9,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu9);   
RELU1_9 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu9,
    bias_term => bias_term_aux9,
    index => index2,
    data_out => data_out_relu9);  

MEMROM1_10 : ROM1_10
    port map (
        address => mul1,
        weight => weight_aux10,
        bias_term => bias_term_aux10);          
CONV1_10 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux10,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu10);
RELU1_10 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu10,
    bias_term => bias_term_aux10,
    index => index2,
    data_out => data_out_relu10);  

MEMROM1_11 : ROM1_11
    port map (
        address => mul1,
        weight => weight_aux11,
        bias_term => bias_term_aux11);             
CONV1_11 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux11,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu11);
 RELU1_11 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu11,
    bias_term => bias_term_aux11,
    index => index2,
    data_out => data_out_relu11);  
      
MEMROM1_12 : ROM1_12
    port map (
        address => mul1,
        weight => weight_aux12,
        bias_term => bias_term_aux12);         
CONV1_12 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux12,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu12);
RELU1_12 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu12,
    bias_term => bias_term_aux12,
    index => index2,
    data_out => data_out_relu12); 
     
MEMROM1_13 : ROM1_13
    port map (
        address => mul1,
        weight => weight_aux13,
        bias_term => bias_term_aux13);              
CONV1_13 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux13,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu13);
 RELU1_13 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu13,
    bias_term => bias_term_aux13,
    index => index2,
    data_out => data_out_relu13); 

MEMROM1_14 : ROM1_14
    port map (
        address => mul1,
        weight => weight_aux14,
        bias_term => bias_term_aux14);  
CONV1_14 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux14,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu14);   
RELU1_14 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu14,
    bias_term => bias_term_aux14,
    index => index2,
    data_out => data_out_relu14);  

MEMROM1_15 : ROM1_15
    port map (
        address => mul1,
        weight => weight_aux15,
        bias_term => bias_term_aux15);    
CONV1_15 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux15,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu15);    
RELU1_15 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu15,
    bias_term => bias_term_aux15,
    index => index2,
    data_out => data_out_relu15);  

MEMROM1_16 : ROM1_16
    port map (
        address => mul1,
        weight => weight_aux16,
        bias_term => bias_term_aux16);    
CONV1_16 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro1,
        weight => weight_aux16,
        cont_s =>cont_s1,
        next_pipeline_step => next_pipeline_step1,
        data_out => data_in_relu16);     
RELU1_16 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step1,
    data_in => data_in_relu16,
    bias_term => bias_term_aux16,
    index => index2,
    data_out => data_out_relu16);  
    
----CAPA 2
dato_in_2 <= nuevo_dato3 or dato_procesado2;
GEN_ENABLE2 : GEN2
    port map(
    clk => clk,
    rst=> rst,
    capa => capa2,
    dato_in => dato_in_gen2,
    count => count2,
    cont_s => cont_s2,
    mul => mul2,
    next_pipeline_step => next_pipeline_step2,
    en_neurona => en_neurona2,
    index => index2,
    next_dato_pool => next_dato_pool2,
    dato_out1 => dato_procesado2, 
    dato_out2 => nuevo_dato_et3); 
    
dato_in_gen2 <= (dato_cero2 or nuevo_dato_et2);
INTERFAZ_2 : INTERFAZ_ET2
    port map(
    clk => clk,
    reset=> rst,
    dato_in => dato_in_2,
    dato_cero =>dato_cero2,
    cero => cero2,
    dato_out => nuevo_dato2, 
    conv2_col => conv2_col,
    conv2_fila => conv2_fila,
    pool3_col => pool3_col,
    pool3_fila => pool3_fila,
    conv3_col => conv3_col,
    conv3_fila => conv3_fila,
    pool4_col => pool4_col,
    pool4_fila => pool4_fila);  --Mandar este dato tambien a la generador enable 1

MUX_1 : MUX
   port map(
    data_in0 => data_out_relu1,
    data_in1 => data_out_relu2,
    data_in2 => data_out_relu3,
    data_in3 => data_out_relu4,
    data_in4 => data_out_relu5,
    data_in5 => data_out_relu6,
    data_in6 => data_out_relu7,
    data_in7 => data_out_relu8,
    data_in8 => data_out_relu9,
    data_in9 => data_out_relu10,
    data_in10 => data_out_relu11,
    data_in11 => data_out_relu12,
    data_in12 => data_out_relu13,
    data_in13 => data_out_relu14,
    data_in14 => data_out_relu15,
    data_in15 => data_out_relu16,
    index => capa2,
    data_out => data_in_pool2);
     
POOL2 : MAXPOOL
   port map(
   clk => clk,
   rst => rst,
   data_in => data_in_pool2,
   next_dato_pool => next_dato_pool2,
   data_out => data_out_pool2);
   
data_pool2<= data_out_pool2(input_size + weight_size - 3 downto input_size - 3 + 1);
data_in_capa2 <= data_pool2 when cero2 = '0' else (others => '0');

CONVERSOR2 : par2ser      
port map(
  data_in => data_in_capa2,
  count => count2,
  serial_out => data_out_par2ser2
); 

data_in_filtro2 <= data_out_par2ser2 when en_neurona2 = '1' else '0';
address2 <= capa2 & mul2;


MEMROM2_1 : ROM2_1
    port map (
        address => address2,
        weight => weight_aux21,
        bias_term => bias_term_aux21);
              
CONV2_1 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux21,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu21);
RELU2_1 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu21,
    bias_term => bias_term_aux21,
    index => index3,
    data_out => data_out_relu21);  
MEMROM2_2: ROM2_2
    port map (
        address => address2,
        weight => weight_aux22,
        bias_term => bias_term_aux22);
              
CONV2_2 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux22,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu22);
RELU2_2 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu22,
    bias_term => bias_term_aux22,
    index => index2,
    data_out => data_out_relu22);  
MEMROM2_3 : ROM2_3
    port map (
        address => address2,
        weight => weight_aux23,
        bias_term => bias_term_aux23);
              
CONV2_3 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux23,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu23);
RELU2_3 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu23,
    bias_term => bias_term_aux23,
    index => index3,
    data_out => data_out_relu23);  
MEMROM_24 : ROM2_4
    port map (
        address => address2,
        weight => weight_aux24,
        bias_term => bias_term_aux24);
              
CONV2_4 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux24,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu24);
RELU2_4 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu24,
    bias_term => bias_term_aux24,
    index => index3,
    data_out => data_out_relu24);  
MEMROM2_5 : ROM2_5
    port map (
        address => address2,
        weight => weight_aux25,
        bias_term => bias_term_aux25);
              
CONV2_5 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux25,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu25);
RELU2_5 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu25,
    bias_term => bias_term_aux25,
    index => index3,
    data_out => data_out_relu25);  
MEMROM_26 : ROM2_6
    port map (
        address => address2,
        weight => weight_aux26,
        bias_term => bias_term_aux26);
              
CONV2_6 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux26,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu26);
RELU2_6 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu26,
    bias_term => bias_term_aux26,
    index => index3,
    data_out => data_out_relu26);  
MEMROM2_7 : ROM2_7
    port map (
        address => address2,
        weight => weight_aux27,
        bias_term => bias_term_aux27);
              
CONV2_7 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux27,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu27);
RELU2_7 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu27,
    bias_term => bias_term_aux27,
    index => index3,
    data_out => data_out_relu27);  
MEMROM2_8: ROM2_8
    port map (
        address => address2,
        weight => weight_aux28,
        bias_term => bias_term_aux28);
              
CONV2_8 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux28,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu28);
RELU2_8 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu28,
    bias_term => bias_term_aux28,
    index => index3,
    data_out => data_out_relu28);  
MEMROM_29 : ROM2_9
    port map (
        address => address2,
        weight => weight_aux29,
        bias_term => bias_term_aux29);
              
CONV2_9 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux29,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu29);
RELU2_9: RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu29,
    bias_term => bias_term_aux29,
    index => index3,
    data_out => data_out_relu29);  
MEMROM2_10 : ROM2_10
    port map (
        address => address2,
        weight => weight_aux210,
        bias_term => bias_term_aux210);
              
CONV2_10 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux210,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu210);
RELU2_10 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu210,
    bias_term => bias_term_aux210,
    index => index3,
    data_out => data_out_relu210);  
MEMROM2_11 : ROM2_11
    port map (
        address => address2,
        weight => weight_aux211,
        bias_term => bias_term_aux211);
              
CONV2_11 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux211,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu211);
RELU2_11 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu211,
    bias_term => bias_term_aux211,
    index => index3,
    data_out => data_out_relu211);  
MEMROM2_12 : ROM2_12
    port map (
        address => address2,
        weight => weight_aux212,
        bias_term => bias_term_aux212);
              
CONV2_12 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux212,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu212);
RELU2_12 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu212,
    bias_term => bias_term_aux212,
    index => index3,
    data_out => data_out_relu212);  
MEMROM2_13 : ROM2_13
    port map (
        address => address2,
        weight => weight_aux213,
        bias_term => bias_term_aux213);
              
CONV2_13 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux213,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu213);
RELU2_13 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu213,
    bias_term => bias_term_aux213,
    index => index3,
    data_out => data_out_relu213);  
MEMROM2_14 : ROM2_14
    port map (
        address => address2,
        weight => weight_aux214,
        bias_term => bias_term_aux214);
              
CONV2_14 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux214,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu214);
RELU2_14 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu214,
    bias_term => bias_term_aux214,
    index => index3,
    data_out => data_out_relu214);  
MEMROM2_15 : ROM2_15
    port map (
        address => address2,
        weight => weight_aux215,
        bias_term => bias_term_aux215);
              
CONV2_15 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux215,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu215);
RELU2_15 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu215,
    bias_term => bias_term_aux215,
    index => index3,
    data_out => data_out_relu215);  
MEMROM2_16 : ROM2_16
    port map (
        address => address2,
        weight => weight_aux216,
        bias_term => bias_term_aux216);
              
CONV2_16 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux216,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu216);
RELU2_16 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu216,
    bias_term => bias_term_aux216,
    index => index3,
    data_out => data_out_relu216);  
MEMROM2_17 : ROM2_17
    port map (
        address => address2,
        weight => weight_aux217,
        bias_term => bias_term_aux217);
              
CONV2_17 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux217,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu217);
RELU2_17 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu217,
    bias_term => bias_term_aux217,
    index => index3,
    data_out => data_out_relu217);  
MEMROM2_18 : ROM2_18
    port map (
        address => address2,
        weight => weight_aux218,
        bias_term => bias_term_aux218);
              
CONV2_18 : CONV
     port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux218,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu218);
RELU2_18 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu218,
    bias_term => bias_term_aux218,
    index => index3,
    data_out => data_out_relu218);  
MEMROM2_19 : ROM2_19
    port map (
        address => address2,
        weight => weight_aux219,
        bias_term => bias_term_aux219);
              
CONV2_19 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux219,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu219);
RELU2_19 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu219,
    bias_term => bias_term_aux219,
    index => index3,
    data_out => data_out_relu219);  
MEMROM2_20 : ROM2_20
    port map (
        address => address2,
        weight => weight_aux220,
        bias_term => bias_term_aux220);
              
CONV2_20 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux220,
        cont_s =>cont_s2,
        next_pipeline_step => next_pipeline_step2,
        data_out => data_in_relu220);
RELU2_20 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step2,
    data_in => data_in_relu220,
    bias_term => bias_term_aux220,
    index => index3,
    data_out => data_out_relu220); 
    
----CAPA 3

dato_in_3 <= start or dato_procesado3 or next_pipeline_step3;

GEN_ENABLE3 : GEN3
    port map(
    clk => clk,
    rst=> rst,
    capa => capa3,
    dato_in => dato_in_gen3,
    next_pipeline_step => next_pipeline_step3,
    en_neurona => en_neurona3,
    index => index3,
    mul => mul3,
    next_dato_pool => next_dato_pool3,
    count => count3,
    cont_s => cont_s3,
    dato_out1 => dato_procesado3, 
    dato_out2 => nuevo_dato4); 

dato_in_gen3 <= (dato_cero3 or nuevo_dato_et3);

Interfaz3 : INTERFAZ_ET3
port map(
    clk => clk, 
    reset => rst,
    dato_in => dato_in_3,
    dato_cero => dato_cero3,
    cero => cero3,
    dato_out => nuevo_dato3,
    conv3_col => conv3_col,
    conv3_fila => conv3_fila,
    pool4_fila => pool4_fila,
    pool4_col => pool4_col);
  
 MUX_2 : MUX2
   port map(
    data_in0 => data_out_relu21,
    data_in1 => data_out_relu22,
    data_in2 => data_out_relu23,
    data_in3 => data_out_relu24,
    data_in4 => data_out_relu25,
    data_in5 => data_out_relu26,
    data_in6 => data_out_relu27,
    data_in7 => data_out_relu28,
    data_in8 => data_out_relu29,
    data_in9 => data_out_relu210,
    data_in10 => data_out_relu211,
    data_in11 => data_out_relu212,
    data_in12 => data_out_relu213,
    data_in13 => data_out_relu214,
    data_in14 => data_out_relu215,
    data_in15 => data_out_relu216,
    data_in16 => data_out_relu217,
    data_in17 => data_out_relu218,
    data_in18 => data_out_relu219,
    data_in19 => data_out_relu220,
    index => capa3,
    data_out => data_in_pool3); 
 POOL3 : MAXPOOL
   port map(
   clk => clk,
   rst => rst,
   data_in => data_in_pool3,
   next_dato_pool => next_dato_pool3,
   data_out => data_out_pool3); 
   
--CAMBIAR

data_pool3<= data_out_pool3(input_size + weight_size - 3 downto input_size - 3 + 1);
data_in_capa3 <= data_pool3 when cero3 = '0' else (others => '0');

CONVERSOR3 : par2ser      
port map(
  data_in => data_in_capa3,
  count => count3,
  serial_out => data_out_par2ser3
); 

data_in_filtro3 <= data_out_par2ser3 when en_neurona3 = '1' else '0';
address3 <= capa3 & mul3;  


MEMROM3_1 : ROM3_1
    port map (
        address => address3,
        weight => weight_aux31,
        bias_term => bias_term_aux31);
              
CONV3_1 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux31,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu31);
RELU3_1 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu31,
    bias_term => bias_term_aux31,
    index => index4,
    data_out => data_out_relu31);  
MEMROM3_2: ROM3_2
    port map (
        address => address3,
        weight => weight_aux32,
        bias_term => bias_term_aux32);
              
CONV3_2 : CONV
      port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux32,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu32);
RELU3_2 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu32,
    bias_term => bias_term_aux32,
    index => index4,
    data_out => data_out_relu32);  
MEMROM3_3 : ROM3_3
    port map (
        address => address3,
        weight => weight_aux33,
        bias_term => bias_term_aux33);
              
CONV3_3 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux33,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu33);
RELU3_3 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu33,
    bias_term => bias_term_aux33,
    index => index4,
    data_out => data_out_relu33);  
MEMROM3_4 : ROM3_4
    port map (
        address => address3,
        weight => weight_aux34,
        bias_term => bias_term_aux34);
              
CONV3_4 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux34,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu34);
RELU3_4 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu34,
    bias_term => bias_term_aux34,
    index => index4,
    data_out => data_out_relu34);  
MEMROM3_5 : ROM3_5
    port map (
        address => address3,
        weight => weight_aux35,
        bias_term => bias_term_aux35);
              
CONV3_5 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux35,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu35);
RELU3_5 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu35,
    bias_term => bias_term_aux35,
    index => index4,
    data_out => data_out_relu35);  
MEMROM3_6 : ROM3_6
    port map (
        address => address3,
        weight => weight_aux36,
        bias_term => bias_term_aux36);
              
CONV3_6 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux36,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu36);
RELU3_6 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu36,
    bias_term => bias_term_aux36,
    index => index4,
    data_out => data_out_relu36);  
MEMROM3_7 : ROM3_7
    port map (
        address => address3,
        weight => weight_aux37,
        bias_term => bias_term_aux37);
              
CONV3_7 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro2,
        weight => weight_aux37,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu37);
RELU3_7 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu37,
    bias_term => bias_term_aux37,
    index => index4,
    data_out => data_out_relu37);  
MEMROM3_8: ROM3_8
    port map (
        address => address3,
        weight => weight_aux38,
        bias_term => bias_term_aux38);
              
CONV3_8 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux38,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu38);
RELU3_8 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu38,
    bias_term => bias_term_aux38,
    index => index4,
    data_out => data_out_relu38);  
MEMROM3_9 : ROM3_9
    port map (
        address => address3,
        weight => weight_aux39,
        bias_term => bias_term_aux39);
              
CONV3_9 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux39,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu39);
RELU3_9: RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu39,
    bias_term => bias_term_aux39,
    index => index4,
    data_out => data_out_relu39);  
MEMROM3_10 : ROM3_10
    port map (
        address => address3,
        weight => weight_aux310,
        bias_term => bias_term_aux310);
              
CONV3_10 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux310,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu310);
RELU3_10 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu310,
    bias_term => bias_term_aux310,
    index => index4,
    data_out => data_out_relu310);  
MEMROM3_11 : ROM3_11
    port map (
        address => address3,
        weight => weight_aux311,
        bias_term => bias_term_aux311);
              
CONV3_11 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux311,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu311);
RELU3_11 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu311,
    bias_term => bias_term_aux311,
    index => index4,
    data_out => data_out_relu311);  
MEMROM3_12 : ROM3_12
    port map (
        address => address3,
        weight => weight_aux312,
        bias_term => bias_term_aux312);
              
CONV3_12 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux312,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu312);
RELU3_12 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu312,
    bias_term => bias_term_aux312,
    index => index4,
    data_out => data_out_relu312);  
MEMROM3_13 : ROM3_13
    port map (
        address => address3,
        weight => weight_aux313,
        bias_term => bias_term_aux313);
              
CONV3_13 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux313,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu313);
RELU3_13 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu313,
    bias_term => bias_term_aux313,
    index => index4,
    data_out => data_out_relu313);  
MEMROM3_14 : ROM3_14
    port map (
        address => address3,
        weight => weight_aux314,
        bias_term => bias_term_aux314);
              
CONV3_14 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux314,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu314);
RELU3_14 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu314,
    bias_term => bias_term_aux314,
    index => index4,
    data_out => data_out_relu314);  
MEMROM3_15 : ROM3_15
    port map (
        address => address3,
        weight => weight_aux315,
        bias_term => bias_term_aux315);
              
CONV3_15 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux315,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu315);
RELU3_15 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu315,
    bias_term => bias_term_aux315,
    index => index4,
    data_out => data_out_relu315);  
MEMROM3_16 : ROM3_16
    port map (
        address => address3,
        weight => weight_aux316,
        bias_term => bias_term_aux316);
              
CONV3_16 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux316,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu316);
RELU3_16 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu316,
    bias_term => bias_term_aux316,
    index => index4,
    data_out => data_out_relu316);  
MEMROM3_17 : ROM3_17
    port map (
        address => address3,
        weight => weight_aux317,
        bias_term => bias_term_aux317);
              
CONV3_17 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux317,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu317);
RELU3_17 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu317,
    bias_term => bias_term_aux317,
    index => index4,
    data_out => data_out_relu317);  
ROM_318 : ROM3_18
    port map (
        address => address3,
        weight => weight_aux318,
        bias_term => bias_term_aux318);
              
CONV3_18 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux318,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu318);
RELU3_18 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu318,
    bias_term => bias_term_aux318,
    index => index4,
    data_out => data_out_relu318);  
MEMROM3_19 : ROM3_19
    port map (
        address => address3,
        weight => weight_aux319,
        bias_term => bias_term_aux319);
              
CONV3_19 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux319,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu319);
RELU3_19 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu319,
    bias_term => bias_term_aux319,
    index => index4,
    data_out => data_out_relu319);  
MEMROM3_20 : ROM3_20
    port map (
        address => address3,
        weight => weight_aux320,
        bias_term => bias_term_aux320);
              
CONV3_20 : CONV
    port map(
        clk => clk,
        Reset => rst,
        data_in => data_in_filtro3,
        weight => weight_aux320,
        cont_s =>cont_s3,
        next_pipeline_step => next_pipeline_step3,
        data_out => data_in_relu320);
RELU3_20 : RELU
    port map(
    clk => clk,
    rst => rst,
    next_pipeline_step => next_pipeline_step3,
    data_in => data_in_relu320,
    bias_term => bias_term_aux320,
    index => index4,
    data_out => data_out_relu320);  
--CAPA 4

GENERADOR4 : GEN4
port map(
     clk => clk,
     rst => rst,
     dato_in => nuevo_dato4,
     dato_out => dato_ready,
     capa => capa4,
     index => index4,
     next_dato_pool => next_dato_pool4);

MUX_3 : MUX3
   port map(
    data_in0 => data_out_relu31,
    data_in1 => data_out_relu32,
    data_in2 => data_out_relu33,
    data_in3 => data_out_relu34,
    data_in4 => data_out_relu35,
    data_in5 => data_out_relu36,
    data_in6 => data_out_relu37,
    data_in7 => data_out_relu38,
    data_in8 => data_out_relu39,
    data_in9 => data_out_relu310,
    data_in10 => data_out_relu311,
    data_in11 => data_out_relu312,
    data_in12 => data_out_relu313,
    data_in13 => data_out_relu314,
    data_in14 => data_out_relu315,
    data_in15 => data_out_relu316,
    data_in16 => data_out_relu317,
    data_in17 => data_out_relu318,
    data_in18 => data_out_relu319,
    data_in19 => data_out_relu320,
    index => capa4,
    data_out => data_in_pool4); 

POOL4 : MAXPOOL
   port map(
   clk => clk,
   rst => rst,
   data_in => data_in_pool4,
   next_dato_pool  => next_dato_pool4,
   data_out => data_out); 
       
end Behavioral;
