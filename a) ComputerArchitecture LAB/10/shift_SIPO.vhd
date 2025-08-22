LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shift_SIPO IS
	PORT( t_data_in : IN STD_LOGIC;
		 clk, shift, rst : IN STD_LOGIC;
		 t_data_out : OUT STD_LOGIC_VECTOR (7 downto 0));
END shift_SIPO;

ARCHITECTURE behavior oF shift_SIPO IS
	SIGNAl tmp_reg: STD_LOGIC_VECTOR (7 downto 0);
BEGIN
	PROCESS (rst,clk,shift)
	BEGIN
		IF (rst = '1') THEN
			t_data_out <= (OTHERS=>'0');
		ELSIF (clk'EVENT and clk = '1') THEN
			IF (shift = '1') THEN
				tmp_reg(0) <= tmp_reg(1);
				tmp_reg(1) <= tmp_reg(2);
				tmp_reg(2) <= tmp_reg(3);
				tmp_reg(3) <= tmp_reg(4);
				tmp_reg(4) <= tmp_reg(5);
				tmp_reg(5) <= tmp_reg(6);
				tmp_reg(6) <= tmp_reg(7);
				tmp_reg(7) <= t_data_in;
			END IF;
		END IF;
		t_data_out <= tmp_reg;	
	END PROCESS;
END behavior;