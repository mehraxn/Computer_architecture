
ENTITY select_example IS
	PORT(
			d: IN BIT_VECTOR (3 downto 0);
			y:	OUT BIT);
			
END select_example;
ARCHITECTURE cct OF select_example IS
BEGIN
	WITH d SELECT
		y <= 	'1' WHEN "0011",
		 		'1' WHEN "0110",
				'1' WHEN "1001",
				'1' WHEN "1100",
				'0' WHEN others;
				
END cct;