library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_gray_tb is
end entity;

architecture bin_to_gray_tb_arc of bin_to_gray_tb is
	
	constant bit_width : integer := 4;
	
	component bin_to_gray
		generic( bit_width : integer);
		port	 (	bin_in   : in  std_logic_vector (bit_width - 1 downto 0);
					gray_out : out std_logic_vector (bit_width - 1 downto 0));	
	end component;
	
	signal bin_in, gray_out : std_logic_vector (bit_width - 1 downto 0) := (others => '0');
	
	begin
	
		bin_to_gray_test : bin_to_gray
			generic map (bit_width => bit_width)
			port    map (bin_in => bin_in, gray_out => gray_out);
			
		stimulus : process is
			begin
			
				--test all possible input values
				for i in 0 to (2**bit_width) - 1 loop
					bin_in <= std_logic_vector(to_unsigned(i,bit_width));
					wait for 10 ns;
				end loop;
				
				--Finally, test the wrapped value
				bin_in <= (others => '0');
				wait for 10 ns;
				assert false report "Test Ok" severity failure;
		end process;
		
		check : process is
			variable prev  : std_logic_vector(gray_out'range);
			variable count : integer; 
			
			begin
				
				wait on bin_in;
				
				prev := gray_out;
				--wait for all delta cycles to propagate
				wait for 1 ns;
				
				-- count the number of changed bits
				count := 0;
				for i in gray_out'range loop
					if gray_out(i) /= prev(i) then
						count := count + 1;
					end if;
				end loop;
				
				assert count = 1 report integer'image(count) & "bits changed, should have been 1" severity failure;
					
		end process;
		
		
end architecture;