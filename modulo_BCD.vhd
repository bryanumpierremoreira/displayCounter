----------------------------------------------------------------------------------
-- Engineer: Rafael B. Schvittz
-- Create Date: 27.11.2023 22:25:29
-- Module Name: modulo_BCD - Behavioral
-- Target Devices: Boolean Board
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modulo_BCD is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           saida : out STD_LOGIC_VECTOR (6 downto 0));
end modulo_BCD;

architecture Behavioral of modulo_BCD is

begin

--Este circuito é responsável por decodificar o dado de entrada (combinação binária de 0000 até 1001) fornecendo
--como saída os valores que definem a representação decimal do número no display de 7 segmentos

--MAPEAMENTO DA SAÍDA PARA O DISPLAY (IMPORTANTE)
-- ORDEM DOS BITS: A B C D E F G

    saida <=
            "1111110" when entrada = "0000" else
            "0110000" when entrada = "0001" else
            "1101101" when entrada = "0010" else
            "1111001" when entrada = "0011" else
            "0110011" when entrada = "0100" else
            "1011011" when entrada = "0101" else
            "1011111" when entrada = "0110" else
            "1110000" when entrada = "0111" else
            "1111111" when entrada = "1000" else
            "1111011" when entrada = "1001" else
            "0000000";


end Behavioral;
