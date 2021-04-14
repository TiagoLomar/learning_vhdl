library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_counter is
	generic(bit_width : integer := 4);
	port ( clk, rst, en : in std_logic;
			 counter_out  : out std_logic_vector( bit_width - 1 downto 0));
end entity;


architecture bin_counter_arc of bin_counter is
	
	signal counter_aux : unsigned (counter_out'range);
	begin
		
		counter_out <= std_logic_vector(counter_aux);
	
		process(clk,rst) is
			begin
				if(rst = '1') then
					counter_aux <= (others => '0');
				elsif(rising_edge(clk)) then
					if(en = '1') then
						counter_aux <= counter_aux + 1;
					end if;
				end if;
		end process;
		
end architecture;