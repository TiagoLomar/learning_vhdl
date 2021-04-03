library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg_tb is
end entity;

architecture shift_reg_tb_arc of shift_reg_tb is
	
	constant REG_WIDTH       : integer :=  4;
	constant VECTOR_IN_WIDTH : integer := 10;
	
	component shift_reg 
		generic( REG_WIDTH : integer);
		port   ( serial_in, clk, rst : in std_logic;
			   parallel_out           :out std_logic_vector (REG_WIDTH - 1  downto 0));
	end component;
	
	signal serial_in : std_logic := '0'; 
	signal clk		  : std_logic := '0';	
	signal rst       : std_logic := '1';
	signal parallel_out : std_logic_vector (REG_WIDTH - 1 downto 0) := (others => '0');
	
	signal vector_in : std_logic_vector (VECTOR_IN_WIDTH - 1 downto 0) := "0110101001";
	signal counter	  : integer := 0;
	
	begin
		
		shift_reg_test : shift_reg
			generic map( REG_WIDTH => REG_WIDTH)
			port    map( serial_in => serial_in, clk => clk, rst=> rst, parallel_out => parallel_out);
	
				
		process
			begin
				wait for 10ns;
					rst <= '0';
		end process;
	
		clk_proc : process
			begin	
				clk <= not(clk);
				wait for 10ns;
		end process;

		stimulus_proc : process(clk,rst)
			begin
				if (rst = '1') then
					counter <= 0;
				elsif (rising_edge(clk)) then
					if counter < VECTOR_IN_WIDTH - 1 then
						serial_in <= vector_in (counter);
						counter <= counter + 1;
					else
						counter <= 0;
					end if;
				end if;
		end process;
		
	
end architecture;