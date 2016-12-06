LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Processor IS
PORT (clk : IN STD_LOGIC );
END Processor;

ARCHITECTURE structure OF Processor IS
-----------------------------------------------------------------------
-- Component Declaration
-----------------------------------------------------------------------
COMPONENT reg is
	PORT(clk, regWrite: IN std_logic;
		WriteData: IN std_logic_vector(15 DOWNTO 0);
		WriteRegister, Reg1, Reg2: IN std_logic_vector(4 DOWNTO 0);
		Reg1Data, Reg2Data: OUT std_logic_vector(15 DOWNTO 0)
		);
END COMPONENT reg; 

component ControlUnit is
	port(	  
		S		:	in std_logic_vector(0 to 2);
		MemRead, MemToReg, MemWrite, ALUsource, RegWrite : out std_logic;
		ALUop : out std_logic_vector(2 downto 0)
	);
end component ControlUnit; 

Component Multiplexer_2to1_by16 is
	port(	  
		D0, D1	:	in std_logic_vector(15 downto 0);
		Control	:	in std_logic;
		F		:	out std_logic_vector(15 downto 0)
	);
end Component Multiplexer_2to1_by16;

-----------------------------------------------------------------------
-- Signals:
-----------------------------------------------------------------------
SIGNAL readReg1, readReg2, dataIn, instr: std_logic_vector(15 DOWNTO 0);
--control signals
SIGNAL ALUop : std_logic_vector(2 downto 0);
SIGNAL MemRead, MemToReg, MemWrite, ALUsource, RegWrite : std_logic;

-----------------------------------------------------------------------
-- Aliasing
-----------------------------------------------------------------------
ALIAS opcode: std_logic_vector(2 DOWNTO 0) IS instr(14 DOWNTO 12);

-- R - Type Format
ALIAS c: std_logic_vector(3 DOWNTO 0) IS instr(11 DOWNTO 8);
ALIAS a: std_logic_vector(3 DOWNTO 0) IS instr(7 DOWNTO 4);
ALIAS b: std_logic_vector(3 DOWNTO 0) IS instr(3 DOWNTO 0);

-- I - Type format
ALIAS d: std_logic_vector(3 DOWNTO 0) IS instr(11 DOWNTO 8);
ALIAS value: std_logic_vector(7 DOWNTO 0) IS instr(7 DOWNTO 0);

BEGIN
	--Program Counter
	
	--Instruction Memory
	
	--Control Unit
	CU: ControlUnit port map (opcode ,MemRead, MemToReg, MemWrite, ALUsource, RegWrite, ALUop);
	--Register File
	
	--Sign Extender
	
	--ALU Source Mux
	
	--ALU
	
	--Data Memory
	
	--Mem To Reg Mux

END ARCHITECTURE;
