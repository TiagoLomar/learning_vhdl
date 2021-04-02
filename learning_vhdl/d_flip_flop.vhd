library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop is 
	port( d,clk,rst,en : in  std_logic;
			q				 : out std_logic);
end entity;

architecture d_flip_flop_arc of d_flip_flop is
	
	begin
	
		--Implementation with clk and rst in the sensitivity list 
--		d_flip_flop_proc : process(clk,rst)
--			begin
--				if(rst = '1') then
--					q <= '0';
--				elsif(clk'event and clk = '1') then
--					if (en = '1') then
--						q <= d;
--					end if;
--				end if;
--		end process;
	
		--Implementation with wait until (reset is synchronous)
--		d_flip_flop_proc : process
--			begin	
--				wait until (rising_edge(clk) and en = '1');
--					if (rst = '1') then
--						q <= '0';
--					else 
--						q <= d;	
--				   end if;
--		end process;
		
		--Implementation without process structure 
		q <= '0' when rst = '1' else 
				d  when en  = '1' and rising_edge(clk);
																
	



	
end architecture;