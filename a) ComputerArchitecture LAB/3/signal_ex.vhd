

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY signal_ex IS
	PORT(
			a,b,c: IN STD_LOGIC;
			w,x,y,z: OUT STD_LOGIC);
END signal_ex;

ARCHITECTURE sig of signal_ex IS
-- Declaration area
-- Define signal here
	SIGNAL inputs: STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL outputs: STD_LOGIC_VECTOR (3 downto 0);
BEGIN
-- Concatenate input ports into 3-bit signal inputs
	inputs <= a & b & c;
	WITH inputs SELECT
	outputs <= 	"1000" WHEN "000",
					"0100" WHEN "001",
					"0110" WHEN "010",
					"1001" WHEN "011",
					"0110" WHEN "100",
					"0001" WHEN "101",
					"1001" WHEN "110",
					"0010" WHEN "111",
					"0000" WHEN others;
-- Separate signal into individual ports
	w <= outputs(3);
	x <= outputs(2);
	y <= outputs(1);
	z <= outputs(0);
END sig;