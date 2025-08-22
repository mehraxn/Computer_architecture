LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY uart_rx IS
	PORT(
			clk_ext, rst_ext, rx_ext: IN STD_LOGIC;
			r_new, shift_ext, baud_ext, half_baud_ext, en_div_ext: OUT STD_LOGIC;
			r_data: OUT STD_LOGIC_VECTOR (7 downto 0);
			state_rx_ext: OUT STD_LOGIC_VECTOR (1 downto 0));
END uart_rx;

ARCHITECTURE behavior OF uart_rx IS
	
	COMPONENT div_freq_rx
		GENERIC (N: INTEGER := 10);
		PORT(	clk, rst, en_div: IN STD_LOGIC;
				baud, half_baud: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT shift_SIPO
		PORT( t_data_in : IN STD_LOGIC;
		 clk, shift, rst : IN STD_LOGIC;
		 t_data_out : OUT STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;
	
	COMPONENT control_rx
		PORT(
			rx, baud, half_baud, clk, rst: IN STD_LOGIC;
			shift, r_new_available, en_divfreq: OUT STD_LOGIC;
			state_rx: OUT STD_LOGIC_VECTOR (1 downto 0));
	END COMPONENT;
	
	SIGNAL baud_s, half_baud_s, en_div_s, shift_s: STD_LOGIC;
	
	BEGIN
		COM1: div_freq_rx
					generic map (N => 10)
					port map(clk_ext, rst_ext, en_div_s,
								baud_s, half_baud_s);
		
		COM2: shift_SIPO
					port map(rx_ext, clk_ext, shift_s, rst_ext,
								r_data);
		
		COM3: control_rx
					port map(rx_ext, baud_s, half_baud_s, clk_ext,
								rst_ext, shift_s, r_new, en_div_s,
								state_rx_ext);
		
		shift_ext <= shift_s;
		baud_ext <= baud_s;
		half_baud_ext <= half_baud_s;
		en_div_ext <= en_div_s;
END behavior;