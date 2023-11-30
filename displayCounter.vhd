library ieee;
use ieee.std_logic_1164.all;

entity displayCounter is
port(buttom0 : in std_logic;
	  clk     : in std_logic;
	  rst     : in std_logic;
	  outputdisplay0 : out std_logic_vector(3 downto 0);
	  outputmux1 : out std_logic_vector(6 downto 0));
end displayCounter;

architecture behavior of displayCounter is
-- signals
signal s : std_logic := '0';
signal clk5, clk10, clk25, clk50 : std_logic := '0';
signal outmux : std_logic := '0';
signal outmachine : std_logic_vector(1 downto 0) := "00";

signal outcounter0, outcounter1, outcounter2, outcounter3 : std_logic_vector(3 downto 0);

signal outbcd0, outbcd1, outbcd2, outbcd3 : std_logic_vector(6 downto 0);
-- levando em conta um botao que vale 0
signal btn_deb : std_logic := '0';

signal outlastmux : std_logic_vector(6 downto 0);
-- saida seletor do Controlador_display
signal seletormux : std_logic_vector(1 downto 0);
signal outdisplay : std_logic_vector(3 downto 0);

signal outffd : std_logic := '0';
signal inp_statemach : std_logic := '0';

component divisorClock is
port(slt     : in std_logic_vector(1 downto 0);
     clk     : in std_logic;
	  rst     : in std_logic;
	  low_clk : out std_logic);
end component;

component mux is
port(in0 : in std_logic;
     in1 : in std_logic;
	  in2 : in std_logic;
	  in3 : in std_logic;
	  ctrl : in std_logic_vector(1 downto 0);
	  output : out std_logic
);
end component;

component state_machine is
port(
		btn : std_logic;
		rst : in std_logic; 
		output: out std_logic_vector(1 downto 0));
end component;

component counter is
port(clk  : in std_logic;
	  rst  : in std_logic;
	  out0 : out std_logic_vector(3 downto 0);
	  out1 : out std_logic_vector(3 downto 0);
	  out2 : out std_logic_vector(3 downto 0);
	  out3 : out std_logic_vector(3 downto 0));
end component;

component controlador_display is
    Port ( clock : in STD_LOGIC;
				s_mux : out STD_LOGIC_VECTOR (1 downto 0);
           saida : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component modulo_BCD is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           saida : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component MUX4_1 is
    Port ( entrada_A, entrada_B, entrada_C, entrada_D : in STD_LOGIC_VECTOR (6 downto 0);
           saida : out STD_LOGIC_VECTOR (6 downto 0);
           seletor : in STD_LOGIC_VECTOR (1 downto 0));
end component;

component debouncer is
port(input  : in std_logic;
	  rst    : in std_logic;
	  clk    : in std_logic;
	  output : out std_logic);
end component;

component ffd is
port(D   : in std_logic;
	  rst : in std_logic;
	  clk : in std_logic;
	  Q   : out std_logic);
end component;

begin
ffd0 : ffd port map(
			D   => btn_deb,
			rst => rst,
			clk => clk,
			Q   => outffd);

deb : debouncer port map(
		input  => buttom0,
		rst    => rst,
		clk    => clk,
		output => btn_deb);

inp_statemach <= btn_deb and not outffd;

state_mach : state_machine port map(
				btn => inp_statemach,
				rst => rst,
				output => outmachine);

clock0 : divisorClock port map(
				slt => "00",
				clk => clk,
				rst => rst,
				low_clk => clk5);

clock1 : divisorClock port map(
				slt => "01",
				clk => clk,
				rst => rst,
				low_clk => clk10);

clock2 : divisorClock port map(
				slt => "10",
				clk => clk,
				rst => rst,
				low_clk => clk25);
	
clock3 : divisorClock port map(
				slt => "11",
				clk => clk,
				rst => rst,
				low_clk => clk50);
				
mux41 : mux port map(
				in0 => clk5,
				in1 => clk10,
				in2 => clk25,
				in3 => clk50,
				ctrl => outmachine,
				output => outmux);

counter0 : counter port map(
				clk => outmux,
				rst => rst,
				out0 => outcounter0,
				out1 => outcounter1,
				out2 => outcounter2,
				out3 => outcounter3);

bcd0 : modulo_BCD port map(
				entrada => outcounter0,
				saida   => outbcd0);

bcd1 : modulo_BCD port map(
				entrada => outcounter1,
				saida   => outbcd1);

bcd2 : modulo_BCD port map(
				entrada => outcounter2,
				saida   => outbcd2);				

bcd3 : modulo_BCD port map(
				entrada => outcounter3,
				saida   => outbcd3);

display : controlador_display port map(
				clock => clk, -- ta recebendo clock da placa
				s_mux => seletormux,
				saida => outdisplay);
				
mux41out : MUX4_1 port map(
				entrada_A => outbcd0,
				entrada_B => outbcd1,
				entrada_C => outbcd2,
				entrada_D => outbcd3,
				seletor   => seletormux,
				saida     => outlastmux);

outputdisplay0 <= outdisplay;
outputmux1 <= outlastmux;
				
end behavior;