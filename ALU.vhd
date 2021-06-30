library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port (
			OP   :  	in  STD_LOGIC_VECTOR (3  downto 0);
			IMED :  	in  STD_LOGIC_VECTOR (15 downto 0);
			IN_RK: 		in  STD_LOGIC_VECTOR (15 downto 0);
			IN_RJ: 		in  STD_LOGIC_VECTOR (15 downto 0);
			IN_RI: 		in  STD_LOGIC_VECTOR (15 downto 0);
			RESET:  	in  STD_LOGIC;
			CLOCK:  	in  STD_LOGIC;
			ENABLE_ALU: in STD_LOGIC;
			COP_IJ: 	in STD_LOGIC;
			Q	 :  	out STD_LOGIC_VECTOR (15 downto 0)
		 );
end ALU;

architecture RTL of ALU is

	signal QINT1, QINT2: STD_LOGIC_VECTOR (15 downto 0);
	--signal aux_RI, aux_RJ, aux_RK: UNSIGNED;
	

	component Reg
		port (  
				ENABLE : in  STD_LOGIC; 
			    RESET  : in  STD_LOGIC;
			    CLOCK  : in  STD_LOGIC;
			    D      : in  STD_LOGIC_VECTOR (15 downto 0);
		        Q      : out STD_LOGIC_VECTOR (15 downto 0)
			  );
	end component;
	
begin
	RegAUX: Reg
	port map (
				ENABLE => ENABLE_ALU,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => QINT1,
				Q      => QINT2
			 );		 
			 
	process(OP, IN_RK, IN_RJ, IN_RI)
	begin
		case OP is
			when "0000" => QINT1 <= "0000000000000000";
			when "0001" => QINT1 <= IN_RJ;
			when "0010" => QINT1 <= IMED;
			when "0011" => QINT1 <= IN_RJ;
			when "0100" => QINT1 <= std_logic_vector(unsigned(IN_RJ) + unsigned(IN_RK));
			when "0101" => QINT1 <= std_logic_vector(unsigned(IN_RJ) + unsigned(IMED));
			when "0110" => QINT1 <= std_logic_vector(unsigned(IN_RJ) - unsigned(IN_RK));
			when "0111" => QINT1 <= std_logic_vector(unsigned(IN_RJ) - unsigned(IMED));
			when "1000" => QINT1 <= IN_RJ AND IN_RK;
			when "1001" => QINT1 <= IN_RJ AND IMED;
			when "1010" => QINT1 <= IN_RJ OR IN_RK;
			when "1011" => QINT1 <= IN_RJ OR IMED;
			when "1100" => QINT1 <= to_stdlogicvector(to_bitvector(IN_RJ) sll to_integer(unsigned(IMED)));
			when "1101" => QINT1 <= to_stdlogicvector(to_bitvector(IN_RJ) srl to_integer(unsigned(IMED)));
			when others => QINT1 <= "0000000000000000";
		end case;
	end process;
	
	Q <= IN_RI when (COP_IJ = '1') else QINT2;
		
end RTL;