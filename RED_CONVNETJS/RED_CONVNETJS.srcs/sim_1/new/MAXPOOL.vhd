-----------------------------------------MODULO MAXPOOL----------------------------------------------------------
--Este modulo va a realizar la operación de MaxPool, que consiste en calcular el máximo de un conjunto de datos.
--Esto se consigue comparando la entrada con el dato ya registrado, si es mayor se almacena la entrada y si no se descarta, 
--la señal  se resetea cada vez que se guarden tantas entradas como dimensión tenga el filtro
--ENTRADAS
--data_in : dato procesado por la capa de convolución y relu, que proviene del multiplexador
--next_dato_pool : señal que indica cuando ha terminado de procesarse una pasa de filtro
--SALIDAS
--data_out: señal de salida, sale una por cada pasada de filtro que corresponde con el dato más alto de los registrados
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
entity MAXPOOL is
Port (clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      next_dato_pool : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0);
      data_out : out STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0));
end MAXPOOL;

architecture Behavioral of MAXPOOL is
signal dato_reg, dato_reg2: STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0) := (others => '0');
signal dato_next: STD_LOGIC_VECTOR(input_size + weight_size + 3 - 1 downto 0) := (others => '0');

-- register 
begin
process(clk,rst) 
begin 
if (rst = '1') then 
    dato_reg <= (others=>'0');
    dato_reg2 <= (others=>'0');
elsif (clk'event and clk = '1') then 
    dato_reg <= dato_next;                  
    if(next_dato_pool = '1') then     --cuando la señal pool del generador se activa mandamos el dato de salida
       dato_reg2 <= dato_reg;
    end if;
end if;
end process; 
--next-state logic 
process(dato_reg, data_in, next_dato_pool)
begin
if(next_dato_pool = '0') then        --si la señal pool no esta a 1 comparamos los datos entrantes  
   if(data_in > dato_reg) then          --si el dato entrante es mayor que el dato anterior lo registramos
      dato_next <= data_in;
   else
      dato_next <= dato_reg;
   end if;
else 
      dato_next <= (others=>'0');  --si la señal pool está activa mandamos le dato de salida y ponemos a 0 el registro
end if;
end process;
--output logic 

data_out <= dato_reg2;

end Behavioral;

