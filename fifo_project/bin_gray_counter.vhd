library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bin_gray_counter is
	generic(bit_width : integer := 4);
	port   ( clk, rst, en       : in  std_logic;
			   bin_out, gray_out, gray_next  : out std_logic_vector( bit_width - 1 downto 0));
end entity;


architecture bin_gray_counter_arc of bin_gray_counter is
	
	component bin_to_gray
		generic( bit_width : integer);
		port	 (	bin_in   : in  std_logic_vector (bit_width - 1 downto 0);
					gray_out : out std_logic_vector (bit_width - 1 downto 0));		
	end component;
	
	signal g_next, b_next, b_out : std_logic_vector(gray_out'range);
	
	begin
		
		bin_to_gray_1 : bin_to_gray
			generic map (bit_width => bit_width)
			port map (bin_in => b_next, gray_out => g_next);
		
		--b_next  <= b_out + 1 when en = '1' else
		--			  b_out     when en = '0';
		b_next  <= b_out + 1; 
		bin_out <= b_out;
		
	   gray_next <= g_next;

	
		process(clk,rst) is
			begin
				if(rst = '1') then
					b_out    <= (others => '0');
					gray_out <= (others => '0');
				elsif(rising_edge(clk)) then
					if(en = '1') then
						b_out    <= b_next;
						gray_out <= g_next;
					end if;
				end if;
		end process;
		
end architecture;