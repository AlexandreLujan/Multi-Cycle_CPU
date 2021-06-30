library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX_8X1 is
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
end MUX_8X1;

architecture RTL of MUX_8X1 is
begin
    process (SEL, IN_A, IN_B, IN_C, IN_D, IN_E, IN_F, IN_G, IN_H)
	begin
		case SEL is
			when "000" => Q <= IN_A;
			when "001" => Q <= IN_B;
			when "010" => Q <= IN_C;
			when "011" => Q <= IN_D;
			when "100" => Q <= IN_E;
			when "101" => Q <= IN_F;
			when "110" => Q <= IN_G;
			when "111" => Q <= IN_H;
			when others => Q <= "0000000000000000";
		end case;
	end process;
end RTL;