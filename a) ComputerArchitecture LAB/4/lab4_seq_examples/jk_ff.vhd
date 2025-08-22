
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY jk_ff IS
	PORT(
			j,k,clk : IN STD_LOGIC;
			q: BUFFER STD_LOGIC);
END jk_ff;
ARCHITECTURE behavior OF jk_ff IS
BEGIN
	PROCESS
		variable jk:std_logic_vector (1 downto 0);
		BEGIN
			WAIT UNTIL clk='1';
			jk := j&k;
			CASE (jk) IS
				WHEN "01" =>
					q <= '0';
				WHEN "10" =>
					q <= '1';
				WHEN "11" =>
					q <= not q;
				WHEN others => 
					NULL;		
			END CASE;
		END PROCESS;
END behavior;