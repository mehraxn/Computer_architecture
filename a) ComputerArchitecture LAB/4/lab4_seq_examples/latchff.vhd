
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY latchff IS
	PORT(
			d,clk : IN STD_LOGIC;
			q: OUT STD_LOGIC);
END latchff;
ARCHITECTURE behavior OF latchff IS
BEGIN
	PROCESS (d,clk)
		BEGIN
			IF clk = '1' THEN
				q <= d;
			END IF;
		END PROCESS;
END behavior;