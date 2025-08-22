
LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY control IS
	PORT(	t_start, baud, end_count8bits, clk, rst: IN STD_LOGIC;
			state_tx: OUT STD_LOGIC_vector (1 downto 0);
			load, shift, t_status, en_div: OUT STD_LOGIC);
END control;
--------------------------------------
ARCHITECTURE fsm OF control IS
	TYPE state IS (t_init, t_bit_init, t_bits_data, t_bit_end);
	SIGNAL pr_state, nx_state: state;
	SIGNAL temp : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL tmp_state: STD_LOGIC_VECTOR (1 downto 0);
BEGIN
------------SEQUENTIAL SECTION-------------------
sequential:
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state <= t_init;
		ELSIF (clk'EVENT AND clk = '1') THEN
			load <= temp(3);
			shift <= temp(2);
			en_div <= temp(1);
			t_status <= temp(0);
			state_tx <= tmp_state;
			pr_state <= nx_state;
			
		END IF;
	END PROCESS sequential;
-------------LOGICAL SECTION----------------------
combinatorial:
	PROCESS (t_start, baud, end_count8bits, pr_state)
	BEGIN
		CASE pr_state IS
			WHEN t_init =>
				temp <= "0000";
				state_tx <= "00";
				IF (t_start='1') THEN
					nx_state <= t_bit_init;
					temp <= "1000";
				ELSE 
					nx_state <= t_init;
				END IF;
			WHEN t_bit_init =>
				temp <= "0011";
				state_tx <= "01";
				IF (baud='1') THEN
					nx_state <= t_bits_data;
					temp <= "0111";
				ELSE
					nx_state <= t_bit_init;
				END IF;
			WHEN t_bits_data =>
				temp <= ('0' , baud, OTHERS =>'1');
				state_tx <= "10";
				IF (end_count8bits = '1') THEN
					temp <= "0011";
					nx_state <= t_bit_end;
				ELSE 
					nx_state <= t_bits_data;
				END IF;
			WHEN t_bit_end =>
				temp <= "0011";
				state_tx <= "11";
				IF (baud='1') THEN
					nx_state <= t_init;
				ELSE
					nx_state <= t_bit_end;
				END IF;
		END CASE;
	END PROCESS combinatorial;
END fsm;