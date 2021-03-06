library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------

entity ALU_16 is
port(	  
	A, B		:	in std_logic_vector(15 downto 0);
	R			:	out std_logic_vector(15 downto 0);
	S0,S1,S2	:	in std_logic;
	Status		:	out std_logic_vector(2 downto 0)
);
end ALU_16;

architecture Structural of ALU_16 is
---------------------------------------------
Component Adder_16
port(	  
	A, B	:	in std_logic_vector(15 downto 0);
	S		:	out std_logic_vector(15 downto 0);
	Cout	:	out std_logic
);
end component;
---------------------------------------------
component Subtractor_16
port(	  
	A, B	:	in std_logic_vector(15 downto 0);
	S		:	out std_logic_vector(15 downto 0);
	SignBit	:	out std_logic
);
end component;
---------------------------------------------
component Multiplier_16
port(	  
	A, B		:	in std_logic_vector(15 downto 0);
	S			:	out std_logic_vector(15 downto 0);
	overflow	:	out std_logic
);
end component; 
---------------------------------------------
component Multiplexer_8to1_by16
port(	  
	D0, D1, D2, D3, D4, D5, D6, D7	:	in std_logic_vector(15 downto 0);
	S0, S1, S2						:	in std_logic;	-- S2 is msb, S0 is lsb
	F								:	out std_logic_vector(15 downto 0)
);
end component;

signal AdderResult, SubtractorResult, MultiplierResult, Result : std_logic_vector(15 downto 0);
signal overflowAdd, overflowMult, negativeSub : std_logic;
constant zeros : std_logic_vector(15 downto 0) := "0000000000000000";

begin
	
	adder: Adder_16 port map (A,B,AdderResult, overflowAdd);
	
	subtract: Subtractor_16 port map (A,B,SubtractorResult,negativeSub);
	
	multiply: Multiplier_16 port map (A,B,MultiplierResult,overflowMult);
	
	mux: Multiplexer_8to1_by16 port map (AdderResult,MultiplierResult,A,B,SubtractorResult,zeros,zeros,zeros,S0,S1,S2,Result);

	status(0) <= (negativeSub and not S0 and not S1 and S2) or (Result(15) and not S1 and not S2);
	--if all bits are low then the result is zero						
	status(1) <= NOT (Result(15) or Result(14) or Result(13) or Result(12) or Result(11) or Result(10) or Result(9) or Result(8) 
				   or Result(7) or Result(6) or Result(5) or Result(4) or Result(3) or Result(2) or Result(1) or Result(0));
	status(2) <= (overflowAdd and not S0 and not S1 and not S2) or (overflowMult and S0 and not S1 and not S2);
	
	R <= Result;

end architecture; 