----------------------------------------------------------------------------------
-- Engineer: Rafael B. Schvittz
-- Create Date: 27.11.2023 22:23:29
-- Module Name: MUX4_1 - Behavioral
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

entity MUX4_1 is
    Port ( entrada_A, entrada_B, entrada_C, entrada_D : in STD_LOGIC_VECTOR (6 downto 0);
           saida : out STD_LOGIC_VECTOR (6 downto 0);
           seletor : in STD_LOGIC_VECTOR (1 downto 0));
end MUX4_1;

architecture Behavioral of MUX4_1 is

begin

    saida <= 
    entrada_A when seletor = "00" else
    entrada_B when seletor = "01" else
    entrada_C when seletor = "10" else
    entrada_D;


end Behavioral;
