library ieee;
use ieee.std_logic_1164.all;

-- defining the entity
entity state_machine is
port(
		--input : in std_logic_vector(1 downto 0);
		clk, rst : in std_logic; 
		output: out std_logic_vector(1 downto 0));
end state_machine;

architecture behavior of state_machine is
-- signal
type state is (R,A,B,C,D);
signal current_state, next_state : state;
signal clk1Hz : std_logic;

component divisorClock is
port(clk, rst  : in std_logic;
	  clk1Hz    : out std_logic);
end component;

begin
	divClock : divisorClock port map(
		clk => clk,
		rst => rst,
		clk1Hz => clk1Hz
	);
-- process for defining FSM timing
	synchronous : process(clk1Hz, rst, next_state)
	begin
	-- here we defined the states
		if(rst = '1') then
			current_state <= R;
		elsif(rising_edge(clk1Hz)) then
			current_state <= next_state;
			
		end if;
	end process;
		--processo para logica combinacional da maquina
	combinational : process(clk1Hz,current_state, rst)
	begin
	-- aqui definimos o comportamento da saida
		output <= "00";
		
		case(current_state) is
				when R =>
					output <= "00";
					next_state <= A;
				when A =>
					output <= "00";
					next_state <= B;
				when B =>
					output <= "01";
					next_state <= C;
				when C =>
					output <= "10";
					next_state <= D;
				when D =>
					output <= "11";
					next_state <= A;
		end case;
	end process;
end behavior;