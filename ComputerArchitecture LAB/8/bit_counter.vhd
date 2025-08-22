

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bit_counter IS
	PORT(	clk, baud, rst: IN STD_LOGIC;
			end_count8bits: OUT STD_LOGIC;
			state_tx: IN STD_LOGIC_VECTOR (1 downto 0));
END bit_counter;

ARCHITECTURE fsm OF bit_counter IS
	TYPE state IS (zero, one, two, three, four, five,
						six, seven,eight);
	SIGNAL pr_state, nx_state: state;
	SIGNAL tmp: STD_LOGIC;
BEGIN
seq:
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
			end_count8bits <= '0';
			pr_state <= one;
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF (baud = '1' and ((state_tx = "10") or (state_tx = "11"))) THEN
				end_count8bits <= tmp; 
				pr_state <= nx_state;
			END IF;
		END IF;
	END PROCESS seq;
comb:
	PROCESS(pr_state)
	BEGIN
		CASE pr_state IS
			WHEN zero =>
				tmp <= '0';
				nx_state <= one;
			WHEN one =>
				tmp <= '0';
				nx_state <= two;
			WHEN two =>
				nx_state <= three;
			WHEN three =>
				nx_state <= four;
			WHEN four =>
				nx_state <= five;
			WHEN five =>
				nx_state <= six;
			WHEN six =>
				nx_state <= seven;
			WHEN seven =>
				nx_state <= eight;
			WHEN eight =>
				nx_state <= zero;
				tmp <= '1';
		END CASE;	
	END PROCESS comb;
END fsm;