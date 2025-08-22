
-- Four-channel multiplexer
-- One of four inputs (d3..d0) is directed to output y
-- base on the status of bits (s1,s0)

ENTITY mux4sel IS
	PORT(
			d: IN BIT_VECTOR (3 downto 0);
			s:	IN BIT_VECTOR (1 downto 0);
			y: OUT BIT);
			
END mux4sel;
ARCHITECTURE mux4to1 OF mux4sel IS
BEGIN
-- selecterd signal assignment
MUX4: WITH s SELECT
			y <= 	d(0) WHEN "00",
					d(1) WHEN "01",
					d(2) WHEN "10",
					d(3) WHEN "11";
END mux4to1;