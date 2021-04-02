library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop_tb is
end entity;

architecture d_flip_flop_tb_arc of d_flip_flop_tb is
	
	component d_flip_flop 
		port( d,clk,rst,en : in  std_logic;
				q				 : out std_logic);
	end component;
	
	signal q   : std_logic;
	signal d   : std_logic := '1';
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal en  : std_logic := '1';
	
	signal result : std_logic := '1';
	
	begin
		
		d_flip_flop_test : d_flip_flop
			port map (d => d, clk => clk, rst => rst, en => en, q => q);
		
		clk_proc : process 
		begin
				clk <=  not(clk);
				wait for 10 ns;
		end process;
		
		stimulus : process
		begin
		
				wait for 20ns;
				assert q = result report "Failed test 000" severity ERROR;
				d   <= '0';
				rst <= '0';
				en  <= '1';
				result <= '0';
				wait for 20ns;
				assert q = result report "Failed test 001" severity ERROR;
				d   <= '1';
				rst <= '0';
				en  <= '0';
				result <= '0';
				wait for 20ns;
				assert q = result report "Failed test 002" severity ERROR;
				d   <= '1';
				rst <= '0';
				en  <= '1';
				result <= '1';
				wait for 20ns;
				assert q = result report "Failed test 003" severity ERROR;
				wait for 10ns;
				d   <= '1';
				rst <= '1';
				en  <= '1';
				result <= '0';
				wait for 10ns;
				assert q = result report "Failed test 004" severity ERROR;
				

		end process;
		
		

end architecture;