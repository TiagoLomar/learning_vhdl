library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_3_to_8_tb is 
end entity;

architecture decoder_3_to_8_tb of decoder_3_to_8_tb is
	
	--componet declaration
	component decoder_3_to_8												
		port ( a : in  std_logic_vector (2 downto 0);
				 f : out std_logic_vector (7 downto 0));
	end component;
	
	--signal declaration
	signal a_tb : std_logic_vector (2 downto 0);						
	signal f_tb : std_logic_vector (7 downto 0);
	
	begin
		--DUT instantiation
		DUT1 : decoder_3_to_8 port map ( a => a_tb, f => f_tb);
		
		--stimulus generation
		STIMULUS : process
			begin
				for i in 0 to 7 loop
					a_tb <= std_logic_vector(to_unsigned(i,3));
					wait for 30 ns;
					assert (f_tb=std_logic_vector(to_unsigned((2**i),8))) report "Failed test" severity ERROR;
				end loop;
		end process;
		


end architecture;
	