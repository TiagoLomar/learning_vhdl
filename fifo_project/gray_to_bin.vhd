library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity gray_to_bin is
	generic( bit_width : integer := 3);
	port	 (	gray_in   : in  std_logic_vector (bit_width - 1 downto 0);
				bin_out   : out std_logic_vector (bit_width - 1 downto 0));	
end entity;

architecture gray_to_bin_arc of gray_to_bin is 
	
	begin
	
		process (gray_in) is
			variable aux_out : std_logic_vector(gray_in'range);
			begin
				for i in gray_in'range loop
					if(i = bit_width - 1) then
						aux_out(i) := gray_in(i);
					else
						aux_out(i) := aux_out(i+1) xor gray_in(i);
					end if;
				end loop;
				
				bin_out <= aux_out;
		end process;
	
end architecture;