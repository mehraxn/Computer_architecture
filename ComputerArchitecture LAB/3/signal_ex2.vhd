

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY signal_ex2 IS
	PORT(
			a,b,c,d :IN STD_LOGIC;
			y: OUT STD_LOGIC);
END signal_ex2;
ARCHITECTURE cct of signal_ex2 IS
--DECLARE SIGNAL
	SIGNAL a_xor_b: STD_LOGIC;
BEGIN
-- Define signal in terms of ports a and b
	a_xor_b <= ((not a) and b) or (a and (not b));
-- Combine signal with ports c and d
	y <= a_xor_b or ((not c) and d);
END cct;
	