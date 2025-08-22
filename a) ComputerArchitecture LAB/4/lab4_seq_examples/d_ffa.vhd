
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY d_ffa IS
	PORT(
			D, Reset, Clock: IN STD_LOGIC;
			Q: OUT STD_LOGIC);
END d_ffa;

ARCHITECTURE behavior OF d_ffa IS
BEGIN
	PROCESS(Reset,Clock)
	BEGIN
		IF Reset='0' THEN
			Q <= '0';
		ELSIF Clock'EVENT and Clock='1' THEN
			Q <= D;
		END IF;
	END PROCESS;
END behavior;