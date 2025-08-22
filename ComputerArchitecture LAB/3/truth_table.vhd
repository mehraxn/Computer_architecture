LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY truth_table IS
	PORT(
			d: IN		STD_LOGIC_VECTOR (2 downto 0);
			y: OUT	STD_LOGIC);
END truth_table;

ARCHITECTURE a OF truth_table IS
BEGIN
	WITH d SELECT
		y <=  '1' WHEN "001",
				'1' WHEN	"101",
				'1' WHEN "110",
				'0' WHEN others;
END a;