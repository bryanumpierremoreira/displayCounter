library ieee;
use ieee.std_logic_1164.all;

entity divisorClock is
port(slt     : in std_logic_vector(1 downto 0);
     clk     : in std_logic;
	  rst     : in std_logic;
	  low_clk : out std_logic);
end divisorClock;

architecture behavior of divisorClock is
-- signals
signal counter   : integer range 0 to 50000000 := 0;
signal preset    : integer range 0 to 50000000 := 0;

signal inter_out     : std_logic;

begin
	with slt select
		preset <= 4999999 when "00",
					 9999999 when "01",
					 24999999 when "10",
					 49999999 when "11";
					 
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