library ieee;
use ieee.std_logic_1164.all;

entity mux is
port(in0 : in std_logic;
     in1 : in std_logic;
	  in2 : in std_logic;
	  in3 : in std_logic;
	  ctrl : in std_logic_vector(1 downto 0);
	  output : out std_logic
);
end mux;

architecture behavior of mux is

-- signals
signal outand0, outand1, outand2, outand3 : std_logic := '0';
signal outand : std_logic := '0';
signal a,b : std_logic := '0';

begin
	a <= ctrl(0);
	b <= ctrl(1);
	
	outand0 <= in0 and not a and not b;
	outand1 <= in1 and a and not b;
	outand2 <= in2 and not a and b;
	outand3 <= in3 and a and b;

	outand <= outand0 or outand1 or outand2 or outand3;
	output <= outand;
end behavior;
