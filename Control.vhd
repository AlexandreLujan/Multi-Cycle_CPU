library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Control is
	port (
			RESET   	: in  STD_LOGIC;
			CLOCK   	: in  STD_LOGIC;
			FUNCT 		: in  STD_LOGIC_VECTOR (12  downto 0);
			SEL   		: out STD_LOGIC;
			ENABLE_A	: out STD_LOGIC;
			ENABLE_B	: out STD_LOGIC;
			ENABLE_C	: out STD_LOGIC;
			ENABLE_D	: out STD_LOGIC;
			ENABLE_E	: out STD_LOGIC;
			ENABLE_F	: out STD_LOGIC;
			ENABLE_G	: out STD_LOGIC;
			ENABLE_H	: out STD_LOGIC;
			ENABLE_ALU	: out STD_LOGIC;
			OP	  	: out STD_LOGIC_VECTOR (3  downto 0);
			RK    		: out STD_LOGIC_VECTOR (2  downto 0);
			RJ    		: out STD_LOGIC_VECTOR (2  downto 0);
			RI    		: out STD_LOGIC_VECTOR (2  downto 0);
			COP_IJ      : out STD_LOGIC
		 );
end Control;

architecture RTL of Control is

type estado is (exec, reg1, reg1x, reg2x);
signal state, next_state : estado;

signal regCel: STD_LOGIC_VECTOR (2 downto 0);
signal AINT, BINT, CINT, DINT, EINT, FINT, GINT, HINT: STD_LOGIC;

begin
	OP <= FUNCT(3 downto 0);
	RK <= FUNCT(6 downto 4);
	RJ <= FUNCT(9 downto 7);
	RI <= FUNCT(12 downto 10);
		
	SEL <= '1' when (FUNCT(3 downto 0) = "0010") else '0';
	
	process(state, FUNCT(3 downto 0))
	begin
		case state is 
			when exec =>
				if(FUNCT(3 downto 0) = "0011") then
					next_state <= reg1x;
				elsif(FUNCT(3 downto 0) = "0000") then
					next_state <= exec;
				else
					next_state <= reg1;
				end if;
					
			when reg1 =>
					next_state <= exec;
			when reg1x =>
					next_state <= reg2x;
			when reg2x =>
					next_state <= exec;		
			when others =>
				next_state <= exec;
		end case;
	end process;
	
	process(CLOCK, RESET)
	begin
		if(RESET = '1') then
			state <= exec;
		elsif (rising_edge(CLOCK)) then
			state <= next_state;
		end if;
		
	end process;
	
	ENABLE_ALU <= '1' when (state = exec) else '0';
	
	regCel <= (FUNCT(9 downto 7)) when (state = reg1x) else (FUNCT(12 downto 10));
	
	AINT <= '1' when (regCel = "000") else '0';
	BINT <= '1' when (regCel = "001") else '0';
	CINT <= '1' when (regCel = "010") else '0';
	DINT <= '1' when (regCel = "011") else '0';
	EINT <= '1' when (regCel = "100") else '0';
	FINT <= '1' when (regCel = "101") else '0';
	GINT <= '1' when (regCel = "110") else '0';
	HINT <= '1' when (regCel = "111") else '0';
	
	ENABLE_A <= AINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_B <= BINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_C <= CINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_D <= DINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_E <= EINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_F <= FINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_G <= GINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	ENABLE_H <= HINT when ((state = reg1) OR (state = reg1x) OR (state = reg2x)) else '0';
	
	COP_IJ <= '1' when (state = reg1x) else '0';
	
end RTL;

