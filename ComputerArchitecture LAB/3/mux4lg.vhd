
-- Four-channel multiplexer
-- One of four inputs (d3..d0) is directed to output y
-- base on the status of bits (s1,s0)

ENTITY mux4lg IS
	PORT(
			d0, d1, d2, d3: IN BIT;
			s:	IN BIT_VECTOR (1 downto 0);
			y: OUT BIT);
			
END mux4lg;
ARCHITECTURE mux4to1 OF mux4lg IS
BEGIN
-- Concurrent signal assignment
	y <= ((not s(1)) and (not s(0)) and d0)
			or ((not s(1)) and ( s(0)) and d1)
			or (( s(1)) and (not s(0)) and d2)
			or (( s(1)) and ( s(0)) and d3);
				
END mux4to1;