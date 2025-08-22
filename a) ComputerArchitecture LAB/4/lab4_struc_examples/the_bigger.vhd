ENTITY the_bigger IS
	PORT( A: IN BIT_VECTOR (2 downto 0);
		  C: OUT BIT_VECTOR (2 downto 0));
end the_bigger;

ARCHITECTURE structural of the_bigger IS

	COMPONENT function1 --local
		PORT(	X: IN BIT_VECTOR (2 downto 0);
				Z: OUT BIT);
	END COMPONENT;
	
	COMPONENT function2 --local
		PORT(	X: IN BIT_VECTOR (2 downto 0);
				Z: OUT BIT);
	END COMPONENT;

BEGIN

	COM1:	function1
			port map(A, C(1));
			
	COM2: FUNCTION2
			port map (A, C(0));
END structural;

