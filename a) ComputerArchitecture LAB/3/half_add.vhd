

ENTITY half_add IS
	PORT(
			a,b: IN BIT;
			sum, carry: OUT BIT);
END half_add;
ARCHITECTURE adder of half_add IS
BEGIN
	sum <= a xor b;
	carry <= a and b;
END adder;