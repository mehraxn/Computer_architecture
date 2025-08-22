
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY div_freq IS
	GENERIC (N: INTEGER := 10);
	PORT(	clk, rst, en_div: IN STD_LOGIC;
			baud: OUT STD_LOGIC);
END div_freq;

ARCHITECTURE behavior OF div_freq IS
	SIGNAL count_baud: INTEGER RANGE 0 TO N := 0;
BEGIN
	PROCESS (clk, rst) 
	BEGIN
		IF rst = '1' THEN
			baud <= '0';
			count_baud <= 	0;
		ELSIF (clk'EVENT and clk = '1' and en_div = '1') THEN
			IF count_baud = N THEN
				count_baud <= 0;
				baud <= '1';
			ELSE
				count_baud <= count_baud + 1;
				baud <= '0';
			END IF;
		END IF;
	END PROCESS;
END behavior;