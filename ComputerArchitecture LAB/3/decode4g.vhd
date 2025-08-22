

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY decode4g IS
	PORT(
			d: IN INTEGER range 0 to 3;
			g: IN STD_LOGIC;
			y:	OUT STD_LOGIC_VECTOR (0 to 3));
			
END decode4g;
ARCHITECTURE a OF decode4g IS
BEGIN
		y <= 	"1000" WHEN (d=0 and g='0') ELSE
		 		"0100" WHEN (d=1 and g='0') ELSE
				"0010" WHEN (d=2 and g='0') ELSE
				"0001" WHEN (d=3 and g='0') ELSE
				"0000";
END a;