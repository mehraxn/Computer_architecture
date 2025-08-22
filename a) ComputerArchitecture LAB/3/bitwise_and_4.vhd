

-- 4-bit bitwise and function
-- y0 = a0 and b0; y1 = a1 and b1; etc.

ENTITY bitwise_and_4 IS
	PORT(
			a0, a1, a2, a3: IN BIT;
			b0, b1, b2, b3: IN BIT;
			y0, y1, y2, y3: OUT BIT);
END bitwise_and_4;
ARCHITECTURE and_gate of bitwise_and_4 IS
BEGIN
	y0 <= a0 and b0;
	y1 <= a1 and b1;
	y2 <= a2 and b2;
	y3 <= a3 and b3;
END and_gate;