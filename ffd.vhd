library ieee;
use ieee.std_logic_1164.all;

-- defining the entity
entity ffd is
port(D   : in std_logic;
	  rst : in std_logic;
	  clk : in std_logic;
	  Q   : out std_logic);
end ffd;

architecture behavior of ffd is

-- signal
--component divisorClock is
--port(clk, rst  : in std_logic;
--	  clk1Hz    : out std_logic);
--end component;


begin
	process(clk,rst)
	begin
		if rst = '1' then
			Q <= '0';
		elsif(rising_edge(clk)) then
			Q <= D;
		end if;
	end process;
end behavior;