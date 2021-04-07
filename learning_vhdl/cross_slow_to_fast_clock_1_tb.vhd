library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cross_slow_to_fast_clock_1_tb is
end entity;

architecture cross_slow_to_fast_clock_1_tb_arc of cross_slow_to_fast_clock_1_tb is

	constant fast_clk_half_T : time := 10 ns;
	constant slow_clk_half_T : time := 56 ns;

	component cross_slow_to_fast_clock_1
		port( slow_clk, fast_clk, rst   : in  std_logic;
			   data_in 						  : in  std_logic_vector(3 downto 0);
			   data_out                  : out std_logic_vector(3 downto 0));
	end component;
	
	signal slow_clk, fast_clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal data_in, data_out : std_logic_vector (3 downto 0);
	
	signal counter : unsigned (3 downto 0) := "0000";
	
	begin
	
		cross_slow_to_fast_clock_1_test : cross_slow_to_fast_clock_1 
			port map (slow_clk => slow_clk, fast_clk => fast_clk, rst => rst, data_in => data_in, data_out => data_out);
	
		fast_clk_proc : process is
			begin
			fast_clk <= not(fast_clk);
			wait for fast_clk_half_T;
		end process;
		
		slow_clk_proc : process is
			begin
			slow_clk <= not(slow_clk);
			wait for slow_clk_half_T;
		end process;
		
		data_stimulus_slow_clk : process (slow_clk) is
			begin
				if(rising_edge(slow_clk)) then
					data_in <= std_logic_vector(counter);
					counter <= counter + 1;
				end if;
		end process;
			

end architecture;