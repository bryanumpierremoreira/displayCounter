library ieee;
use ieee.std_logic_1164.all;

entity btn is
port(D		 : in std_logic;
     clk     : in std_logic;
	  rst     : in std_logic;
	  Q       : out std_logic);
end btn;

architecture behavior of btn is

signal inter_out : std_logic := '0';

begin

process(clk,rst)
	begin
	
		if rst = '1' then
			Q <= '0';
		
		elsif(rising_edge(clk)) then
			inter_out <= D;
			Q <= inter_out;
		end if;
	end process;

end behavior;