library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CPU is
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
end CPU;

architecture RTL of CPU is
   
	signal ENABLE_A, ENABLE_B, ENABLE_C, ENABLE_D, ENABLE_E, ENABLE_F, ENABLE_G, ENABLE_H, ENABLE_ALU, SEL_MUX2X1, COP_IJ: STD_LOGIC;
	signal QA, QB, QC, QD, QE, QF, QG, QH, QK, QJ, QI, RESULTADO, Q_MUX2X1: STD_LOGIC_VECTOR(15 downto 0);
	signal OP_ALU: STD_LOGIC_VECTOR(3 downto 0);
	signal SEL_K, SEL_J, SEL_I: STD_LOGIC_VECTOR(2 downto 0);
	
	component MUX_2X1
	port ( SEL  : 	in  STD_LOGIC;
           IN_A : 	in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_B : 	in  STD_LOGIC_VECTOR (15 downto 0);
           Q    :	out STD_LOGIC_VECTOR (15 downto 0)
		  );
	end component;
	
	component Reg
	port ( ENABLE : in  STD_LOGIC; 
		   RESET  : in  STD_LOGIC;
		   CLOCK  : in  STD_LOGIC;
		   D      : in  STD_LOGIC_VECTOR (15 downto 0);
		   Q      : out STD_LOGIC_VECTOR (15 downto 0)
		  );
	end component;
	
	component MUX_8X1
	port ( SEL 	: 		in  STD_LOGIC_VECTOR (2  downto 0);
           IN_A : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_B : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_C : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_D : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_E : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_F : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_G : 		in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_H : 		in  STD_LOGIC_VECTOR (15 downto 0);
           Q 	:		out STD_LOGIC_VECTOR (15 downto 0)
		  );
	end component;
		  
	component ALU
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
	end component;
		 
	component Control
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
			OP	  		: out STD_LOGIC_VECTOR (3  downto 0);
			RK    		: out STD_LOGIC_VECTOR (2  downto 0);
			RJ    		: out STD_LOGIC_VECTOR (2  downto 0);
			RI    		: out STD_LOGIC_VECTOR (2  downto 0);
			COP_IJ      : out STD_LOGIC
		 );
	end component;	 
	
begin	

	Un_MUX_2X1: MUX_2X1
	port map (
				SEL  => SEL_MUX2X1,
				IN_A => DATA,
				IN_B => RESULTADO,
				Q    => Q_MUX2X1
			 );

	RegA: Reg
	port map (
				ENABLE => ENABLE_A,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QA
			 );

	RegB: Reg
	port map (
				ENABLE => ENABLE_B,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QB
			 );
			 
	RegC: Reg
	port map (
				ENABLE => ENABLE_C,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QC
			 );		 
			 
	RegD: Reg
	port map (
				ENABLE => ENABLE_D,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QD
			 );		 
	
	RegE: Reg
	port map (
				ENABLE => ENABLE_E,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QE
			 );
	
	RegF: Reg
	port map (
				ENABLE => ENABLE_F,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QF
			 );
	
	RegG: Reg
	port map (
				ENABLE => ENABLE_G,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QG
			 );
			 
	RegH: Reg
	port map (
				ENABLE => ENABLE_H,
				RESET  => RESET,
				CLOCK  => CLOCK,
				D      => Q_MUX2X1,
				Q      => QH
			 );	
	
	K_MUX_8X1: MUX_8X1
	port map (
				SEL  => SEL_K,
				IN_A => QA,
				IN_B => QB,
				IN_C => QC,	
				IN_D => QD,
				IN_E => QE,
				IN_F => QF,
				IN_G => QG,
				IN_H => QH,
				Q 	 => QK
			 );
			 
	J_MUX_8X1: MUX_8X1
	port map (
				SEL  => SEL_J,
				IN_A => QA,
				IN_B => QB,
				IN_C => QC,	
				IN_D => QD,
				IN_E => QE,
				IN_F => QF,
				IN_G => QG,
				IN_H => QH,
				Q 	 => QJ
			 );	

	I_MUX_8X1: MUX_8X1
	port map (
				SEL  => SEL_I,
				IN_A => QA,
				IN_B => QB,
				IN_C => QC,	
				IN_D => QD,
				IN_E => QE,
				IN_F => QF,
				IN_G => QG,
				IN_H => QH,
				Q 	 => QI
			 );
	
	Un_ALU: ALU
	port map (
				OP    => OP_ALU,
				IMED  => DATA,
				IN_RK => QK,
				IN_RJ => QJ,
				IN_RI => QI,
				RESET => RESET,
				CLOCK => CLOCK,
				ENABLE_ALU => ENABLE_ALU,
				COP_IJ => COP_IJ,
				Q	  => RESULTADO
			 );
			 
	Un_Controle: Control
	port map (
				RESET => RESET,
				CLOCK => CLOCK,
				FUNCT => FUNCT,
				SEL   => SEL_MUX2X1,
				ENABLE_A => ENABLE_A,
				ENABLE_B => ENABLE_B,
				ENABLE_C => ENABLE_C,
				ENABLE_D => ENABLE_D,
				ENABLE_E => ENABLE_E,
				ENABLE_F => ENABLE_F,
				ENABLE_G => ENABLE_G,
				ENABLE_H => ENABLE_H,
				ENABLE_ALU => ENABLE_ALU,
				OP	  => OP_ALU,
				RK    => SEL_K,
				RJ    => SEL_J,
				RI    => SEL_I,
				COP_IJ => COP_IJ
			 );
	
				OUT_RA <= QA;
				OUT_RB <= QB;
				OUT_RC <= QC;
				OUT_RD <= QD;
				OUT_RE <= QE;
				OUT_RF <= QF;
				OUT_RG <= QG;
				OUT_RH <= QH;
		 
end RTL;
