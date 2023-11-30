library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity
entity counter is
port(clk  : in std_logic;
	  rst  : in std_logic;
	  out0 : out std_logic_vector(3 downto 0);
	  out1 : out std_logic_vector(3 downto 0);
	  out2 : out std_logic_vector(3 downto 0);
	  out3 : out std_logic_vector(3 downto 0));
end counter;

-- behavior
architecture behavior of counter is
-- signal
signal counter  : integer range 0 to 9999 := 0;

begin
process(clk,rst)
	begin
		if rst = '1' then
			counter <= 0;
		
		elsif(rising_edge(clk)) then
			if(counter = 9999) then
				counter <= 0;
			else
				counter <= counter + 1;
				-- aqui eu quero que seja dividido a saida em 4 variaveis
				out0 <= std_logic_vector(to_unsigned(counter mod 10, out0'length));
            out1 <= std_logic_vector(to_unsigned((counter /10)  mod 10, out1'length));
            out2 <= std_logic_vector(to_unsigned((counter /100) mod 10, out2'length));
            out3 <= std_logic_vector(to_unsigned((counter /1000) mod 10, out3'length));
			end if;
		end if;
	end process;
end behavior;