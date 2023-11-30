library ieee;
use ieee.std_logic_1164.all;

entity btnClock is
port(
     clk     : in std_logic;
	  rst     : in std_logic;
	  low_clk : out std_logic);
end btnClock;

architecture behavior of btnClock is

signal inter_out : std_logic := '0';
signal counter   : integer range 0 to 200000000 := 0;
signal preset    : integer range 0 to 200000000 := 200000000;

begin

process(clk,rst)
	begin
	
		if rst = '1' then
			counter <= 0;
			inter_out <= '0';
			low_clk <= '0';
		
		elsif(rising_edge(clk)) then
			if(counter = preset) then
				-- signal intermediario 
				inter_out <= not inter_out;
				-- saida real
				low_clk <= inter_out;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	--low_clk <= s_1Hz;
	end process;

end behavior;