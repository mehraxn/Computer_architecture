
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY d_ff IS
	PORT(
			D, Clock: IN STD_LOGIC;
			Q		  : OUT STD_LOGIC);
END d_ff;

ARCHITECTURE behavior OF d_ff IS
BEGIN
	PROCESS(Clock)
	BEGIN
		IF Clock'EVENT and Clock='1' THEN
			Q <= D;
		END IF;
	END PROCESS;
END behavior;