LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY quad_tri IS
	PORT(
			a: IN STD_LOGIC_VECTOR (3 downto 0);
			g: IN STD_LOGIC;
			y:	OUT STD_LOGIC_VECTOR (3 downto 0));
			
END quad_tri;
ARCHITECTURE quad_buff OF quad_tri IS
BEGIN
	WITH g SELECT
		y <= a WHEN '0',
		"ZZZZ" WHEN others;
END quad_buff;