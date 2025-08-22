
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control_rx IS
	PORT(
		rx, baud, half_baud, clk, rst: IN STD_LOGIC;
		shift, r_new_available, en_divfreq: OUT STD_LOGIC;
		state_rx: OUT STD_LOGIC_VECTOR (1 downto 0));
END control_rx;

ARCHITECTURE fsm OF control_rx IS
	TYPE state IS (r_init, r_bit_init, r_bits_data, r_bit_end);
	SIGNAL pr_state, nx_state: state;
	SIGNAL temp : STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL data_count: INTEGER RANGE 0 TO 7 := 0;
	--SIGNAL tmp_state: STD_LOGIC_VECTOR (1 downto 0);
BEGIN
------------------SEQUENTIAL SECTION-----------------------------------
sequential:
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state <= r_init;
			data_count <= 0;
		ELSIF (clk'EVENT and clk = '1') THEN
			en_divfreq <= temp(2);
			shift <= temp(1);
			r_new_available <= temp(0);
			IF (pr_state = r_bits_data and baud = '1') THEN
				data_count <= data_count +1;
			ELSIF (pr_state /= r_bits_data) THEN
 				data_count <= 0;
			END iF;
			pr_state <= nx_state;
		END IF;
	END PROCESS sequential;
------------------LOGICAL SECTION-------------------------------------
combinatorial:
	PROCESS(rx, baud, half_baud, pr_state, data_count)
	BEGIN
		CASE pr_state IS
			WHEN r_init =>
				temp <= "000";
				state_rx <= "00";
				IF (rx = '0') THEN
					nx_state <= r_bit_init;
				ELSE
					nx_state <= r_init;
				END IF;
			WHEN r_bit_init =>
				temp <= "100";
				state_rx <= "01";
				IF (baud = '1') THEN
					nx_state <= r_bits_data;
				ELSE
					nx_state <= r_bit_init;
				END IF;
			WHEN r_bits_data =>
				temp <= ('1', half_baud, '0');
				state_rx <= "10";
				IF (baud = '1') THEN
					IF (data_count = 7) THEN
						nx_state <= r_bit_end;
					ELSE
						nx_state <= r_bits_data;
					END IF;
				ELSE
					nx_state <= r_bits_data;
				END IF;
			WHEN r_bit_end =>
				temp <= "100";
				state_rx <= "11";
				IF (rx = '1') THEN
					IF (baud = '1') THEN
						nx_state <= r_init;
						temp <= "101";
					ELSE
						nx_state <= r_bit_end;
					END IF;
				ELSE
					nx_state <= r_init;
				END IF;
		END CASE;
	END PROCESS combinatorial;
END fsm;
						
				
