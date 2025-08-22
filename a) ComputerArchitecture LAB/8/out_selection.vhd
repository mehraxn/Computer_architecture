
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY out_selection IS
	PORT(
			clk, rst , in_data: IN STD_LOGIC;
			state_tx: IN STD_LOGIC_VECTOR (1 downto 0);
			tx: OUT STD_LOGIC);
END out_selection;

ARCHITECTURE behavior OF out_selection IS

BEGIN
	PROCESS(clk, rst)
	BEGIN
		IF (rst = '1') THEN
			tx <= '1';
		ELSIF (clk'EVENT and clk='1') THEN
			CASE state_tx IS
				WHEN "00" =>
					tx <= '1';
				WHEN "01" =>
					tx <= '0';
				WHEN "10" =>
					tx <= in_data;
				WHEN "11" =>
					tx <= '1';
			END CASE;
		END IF;
	END PROCESS;
END behavior;
