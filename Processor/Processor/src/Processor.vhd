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
component PC is
	port(	  
		clk		:	in std_logic;
		PC_next	:	in std_logic_vector(4 downto 0);
		PC		:	out std_logic_vector(4 downto 0)
	);
end component PC;

component PC_increment is
	port(	  
		PC		:	in std_logic_vector(4 downto 0);
		PC_next	:	out std_logic_vector(4 downto 0)
	);
end component PC_increment;

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

component SignExtend is
	port(	  
		input	:	in std_logic_vector(7 downto 0);
		output	:	out std_logic_vector(15 downto 0)
	);
end component SignExtend;

component ALU_16 is
	port(	  
		A, B		:	in std_logic_vector(15 downto 0);
		R			:	out std_logic_vector(15 downto 0);
		S0,S1,S2	:	in std_logic;
		Status		:	out std_logic_vector(2 downto 0)
	);
end component ALU_16;

-----------------------------------------------------------------------
-- Signals:
-----------------------------------------------------------------------
SIGNAL readReg1, readReg2, dataIn, instr: std_logic_vector(15 DOWNTO 0);
--control signals
SIGNAL ALUop, ALUstatus : std_logic_vector(2 downto 0);
SIGNAL MemRead, MemToReg, MemWrite, ALUsource, RegWrite : std_logic;
SIGNAL SignExtendedValue, regFileDataOut1, regFileDataOut2, ALUinputB, RegWriteData, ALUresult : std_logic_vector(15 downto 0);
SIGNAL PC, PC_next : std_logic_vector(5 downto 0);

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
	PC: PC port map (clk, PC_next, PC);
	--Program Counter Incrementer
	PCI: PC_increment port map (PC, PC_next);
	--Instruction Memory
	IM: InstructionMemory port map (PC, clk, instr);
	--Control Unit
	CU: ControlUnit port map (opcode ,MemRead, MemToReg, MemWrite, ALUsource, RegWrite, ALUop);
	--Register File
	RF: reg port map (clk, RegWrite, RegWriteData, b, c, a,	regFileDataOut1, regFileDataOut2); --not 100% on the b,c,a placement
	--Sign Extender
	SE: SignExtend port map (value, SignExtendedValue);
	--ALU Source Mux
	ALUSM: Multiplexer_2to1_by16 port map (regFileDataOut2, SignExtendedValue, ALUsource, ALUinputB)
	--ALU
	ALU: ALU_16	port map (regFileDataOut1, ALUinputB, ALUresult, ALUop(0), ALUop(1), ALUop(2), ALUstatus);
	--Data Memory
	
	--Mem To Reg Mux

END ARCHITECTURE;
