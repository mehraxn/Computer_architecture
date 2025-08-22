

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY compare8 IS
	PORT(
			a,b : IN STD_LOGIC_VECTOR (7 downto 0);
			agtb, aeqb, altb: OUT STD_LOGIC);
END compare8;
ARCHITECTURE a OF compare8 IS
	SIGNAL compare: STD_LOGIC_VECTOR (2 downto 0);
BEGIN
	PROCESS (a,b)
		BEGIN
			IF a<b THEN
				compare <= "110";
			ELSIF a=b THEN
				compare <= "101";
			ELSIF a>b THEN
				compare <= "011";
			ELSE
				compare <= "111";
			END IF;
			agtb <= compare(2);
			aeqb <= compare(1);
			altb <= compare(0);
		END PROCESS;
END a;