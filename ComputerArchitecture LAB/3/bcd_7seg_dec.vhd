
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY bcd_7seg_dec IS
	PORT(
			inputs: IN STD_LOGIC_VECTOR (3 downto 0);
			a,b,c,d,e,f,g: OUT STD_LOGIC);
END bcd_7seg_dec;

ARCHITECTURE decoder of bcd_7seg_dec IS
	SIGNAL output: STD_LOGIC_VECTOR (6 downto 0);
BEGIN
	WITH inputs SELECT
	output <=		"1111110" WHEN "0000",
					"0110000" WHEN "0001",
					"1101101" WHEN "0010",
					"1111001" WHEN "0011",
					"0110011" WHEN "0100",
					"1011011" WHEN "0101",
					"1011111" WHEN "0110",
					"1110000" WHEN "0111",
					"1111111" WHEN "1000",
					"1111011" WHEN "1001",
					"0000000" WHEN others;
-- Separate the output vector to make individual pin outputs
	a <= output(6);
	b <= output(5);
	c <= output(4);
	d <= output(3);
	e <= output(2);
	f <= output(1);
	g <= output(0);
END decoder;