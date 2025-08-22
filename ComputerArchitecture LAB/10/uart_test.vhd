LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY uart_test IS
	PORT(clk, rst, rx: IN STD_LOGIC;
			tx, status: OUT STD_LOGIC);
END uart_test;

ARCHITECTURE behavior OF uart_test IS
	
	COMPONENT uart_tx
		PORT(
			t_data_in_ext: IN STD_LOGIC_VECTOR (7 downto 0);
			t_start_ext, clk_ext, rst_ext: IN STD_LOGIC;
			t_status_ext, tx_ext: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT uart_rx
		PORT(
			clk_ext, rst_ext, rx_ext: IN STD_LOGIC;
			r_new: OUT STD_LOGIC;
			r_data: OUT STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;
	
	SIGNAL trigger: STD_LOGIC;
	SIGNAL data_loop: STD_LOGIC_VECTOR (7 downto 0);
	
	BEGIN
		UARTTX: uart_tx
					port map(data_loop, trigger, clk, rst, status, tx);
		
		UARTRX: uart_rx
					port map(clk, rst, rx, trigger, data_loop);
					
	END behavior;
				