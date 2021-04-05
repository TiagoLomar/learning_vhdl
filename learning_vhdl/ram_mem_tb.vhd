library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_mem_tb is
end entity;

architecture ram_mem_tb_arc of ram_mem_tb is
	
	constant DATA_WIDTH : integer := 4;
	constant ADDR_WIDTH : integer := 2;
	
	component ram_mem 
		generic( DATA_WIDTH : integer;
				   ADDR_WIDTH : integer);
		port   ( clk,w    : in   std_logic;
			      addr     : in   std_logic_vector (ADDR_WIDTH - 1 downto 0);
					data_in  : in   std_logic_vector (DATA_WIDTH - 1 downto 0);
			      data_out : out  std_logic_vector (DATA_WIDTH - 1 downto 0));
	end component;
	
	signal clk,w             : std_logic := '0';
	signal addr              : std_logic_vector (ADDR_WIDTH - 1 downto 0);
	signal data_out, data_in : std_logic_vector (DATA_WIDTH - 1 downto 0);
	
	signal count				 : integer := 0;

	begin
	
		ram_mem_test : ram_mem
			generic map ( DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
			port    map (clk => clk, addr => addr, data_out => data_out, data_in => data_in, w=>w);
			
		clk_proc : process
			begin
				clk <= not(clk);
				wait for 10ns;
		end process;
		
		stimulus : process(clk)
			begin	
				if(rising_edge(clk)) then
					
					if count = 0 then
						w <= '0';
						addr <= std_logic_vector(to_unsigned(0,ADDR_WIDTH));
						count <= count + 1;
					elsif count = 1 then
						w <= '0';
						addr <= std_logic_vector(to_unsigned(1,ADDR_WIDTH));
						count <= count + 1;
					elsif count = 2 then
						w <= '1';
						addr <= std_logic_vector(to_unsigned(0,ADDR_WIDTH));
						data_in <= std_logic_vector(to_unsigned(3,DATA_WIDTH));
						count <= count + 1;
					elsif count = 3 then
						w <= '1';
						addr <= std_logic_vector(to_unsigned(1,ADDR_WIDTH));
						data_in <= std_logic_vector(to_unsigned(5,DATA_WIDTH));
						count <= count + 1;
					elsif count = 4 then
						w <= '0';
						addr <= std_logic_vector(to_unsigned(0,ADDR_WIDTH));
						count <= count + 1;
					elsif count = 5 then
						w <= '0';
						addr <= std_logic_vector(to_unsigned(1,ADDR_WIDTH));
						count <= count + 1;
					end if;			
					
				end if;

		end process;
				
end architecture;