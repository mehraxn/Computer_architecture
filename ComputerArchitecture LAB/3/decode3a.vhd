
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY decode3a IS
	PORT(
			d: IN STD_LOGIC_VECTOR (1 downto 0);
			g: IN STD_LOGIC;
			y: OUT STD_LOGIC_VECTOR (3 downto 0));
END decode3a;

ARCHITECTURE decoder of decode3a IS
	SIGNAL inputs: STD_LOGIC_VECTOR (2 downto 0);
BEGIN
	inputs(2) <= g;
	inputs(1 downto 0) <= d;
	WITH inputs SELECT
	y <= 	"0001" WHEN "000",
			"0010" WHEN "001",
			"0100" WHEN "010",
			"1000" WHEN "011",
			"0000" WHEN others;
END decoder;