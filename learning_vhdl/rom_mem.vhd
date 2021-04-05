library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity rom_mem is
	generic( DATA_WIDTH : integer := 4;
				ADDR_WIDTH : integer := 2);
	port   ( clk      : in   std_logic;
			   addr     : in   std_logic_vector (ADDR_WIDTH - 1 downto 0);
			   data_out : out  std_logic_vector (DATA_WIDTH - 1 downto 0));
end entity;

architecture rom_mem_arc of rom_mem is

	type rom_type is array (0 to (2**ADDR_WIDTH) - 1 ) of std_logic_vector (DATA_WIDTH - 1 downto 0); 
	
	--First form of initialization
--	signal rom : rom_type := (0 => "0100",
--								  	  1 => "0001",
--									  2 => "0110",
--									  3 => "0011"); 
------------------------------------------------------------------									  
	--initialization from file.txt 
	impure function init_rom return rom_type is
		file text_file : text open read_mode is "C:/Users/tiago/Documents/Mestrado/FPGA/vhdl_projects/learning_vhdl/mem_init.txt";
		variable text_line : line;
		variable rom_content : rom_type;
		variable bv : bit_vector(rom_content(0)'range);
	
		begin
			for i in 0 to (2**ADDR_WIDTH) - 1 loop
				readline(text_file,text_line);
				read(text_line,bv);
				rom_content(i) := to_stdlogicvector(bv);
			end loop;
			
			return rom_content;
	end function;
	
	signal rom : rom_type := init_rom;

------------------------------------------------------------------

	--initialization from file.mif (Quartus)
--	signal rom : rom_type;
--	attribute ram_init_file : string;
--	
--	attribute ram_init_file of rom : signal is "mem_init.mif";
------------------------------------------------------------------	
	
	
	begin
	
		memory : process(clk)
			begin
				if(rising_edge(clk)) then
					data_out <= rom(to_integer(unsigned(addr)));
					end if;
		end process;

end architecture;