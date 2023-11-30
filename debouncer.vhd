library ieee;
use ieee.std_logic_1164.all;

-- defining the entity
entity debouncer is
port(input  : in std_logic;
	  rst    : in std_logic;
	  clk    : in std_logic;
	  output : out std_logic);
end debouncer;

architecture behavior of debouncer is

-- signal
signal intermediate_output0, intermediate_output1, intermediate_output2 : std_logic := '0';
signal andout : std_logic :='0';
component ffd is
port(D   : in std_logic;
	  rst : in std_logic;
	  clk : in std_logic;
	  Q   : out std_logic);
end component;

begin
ffd0 : ffd port map(
			D => input,
			rst => rst,
			clk =>clk,
			Q => intermediate_output0);

ffd1 : ffd port map(
			D => intermediate_output0,
			rst => rst,
			clk =>clk,
			Q => intermediate_output1);

ffd2 : ffd port map(
			D => intermediate_output1,
			rst => rst,
			clk =>clk,
			Q => intermediate_output2);			

andout <= intermediate_output0 and intermediate_output1 and intermediate_output2;		
output <= andout;
end behavior;