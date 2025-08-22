

-- 4-bit bitwise and function
-- Y = A and B;

ENTITY bitwise_and_vec_4 IS
	PORT(
			a, b: IN BIT_VECTOR(3 downto 0);
			y: OUT BIT_VECTOR (3 downto 0));
END bitwise_and_vec_4;
ARCHITECTURE and_gate of bitwise_and_vec_4 IS
BEGIN
	y <= a and b;
END and_gate;