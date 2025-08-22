LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY truth_table_int IS
	PORT(
			d: IN		INTEGER RANGE 0 to 7;
			y: OUT	STD_LOGIC);
END truth_table_int;

ARCHITECTURE a OF truth_table_int IS
BEGIN
	WITH d SELECT
		y <=  '1' WHEN 1,
				'1' WHEN	5,
				'1' WHEN 6,
				'0' WHEN others;
END a;