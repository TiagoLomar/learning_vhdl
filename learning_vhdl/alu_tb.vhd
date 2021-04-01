library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture alu_tb_arc of alu_tb is
	
	constant DATA_WIDTH : integer := 4;
	
	component alu 
		generic(DATA_WIDTH	  : integer);
		port   ( opcode      : in  std_logic_vector (2 downto 0);
					src1, src2  : in  std_logic_vector (DATA_WIDTH - 1 downto 0);
					alu_result  : out std_logic_vector (DATA_WIDTH - 1 downto 0);
					carryout		: out std_logic
				 );
	end component;
	
	signal src1, src2,result,rt : std_logic_vector (DATA_WIDTH - 1 downto 0);
	signal opcode     		 : std_logic_vector (2 downto 0);	
	signal carryout   		 : std_logic;
	
	begin
		alu_test : alu 
			generic map ( DATA_WIDTH => DATA_WIDTH)
			port    map (opcode      => opcode,
							 src1        => src1,
							 src2        => src2,
							 alu_result  => result,
							 carryout    => carryout);
							 
		STIMULUS : process 
			begin
				src1   <= std_logic_vector(to_signed(2,DatA_WIDTH)); --0010
				src2   <= std_logic_vector(to_signed(3,DatA_WIDTH)); --0011
				
				
				--ADD test
				opcode <=  "010";
				wait for 10ns;
				assert (result = std_logic_vector(to_signed(5,DatA_WIDTH))) report "Failed add test" severity ERROR;
				
				
				--SUB test
				opcode <=  "110";
				wait for 10ns;
				assert (result= std_logic_vector(to_signed(-1,DatA_WIDTH))) report "Failed sub test" severity ERROR;
				
				
				--AND test
				opcode <=  "000";
				wait for 10ns;
				assert (result = "0010") report "Failed and test" severity ERROR;
				
				
				--OR test
				opcode <=  "001";
				wait for 10ns;
				assert (result = "0011") report "Failed or test" severity ERROR;
				
		end process;
	

end architecture;