
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY load_shift IS
	PORT( t_data_in : IN STD_LOGIC_VECTOR (7 downto 0);
		 clk, load, shift, rst : IN STD_LOGIC;
		 t_data_out : OUT STD_LOGIC);
END load_shift;

ARCHITECTURE behavior oF load_shift IS
	SIGNAl tmp_reg: STD_LOGIC_VECTOR (7 downto 0);
BEGIN
	PROCESS (rst,clk)
	BEGIN
		IF (rst = '1') THEN
			tmp_reg <= (OTHERS=>'0');
			t_data_out <= '0';
		ELSIF (clk'EVENT and clk = '1') THEN
			IF (load = '1') THEN
				tmp_reg <= t_data_in;
			ELSIF (shift = '1') THEN
				t_data_out <= tmp_reg(0);
				tmp_reg(0) <= tmp_reg(1);
				tmp_reg(1) <= tmp_reg(2);
				tmp_reg(2) <= tmp_reg(3);
				tmp_reg(3) <= tmp_reg(4);
				tmp_reg(4) <= tmp_reg(5);
				tmp_reg(5) <= tmp_reg(6);
				tmp_reg(6) <= tmp_reg(7);
			END IF;
		END IF;
		
	END PROCESS;
END behavior;