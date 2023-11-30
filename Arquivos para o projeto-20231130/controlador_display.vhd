----------------------------------------------------------------------------------
-- Engineer: Rafael B. Schvittz
-- Create Date: 27.11.2023 22:39:30
-- Module Name: controlador_display - Behavioral
-- Target Devices: Boolean Board
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controlador_display is
    Port ( clock : in STD_LOGIC;
	   s_mux : out STD_LOGIC_VECTOR (1 downto 0);
           saida : out STD_LOGIC_VECTOR (3 downto 0));
end controlador_display;

architecture Behavioral of controlador_display is

signal contador : integer :=0;
signal b : std_logic :='0';

signal s : unsigned (1 downto 0) := "00";

begin

 --divisor de rel�gio - 100khz considerando um clock da placa de 100MHz.
process(clock) 
begin
    if(rising_edge(clock)) then
        contador <= contador+1;
        if(contador = 5000-1) then
            b <= not b;
            contador <= 0;
        end if;
    end if;
end process;


--gera��o das sa�das necess�rias para conectar ao display de 7 segmentos
--os dois bits fazem o mapeamento para um dos 4 displays da Boolean Board
process(b) 
begin
    if(rising_edge(b)) then
        s <= s + 1;
    end if;
end process;

saida <= 
			"1110" when std_logic_vector(s) = "00" else
			"1101" when std_logic_vector(s) = "01" else
			"1011" when std_logic_vector(s) = "10" else
			"0111";

s_mux <= std_logic_vector(s);

end Behavioral;
