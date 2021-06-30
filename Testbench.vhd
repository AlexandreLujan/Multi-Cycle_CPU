library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Testbench is
	port ( clk : out STD_LOGIC );
end Testbench;


architecture RTL of Testbench is
   
	signal clock_gen, reset_gen: STD_LOGIC;
	signal QA, QB, QC, QD, QE, QF, QG, QH, data_int: STD_LOGIC_VECTOR(15 downto 0);
	signal OP_ALU: STD_LOGIC_VECTOR(3 downto 0);
	signal SEL_K, SEL_J, SEL_I: STD_LOGIC_VECTOR(2 downto 0);
	signal fun_int: STD_LOGIC_VECTOR(12 downto 0);

	
	component CPU
	port (
			DATA  : in STD_LOGIC_VECTOR (15 downto 0);
			FUNCT : in STD_LOGIC_VECTOR (12 downto 0);
			OUT_RA: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RB: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RC: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RD: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RE: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RF: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RG: out STD_LOGIC_VECTOR (15 downto 0);
			OUT_RH: out STD_LOGIC_VECTOR (15 downto 0);
			CLOCK : in STD_LOGIC;
			RESET : in STD_LOGIC
		 );
	end component;
		  
		 
	
begin	

	
	TEST_CPU: CPU
	port map (
				DATA    => data_int,
				FUNCT   => fun_int,
				OUT_RA  => QA,
				OUT_RB  => QB,	
				OUT_RC  => QC,
				OUT_RD  => QD,
				OUT_RE  => QE,
				OUT_RF  => QF,
				OUT_RG  => QG,
				OUT_RH  => QH,
				CLOCK   => clock_gen,
				RESET   => reset_gen );  
	
	process
	begin
		clock_gen <= '0';
		wait for 10 ns;
		clock_gen <= '1';
		wait for 10 ns;
	end process;

	process
	begin
		reset_gen <= '1';
		wait for 5 ns;
		reset_gen <= '0';
		wait for 1000000000 ns;
	end process;


	process
	begin
		-- MOVI A,0000000000001111
		OP_ALU   <= "0010";
		SEL_I    <= "000";
		SEL_J    <= "000";  -- don't care
		SEL_K    <= "000";  -- don't care
		data_int <= "0000000000001111";
		wait for 40 ns;

		-- MOVI B,0000000000000101
		OP_ALU   <= "0010";
		SEL_I    <= "001";
		SEL_J    <= "000";  -- don't care
		SEL_K    <= "000";  -- don't care
		data_int <= "0000000000000101";
		wait for 40 ns;

		-- AND C < B,A
		OP_ALU   <= "1000";
		SEL_I    <= "010";
		SEL_J    <= "001";
		SEL_K    <= "000";
		data_int <= "0000000000000000";
		wait for 40 ns;
		
		-- ANDI C < C,IMED(0000000000000111)
		OP_ALU   <= "1001";
		SEL_I    <= "010";
		SEL_J    <= "010";
		SEL_K    <= "000"; -- don't care
		data_int <= "0000000000000111";
		wait for 40 ns;

		-- OR D < B,A
		OP_ALU   <= "1010";
		SEL_I    <= "011";
		SEL_J    <= "001";
		SEL_K    <= "000";
		data_int <= "0000000000000000";
		wait for 40 ns;
		
		-- ORI D < D,IMED(0000000000011111)
		OP_ALU   <= "1011";
		SEL_I    <= "011";
		SEL_J    <= "011";
		SEL_K    <= "000"; -- don't care
		data_int <= "0000000000011111";
		wait for 40 ns;
		
		-- ADD E < D,A
		OP_ALU   <= "0100";
		SEL_I    <= "100";
		SEL_J    <= "011";
		SEL_K    <= "000";
		data_int <= "0000000000000000";
		wait for 40 ns;
		
		-- ADDI E < E,IMED(0000000000000001)
		OP_ALU   <= "0101";
		SEL_I    <= "100";
		SEL_J    <= "100";
		SEL_K    <= "000"; -- don't care
		data_int <= "0000000000000001";
		wait for 40 ns;
		
		-- SUB F < C,B
		OP_ALU   <= "0110";
		SEL_I    <= "101";
		SEL_J    <= "010";
		SEL_K    <= "001";
		data_int <= "0000000000000000";
		wait for 40 ns;
		
		-- SUBI F < E,IMED(0000000000000010)
		OP_ALU   <= "0111";
		SEL_I    <= "101";
		SEL_J    <= "100";
		SEL_K    <= "000"; -- don't care
		data_int <= "0000000000000010";
		wait for 40 ns;

		-- sll G <= F,IMED(0000000000000010)
		OP_ALU <= "1100";
		SEL_I  <= "110";
		SEL_J  <= "101";
		SEL_K  <= "000";  -- don't care
		data_int <= "0000000000000010";
		wait for 40 ns;
		
		-- srl H <= E,IMED(0000000000000011)
		OP_ALU <= "1101";
		SEL_I  <= "111";
		SEL_J  <= "100";
		SEL_K  <= "000";  -- don't care
		data_int <= "0000000000000011";
		wait for 40 ns;
		
		-- EXCG F,E
		OP_ALU   <= "0011";
		SEL_I    <= "101";
		SEL_J    <= "100";
		SEL_K    <= "000";  -- don't care
		data_int <= "0000000000000000";
		wait for 60 ns;
		
	end process;


	fun_int (12 downto 10)  <= SEL_I;
	fun_int (9 downto 7)    <= SEL_J;
	fun_int (6 downto 4)    <= SEL_K;
	fun_int (3 downto 0)    <= OP_ALU;


		 
end RTL;
