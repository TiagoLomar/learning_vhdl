library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_mem_tb is
end entity;

architecture rom_mem_tb_arc of rom_mem_tb is
	
	constant DATA_WIDTH : integer := 4;
	constant ADDR_WIDTH : integer := 2;
	
	component rom_mem 
		generic( DATA_WIDTH : integer;
				   ADDR_WIDTH : integer);
		port   ( clk      : in   std_logic;
			      addr     : in   std_logic_vector (ADDR_WIDTH - 1 downto 0);
			      data_out : out  std_logic_vector (DATA_WIDTH - 1 downto 0));
	end component;
	
	signal clk      : std_logic := '0';
	signal addr     : std_logic_vector (ADDR_WIDTH - 1 downto 0);
	signal data_out : std_logic_vector (DATA_WIDTH - 1 downto 0);

	begin
	
		rom_mem_test : rom_mem
			generic map ( DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
			port    map (clk => clk, addr => addr, data_out => data_out);
			
		clk_proc : process
			begin
				clk <= not(clk);
				wait for 10ns;
		end process;
		
		stimulus : process
			begin	
				for i in 0 to (2**ADDR_WIDTH)-1 loop
					addr <= std_logic_vector(to_unsigned(i,ADDR_WIDTH));
					wait for 30 ns;
				end loop;
		end process;
				
end architecture;