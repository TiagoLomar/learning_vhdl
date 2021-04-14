library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_gray is
	generic( bit_width : integer := 3);
	port	 (	bin_in   : in  std_logic_vector (bit_width - 1 downto 0);
				gray_out : out std_logic_vector (bit_width - 1 downto 0));	
end entity;

architecture bin_to_gray_arc of bin_to_gray is

	begin
	
		process(bin_in) is
			
			begin
				for i in bin_in'range loop
					if(i = bin_in'left) then
						gray_out(i) <= bin_in(i);
					else	
						gray_out(i) <= bin_in(i) xor bin_in(i+1);
					end if;
				end loop;
		end process;
		
end architecture;