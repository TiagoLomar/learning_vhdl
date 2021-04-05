library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity ram_mem is
	generic( DATA_WIDTH : integer := 4;
				ADDR_WIDTH : integer := 2);
	port   ( clk, w      : in   std_logic;
			   addr        : in   std_logic_vector (ADDR_WIDTH - 1 downto 0);
				data_in     : in  std_logic_vector  (DATA_WIDTH - 1 downto 0);
			   data_out    : out  std_logic_vector (DATA_WIDTH - 1 downto 0));
end entity;

architecture ram_mem_arc of ram_mem is

	type ram_type is array (0 to (2**ADDR_WIDTH) - 1 ) of std_logic_vector (DATA_WIDTH - 1 downto 0); 
	
	--First form of initialization
--	signal ram : ram_type := (0 => "0100",
--								  	  1 => "0001",
--									  2 => "0110",
--									  3 => "0011"); 
------------------------------------------------------------------									  
	--initialization from file.txt 
	impure function init_ram return ram_type is
		file text_file : text open read_mode is "C:/Users/tiago/Documents/Mestrado/FPGA/vhdl_projects/learning_vhdl/mem_init.txt";
		variable text_line : line;
		variable ram_content : ram_type;
		variable bv : bit_vector(ram_content(0)'range);
	
		begin
			for i in 0 to (2**ADDR_WIDTH) - 1 loop
				readline(text_file,text_line);
				read(text_line,bv);
				ram_content(i) := to_stdlogicvector(bv);
			end loop;
			
			return ram_content;
	end function;
	
	signal ram : ram_type := init_ram;

------------------------------------------------------------------

	--initialization from file.mif (Quartus)
--	signal ram : ram_type;
--	attribute ram_init_file : string;
--	
--	attribute ram_init_file of ram : signal is "mem_init.mif";
------------------------------------------------------------------	
	
	
	begin
	
		memory : process(clk)
			begin
				if(rising_edge(clk)) then
					if (w='0') then
						data_out <= ram(to_integer(unsigned(addr)));
					else
						ram(to_integer(unsigned(addr))) <= data_in;
					end if;
				end if;
		end process;
		
		

end architecture;