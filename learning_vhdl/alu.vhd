library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	generic( DATA_WIDTH	: integer := 4);	
	port   ( opcode      : in  std_logic_vector (2 downto 0);
			   src1, src2  : in  std_logic_vector (DATA_WIDTH - 1 downto 0);
			   alu_result  : out std_logic_vector (DATA_WIDTH - 1 downto 0);
				carryout		: out std_logic
			 );
end entity;

architecture alu_arc of alu is

	constant ADD 			  : std_logic_vector := "010";
	constant SUB 			  : std_logic_vector := "110";
	constant AAND 			  : std_logic_vector := "000";
	constant OOR 			  : std_logic_vector := "001";
	constant SET_LESS_THAN : std_logic_vector := "111";
	
	signal result : signed(DATA_WIDTH downto 0);
	
	begin		
		alu_result <= std_logic_vector(result(DATA_WIDTH - 1 downto 0));
		carryout	  <= result(DATA_WIDTH);
	
		alu_arc_proc : process(all) --VHDL 2008
		--alu_arc_proc : process(opcode,src1,src2) 
			begin
				case (opcode) is
					when ADD            => result <= signed('0' & src1) +   signed('0' & src2);
					when SUB            => result <= signed('0' & src1) -   signed('0' & src2);
					when AAND           => result <= signed('0' & src1) and signed('0' & src2);
					when OOR  			  => result <= signed('0' & src1) or  signed('0' & src2);
					when SET_LESS_THAN  => 
						if (signed(src1) < signed(src2)) 
							then result <= ( 0 => '1' , others => '0');
							else result <= ( 0 => '0' , others => '0');
						end if;
					when others         => result <= (others => '-');
				end case;
		
		end process;
		
		

end architecture;