library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg is
	generic( REG_WIDTH : integer := 4);
	port   ( serial_in, clk, rst    : in std_logic;
			   parallel_out           :out std_logic_vector (REG_WIDTH - 1  downto 0));
end entity;

architecture shift_reg_arc of shift_reg is
	
	begin
		
		shift_reg_proc : process (clk,rst)
			begin
--				if(rst = '1') then
--					parallel_out <= (others => '0');
--				elsif(rising_edge(clk))	then
--					parallel_out(3) <= serial_in;
--					parallel_out(2) <= parallel_out(3);
--					parallel_out(1) <= parallel_out(2);
--					parallel_out(0) <= parallel_out(1);
--				end if;
				
				
				--using for loop
				if (rst = '1') then
					parallel_out <= (others => '0');
				elsif(rising_edge(clk)) then
					parallel_out(REG_WIDTH-1) <= serial_in; 
					for i in 0 to REG_WIDTH-2 loop
						parallel_out(i) <= parallel_out(i+1);
					end loop;
				end if;
		end process;
		
	
end architecture;