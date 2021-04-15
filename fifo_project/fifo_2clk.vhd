library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--
entity fifo_2clk is
	generic(data_width : integer := 4;
			  fifo_width : integer := 10);
	port	 (clk_w, clk_r, rst, en_w, en_r : in  std_logic;
			  data_w 							  : in std_logic_vector(data_width - 1 downto 0);
		     full, empty                   : out std_logic; 
		     data_r                        : out std_logic_vector(data_width - 1 downto 0));
end entity;


architecture fifo_2clk_arc of fifo_2clk is
	
	component fifo_w_ctrl
		generic(bit_width : integer);
		port   (clk, rst, en            : in  std_logic;
				  r_addr_gray             : in  std_logic_vector(bit_width - 1 downto 0);
			     full                    : out std_logic;
			     w_addr_bin, w_addr_gray : out std_logic_vector(bit_width - 1 downto 0));
	end component;
	
	component fifo_r_ctrl
		generic(bit_width : integer);
		port   (clk, rst, en            : in  std_logic;
			     w_addr_gray             : in  std_logic_vector(bit_width - 1 downto 0);
			     empty                   : out std_logic;
			     r_addr_bin, r_addr_gray : out std_logic_vector(bit_width - 1 downto 0));
	end component;

	
	component cross_clk_domain
		generic(data_width : integer);
		port	 (clk, rst : in  std_logic;
				  data_in  : in  std_logic_vector (data_width -1 downto 0);
				  data_out : out std_logic_vector (data_width -1 downto 0));
	end component;
	
	
	type ram_type is array (0 to (2**fifo_width) - 1) of std_logic_vector (data_w'range);
	
	signal ram_mem : ram_type;
	
	signal w_addr_bin, r_addr_bin, w_addr_gray, r_addr_gray, 
	       r2w_addr_gray, w2r_addr_gray  : std_logic_vector (fifo_width - 1 downto 0);
	signal full_aux, empty_aux : std_logic;
	
	begin
	
		--write domain
		fifo_w_ctrll : fifo_w_ctrl
			generic map(bit_width => fifo_width)
			port    map(clk => clk_w, rst => rst, en => en_w, r_addr_gray => r2w_addr_gray, 
			            full => full_aux, w_addr_bin => w_addr_bin, w_addr_gray => w_addr_gray);
							
		cross_clk_domain_r2w : cross_clk_domain
			generic map(data_width => fifo_width)
			port    map(clk => clk_w, rst => rst, data_in => r_addr_gray, data_out => r2w_addr_gray);
		
		--read domain
		fifo_r_ctrll : fifo_r_ctrl
			generic map(bit_width => fifo_width)
			port    map(clk => clk_r, rst => rst, en => en_r, w_addr_gray => w2r_addr_gray, 
			            empty => empty_aux, r_addr_bin => r_addr_bin, r_addr_gray => r_addr_gray);
							
		cross_clk_domain_w2r : cross_clk_domain
			generic map(data_width => fifo_width)
			port    map(clk => clk_r, rst => rst, data_in => w_addr_gray, data_out => w2r_addr_gray);
		
	
		
		full  <=  full_aux;
		empty <= empty_aux;
		
		data_r <= ram_mem(to_integer(unsigned(r_addr_bin)));

		--memory
		process(clk_w) is 
			begin
				if(rising_edge(clk_w)) then
					if(en_w = '1' and full_aux = '0') then
						ram_mem(to_integer(unsigned(w_addr_bin))) <= data_w;
					end if;
				end if;
		end process;

		
		
		
	
end architecture;