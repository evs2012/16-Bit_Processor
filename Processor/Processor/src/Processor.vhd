LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructionDecode IS
PORT (clk, regWrite: IN STD_LOGIC;
	instruction: IN UNSIGNED (15 DOWNTO 0);
	memWrite: IN UNSIGNED(15 DOWNTO 0);
	dataOut: OUT UNSIGNED(15 DOWNTO 0)
	);
END instructionDecode;

ARCHITECTURE structure OF instructionDecode IS

-- Component Declaration
COMPONENT reg is
	PORT(clk, regWrite: IN STD_LOGIC;
		dataIn: IN UNSIGNED (15 DOWNTO 0);
		dr, sr1, sr2: IN UNSIGNED (4 DOWNTO 0);
		readReg1, readReg2: OUT (15 DOWNTO 0)
		);
END COMPONENT reg;


SIGNAL readReg1, readReg2, dataIn, instr: UNSIGNED (15 DOWNTO 0);


ALIAS opcode: UNSIGNED (2 DOWNTO 0) IS instr (14 DOWNTO 12);

-- R - Type Format
ALIAS c: UNSIGNED (3 DOWNTO 0) IS instr (11 DOWNTO 8);
ALIAS a: UNSIGNED (3 DOWNTO 0) IS instr (7 DOWNTO 4);
ALIAS b: UNSIGNED (3 DOWNTO 0) IS instr (3 DOWNTO 0);

-- I - Type format
ALIAS d: UNSIGNED (3 DOWNTO 0) IS instr (11 DOWNTO 8);
ALIAS value: UNSIGNED (7 DOWNTO 0) IS instr (7 DOWNTO 0);






BEGIN

-- Component Instantiation 
Register: reg PORT MAP(clk, regWrite, );

END ARCHITECTURE;
