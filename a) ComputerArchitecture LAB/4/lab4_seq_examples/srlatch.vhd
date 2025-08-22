LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY srlatch is
	PORT(	set_not, reset_not: IN STD_LOGIC;
			q, q_not: INOUT STD_LOGIC);
	
	END srlatch;
	
ARCHITECTURE logic_operation OF srlatch IS
BEGIN
	q 		<= q_not nand set_not;
	q_not	<= q nand reset_not;
END logic_operation;
