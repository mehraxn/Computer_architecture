
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY d_ffs IS
	PORT(
			D, Reset, Clock: IN STD_LOGIC;
			Q: OUT STD_LOGIC);
END d_ffs;

ARCHITECTURE behavior OF d_ffs IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL Clock'EVENT and Clock='1';
			IF Reset = '0' THEN
				Q <= '0';
			ELSE
				Q <= D;
			END IF;
	END PROCESS;
END behavior;
