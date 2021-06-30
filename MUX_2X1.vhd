library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX_2X1 is
    port ( SEL  : 	in  STD_LOGIC;
           IN_A : 	in  STD_LOGIC_VECTOR (15 downto 0);
		   IN_B : 	in  STD_LOGIC_VECTOR (15 downto 0);
           Q    :	out STD_LOGIC_VECTOR (15 downto 0)
		  );
end MUX_2X1;

architecture RTL of MUX_2X1 is
begin
    Q <= IN_A when (SEL = '1') else IN_B;
end RTL;