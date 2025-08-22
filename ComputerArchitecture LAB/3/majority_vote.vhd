
ENTITY majority_vote IS
	PORT(
			a,b,c: IN BIT;
			y: OUT BIT);
END majority_vote;
ARCHITECTURE maj_vote of majority_vote IS
BEGIN
	y <= (a and b) or (b and c) or (a and c);
END maj_vote;