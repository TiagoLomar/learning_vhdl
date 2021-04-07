library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
entity cross_slow_to_fast_clock_1 is
	port( slow_clk, fast_clk, rst : in  std_logic;
			data_in 						  : in  std_logic_vector(3 downto 0);
			data_out                  : out std_logic_vector(3 downto 0));
end entity;

architecture cross_slow_to_fast_clock_1_arc of cross_slow_to_fast_clock_1 is
	
	signal r1, r2, r3, enable : std_logic;
		
	begin
		--edge detector of slow clock
		enable <= r2 and not(r3);
		
		--Crossing from slower clock domain to faster clock domain
		cross_clk : process (fast_clk,rst) is
			
			begin
				if(rst = '1') then
					r1 <= '0';
					r2 <= '0';
					r3 <= '0';
				elsif(rising_edge(fast_clk)) then
					r1 <= slow_clk;
					r2 <= r1;
					r3 <= r2;
				end if;
		end process;
		
		--Shift the data in the slow clk domain using the fast clk domain and enable signal
		Data_transf: process (fast_clk,enable,rst) is
			begin
				if(rst = '1') then
					data_out <= (others => '0');
				elsif(rising_edge(fast_clk) and enable = '1') then
					data_out <= data_in;
				end if;
		end process;
			

end architecture;