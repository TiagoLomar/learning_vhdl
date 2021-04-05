library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_example_tb is
end entity;

architecture fsm_example_tb_arc of fsm_example_tb is
	
	component fsm_example
			port( din, clk, rst : in  std_logic;
			      err         : out std_logic);
	end component;
	
	signal din : std_logic := '0';
	signal err : std_logic;
	signal clk : std_logic := '1';
	signal rst : std_logic := '1';
	
	signal in_test : std_logic_vector (11 downto 0) := "111101010111";
	
	signal buffer_test : std_logic_vector (2 downto 0) := "000"; 
	signal counter : integer := 0;

	begin
	
		fsm_example_test : fsm_example
			port map (din => din, clk => clk, rst => rst, err => err);
		
		process
			begin
				wait for 20 ns;
				rst <= '0';
		end process;
	
		clk_proc : process
			begin
				clk <= not(clk);
				wait for 10 ns;
		end process;
	
		stimulus_proc : process(clk)
			begin
				if(rising_edge(clk)) then
					if counter < in_test'length - 1 then
						din <= in_test(counter);
						
						buffer_test(2) <= in_test(counter);
						buffer_test(1) <= buffer_test(2);
						buffer_test(0) <= buffer_test(1);
						
						counter <= counter + 1;
					end if;
				end if;
		end process;
		
		check_err : process (err)
			begin	
				if(rising_edge(err)) then
					assert buffer_test = "111" report ("Sequence test error") severity ERROR;
				end if;
		end process;
		
	
end architecture;