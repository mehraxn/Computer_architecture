
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY uart_tx IS
	PORT(
			t_data_in_ext: IN STD_LOGIC_VECTOR (7 downto 0);
			t_start_ext, clk_ext, rst_ext: IN STD_LOGIC;
			t_status_ext, tx_ext: OUT STD_LOGIC;
			state_tx_ext: OUT STD_LOGIC_VECTOR (1 downto 0));
END uart_tx;

ARCHITECTURE behavior OF uart_tx IS
	COMPONENT control
		PORT(	t_start, baud, end_count8bits, clk, rst: IN STD_LOGIC;
			state_tx: OUT STD_LOGIC_vector (1 downto 0);
			load, shift, t_status, en_div: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT div_freq
		GENERIC (N: INTEGER := 10);
		PORT(	clk, rst, en_div: IN STD_LOGIC;
				baud: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT load_shift
		PORT( t_data_in : IN STD_LOGIC_VECTOR (7 downto 0);
				clk, load, shift, rst : IN STD_LOGIC;
				t_data_out : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT bit_counter
		PORT(	clk, baud, rst: IN STD_LOGIC;
				end_count8bits: OUT STD_LOGIC;
				state_tx: IN STD_LOGIC_VECTOR (1 downto 0));
	END COMPONENT;
	
	COMPONENT out_selection
		PORT(
				clk, rst , in_data: IN STD_LOGIC;
				state_tx: IN STD_LOGIC_VECTOR (1 downto 0);
				tx: OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL baud_s, en_div_s, load_s, shift_s, end_count_s, tx_s : STD_LOGIC;
	SIGNAL state_s: STD_LOGIC_VECTOR (1 downto 0);
	
	BEGIN
		
		COM1: control
					port map(t_start_ext, baud_s, end_count_s, clk_ext,
								rst_ext, state_s, load_s, shift_s, t_status_ext,
								en_div_s);
		COM2: div_freq
					generic map (N => 10)
					port map (clk_ext, rst_ext, en_div_s, baud_s);
		
		COM3: load_shift
					port map(t_data_in_ext, clk_ext, load_s, shift_s, rst_ext, tx_s);
		
		COM4: bit_counter
					port map(clk_ext, baud_s, rst_ext, end_count_s, state_s);
		
		COM5: out_selection
					port map(clk_ext, rst_ext, tx_s, state_s, tx_ext);
		
		
END behavior;
					
								
