library IEEE;
use IEEE.std_logic_1164.all;


entity decoder_3_to_8 is
	port(	a	 :	in  std_logic_vector(2 downto 0);
			f 	 : out std_logic_vector(7 downto 0));
end entity;

architecture decoder_3_to_8 of decoder_3_to_8 is
	
	begin
	
		decoder_3_to_8_proc : process(a)
			begin
		--IF/ELSE implamentation
				if		(a = "000") then f <= "00000001";
				elsif	(a = "001") then f <= "00000010";
				elsif	(a = "010") then f <= "00000100";
				elsif	(a = "011") then f <= "00001000";
				elsif	(a = "100") then f <= "00010000";
				elsif	(a = "101") then f <= "00100000";
				elsif	(a = "110") then f <= "01000000";
				elsif	(a = "111") then f <= "10000000";
				else 						  f <= (others => '-');
				end if;

		--Case implamentation
--				case (a) is
--					when  "000" => f <= "00000001";
--					when  "001" => f <= "00000010";
--					when  "010" => f <= "00000100";
--					when  "011" => f <= "00001000";
--					when  "100" => f <= "00010000";
--					when  "101" => f <= "00100000";
--					when  "110" => f <= "01000000";
--					when  "111" => f <= "10000000";
--					when others => f <= (others => '-');
--				end case;
		end process;
		
		--When/else implamentation
--		f <= "00000001" when a = "000" else
--			  "00000010" when a = "001" else
--			  "00000100" when a = "010" else
--			  "00001000" when a = "011" else
--			  "00010000" when a = "100" else
--			  "00100000" when a = "101" else
--			  "01000000" when a = "110" else
--			  "10000000" when a = "111" else
--			  (others => '-');
				  
		--with/select implamentation
--		with a select f <= "00000001" when "000",
--								 "00000010" when "001",
--								 "00000100" when "010",
--								 "00001000" when "011",
--								 "00010000" when "100",
--								 "00100000" when "101",
--								 "01000000" when "110",
--								 "10000000" when "111";


end architecture;