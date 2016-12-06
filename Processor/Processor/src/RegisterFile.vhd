LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg is
	PORT(clk, regWrite: IN STD_LOGIC;
		dataIN: IN UNSIGNED (16 DOWNTO 0);
		dr, sr1, sr2: IN UNSIGNED (4 DOWNTO 0);
		readReg1, readReg2: OUT (16 DOWNTO 0)
		);
END ENTITY reg;

ARCHITECTURE behavioral OF reg IS
	TYPE ram IS ARRAY (0 TO 8) OF UNSIGNED (16 DOWNTO 0);
	SIGNAL regs: ram := (OTHERS => (OTHERS=> '0'));

BEGIN
	PROCESS(clk)
		BEGIN
			IF clk'EVENT AND clk = '1' THEN
				IF regWrite = '1' THEN
					regs(TO_INTEGER(dr)) <= dataIN;
				END IF;
			END IF;
		END PROCESS;
	readReg1 <= regs(TO_INTEGER(sr1));
	readReg2 <= regs(TO_INTEGER(sr2));
END behavioral;
