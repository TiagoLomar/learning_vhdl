library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Serial bit sequence detector
--This circuit will monitor a sequence of bits "111" using fsm

entity fsm_example is
	port( din, clk, rst : in  std_logic;
			err           : out std_logic);
end entity;

architecture fsm_example_arc of fsm_example is
	
	type state_type is (start, d0_1, d1_1, d0_0, d1_0);
	signal current_state, next_state : state_type;

	begin
	
		state_memory : process(clk, rst)
			begin
				if(rst='1') then
					current_state <= start;
				elsif(rising_edge(clk)) then
					current_state <= next_state;
				end if;
		end process;
		
		next_state_logic : process (current_state, din)
			begin
				case current_state is
					when start => if(din='1') then
											next_state <= d0_1;
										else
											next_state <= d0_0;
										end if;
					when d0_1  => if(din='1') then
											next_state <= d1_1;
										else
											next_state <= d1_0;
										end if; 
					when d1_1  => next_state <= start;
					when d0_0  => next_state <=  d1_0;
					when d1_0  => next_state <= start;
					when others=> next_state <= start;
				end case;
		end process;
		
		output_logic : process (current_state, din)
			begin
				case current_state is
					when d1_1  => if(din = '1') then 
										 err <= '1';
									  else
										 err <= '0';
									  end if;	
					when others =>  err <= '0';
				end case;
		end process;
		
end architecture;