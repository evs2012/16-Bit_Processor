library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------

entity Multiplexer_2to1 is
port(	  
	D0, D1		:	in std_logic;
	Contrtol	:	in std_logic;  -- S2 is msb, S0 is lsb
	F			:	out std_logic
);
end Multiplexer_2to1;

architecture Structural of Multiplexer_2to1 is
begin
	F <= (D0 AND NOT Contrtol) OR
		 (D1 AND Contrtol);
end architecture; 