library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_to_bin_tb is
end entity;

architecture gray_to_bin_tb_arc of gray_to_bin_tb is

	constant bit_width : integer := 3;
	
	component gray_to_bin
		generic( bit_width : integer);
		port	 (	gray_in   : in  std_logic_vector (bit_width - 1 downto 0);
				   bin_out   : out std_logic_vector (bit_width - 1 downto 0));	
	end component;
	
	signal gray_in, bin_out : std_logic_vector (bit_width - 1 downto 0) := (others => '0');
	
	type mem_type is array (0 to (2**bit_width)-1) of std_logic_vector (bit_width - 1 downto 0);
	
	signal gray_num : mem_type := (0 => "000",
											 1 => "001",
											 2 => "011",
											 3 => "010",
											 4 => "110",
											 5 => "111",
											 6 => "101",
											 7 => "100");	
											 
	signal bin_num : std_logic_vector (bit_width - 1 downto 0); 							 

	begin
		
		gray_to_bin_test : gray_to_bin
			generic map (bit_width => bit_width)
			port    map (gray_in => gray_in, bin_out => bin_out);
			
		stimulus : process is
			begin
				--test all possible input values
				for i in 0 to (2**bit_width) - 1 loop
					gray_in <= gray_num(i);
					bin_num <= std_logic_vector(to_unsigned(i,bit_width));
					wait for 10 ns;
				end loop;
				
				--Finally, test the wrapped value
				wait for 10 ns;
				assert false report "Test Ok" severity failure;
		end process;
	
		check : process is
			
			begin
				wait on gray_in;
				wait for 1ns;
				assert bin_num = bin_out report "Failed process" severity failure;
		end process;

end architecture; 