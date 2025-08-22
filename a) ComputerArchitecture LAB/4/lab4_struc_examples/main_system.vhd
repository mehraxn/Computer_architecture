use work.all;

entity main_system is
	port(in1, in2, in3, in4: IN BIT;
		  out3: OUT BIT);
end main_system;

architecture internal_connections of main_system is

	component and2local is
		port(I1, I2: IN BIT;
			  O:	OUT BIT);
	end component;
	
	component or2local is
		port(I1, I2: IN BIT;
			  O:	OUT BIT);
	end component;
	
	signal out1, out2: BIT;

begin
	
	G1: and2local
		 port map(I1 => in1,
					 I2 => in2,
					 O =>  out1);
	G2: and2local
		 port map(I1 => in3,
					 I2 => in4,
					 O =>  out2);
	G3: or2local
		 port map(I1 => out1,
					 I2 => out2,
					 O =>  out3);
end internal_connections;

	
	
