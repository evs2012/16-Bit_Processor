-- I think he means control unit when he says instruction decoder.
-- Needs to be structural

-- The decode step is the register file as well as the control unit
-- this should take instruction[1:3] (yes 0 is unused) and output
-- control signals such as RegWrite, ALUsource, MemWrite, ALUop, and
-- such, pretty much all the blue lines in the processor picture.
-- Some of these won't be needed becasue there is no j type.
-- because there is no funct part of the instructions this unit can
-- control the ALU directly, there is no need for the ALU control 


-- Instructions and op codes are:
-- S0	S1	S2	Format	Operation				Mnemonic
-----------------------------------------------------------
-- 0	0	0	R		Signed Addition			add
-- 0	0	1	R		Signed Multiplication	mult
-- 0	1	0	R		Passthrough A			pa
-- 0	1	1	R		Passthrough B			pb
-- 1	0	0	R		Signed Subtraction		sub
-- 1	0	1	I		Load Immediate			ldi --passthrough b, alu source is 1, mem to reg is 0
-- 1	1	0	I		Store halfword			sh
-- 1	1	1	I		Load halfword			lh -- passthrough b, alu source is 1, mem to reg is 1

-- ALU control
-- 000			001				010	011	100				101	110		111
-- AdderResult,MultiplierResult,A,B,SubtractorResult,zeros,zeros,zeros

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------

entity Multiplexer_2to1 is
port(	  
	S		:	in std_logic_vector(0 to 2);
	MemRead, MemToReg, MemWrite, ALUsource, RegWrite : out std_logic;
	ALUop : out std_logic_vector(2 downto 0)
);
end Multiplexer_2to1;

architecture Structural of Multiplexer_2to1 is
begin

end architecture; 