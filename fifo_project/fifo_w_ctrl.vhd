library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_w_ctrl is
	generic(bit_width : integer := 3);
	port   (clk, rst, en            : in  std_logic;
			  r_addr_gray             : in  std_logic_vector(bit_width - 1 downto 0);
			  full                    : out std_logic;
			  w_addr_bin, w_addr_gray : out std_logic_vector(bit_width - 1 downto 0));
end entity;

architecture fifo_w_ctrl_arc of fifo_w_ctrl is
	
	component bin_gray_counter
		generic(bit_width : integer);
		port   (clk, rst, en       : in  std_logic;
				  bin_out, gray_out, gray_next  : out std_logic_vector( bit_width - 1 downto 0));
	end component;
	
	signal en_counter, full_aux : std_logic;
	signal gray_next : std_logic_vector(bit_width - 1 downto 0);
	
	begin
		
		bin_gray_counter_1 : bin_gray_counter
			generic map (bit_width => bit_width)
			port    map (clk => clk, rst => rst, en => en_counter, bin_out => w_addr_bin, gray_out => w_addr_gray, gray_next => gray_next);
		
		full       <= full_aux;
		en_counter <= not(full_aux) and en;
		
		process (clk,rst)
			begin
				if(rst ='1') then
					full_aux <= '0';
				elsif(rising_edge(clk)) then
					if(gray_next(gray_next'left)           /= r_addr_gray(r_addr_gray'left)       and
						gray_next(gray_next'left - 1)       /= r_addr_gray(r_addr_gray'left - 1)   and
						gray_next(gray_next'left-2 downto 0) = r_addr_gray(r_addr_gray'left-2 downto 0)) then
						
						full_aux <= '1';
					else
					
						full_aux <= '0';
						
					end if;
				end if;
			
		end process;
	
end architecture;