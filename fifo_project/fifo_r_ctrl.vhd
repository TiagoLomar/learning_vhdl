library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_r_ctrl is
	generic(bit_width : integer := 3);
	port   (clk, rst, en            : in  std_logic;
			  w_addr_gray             : in  std_logic_vector(bit_width - 1 downto 0);
			  empty                   : out std_logic;
			  r_addr_bin, r_addr_gray : out std_logic_vector(bit_width - 1 downto 0));
end entity;

architecture fifo_r_ctrl_arc of fifo_r_ctrl is
	
	component bin_gray_counter
		generic(bit_width : integer);
		port   (clk, rst, en       : in  std_logic;
				  bin_out, gray_out, gray_next  : out std_logic_vector( bit_width - 1 downto 0));
	end component;
	
	signal en_counter, empty_aux : std_logic;
	signal gray_next : std_logic_vector(bit_width - 1 downto 0);
	
	begin
		
		bin_gray_counter_1 : bin_gray_counter
			generic map (bit_width => bit_width)
			port    map (clk => clk, rst => rst, en => en_counter, bin_out => r_addr_bin, gray_out => r_addr_gray, gray_next => gray_next);
		
		empty       <= empty_aux;
		en_counter  <= not(empty_aux) and en;
		
		process (clk,rst)
			begin
				if(rst ='1') then
					empty_aux <= '0';
				elsif(rising_edge(clk)) then
					if(gray_next = w_addr_gray) then
						
						empty_aux <= '1';
					else
					
						empty_aux <= '0';
						
					end if;
				end if;
			
		end process;
	
end architecture;