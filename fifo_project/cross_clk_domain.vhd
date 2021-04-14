library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cross_clk_domain is
	generic( data_width : integer := 3);
	port	 ( clk, rst : in std_logic;
				data_in  : in std_logic_vector (data_width -1 downto 0);
				data_out : out std_logic_vector (data_width -1 downto 0));
end entity;

architecture cross_clk_domain_arc of cross_clk_domain is 
	
	signal r1,r2 : std_logic_vector (data_in'range);
	
	begin
		
		process(clk,rst) is
			begin
				if(rst = '1') then
					r1 <= (others => '0');
					data_out <= (others => '0');
				elsif(rising_edge(clk)) then
					r1 <= data_in;
					data_out <= r1;
				end if;
		end process;
	
end architecture;