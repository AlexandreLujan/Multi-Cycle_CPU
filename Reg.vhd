library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Reg is
	port ( ENABLE : in  STD_LOGIC; 
		   RESET  : in  STD_LOGIC;
		   CLOCK  : in  STD_LOGIC;
		   D      : in  STD_LOGIC_VECTOR (15 downto 0);
		   Q      : out STD_LOGIC_VECTOR (15 downto 0)
		  );
	end Reg ;
	
architecture RTL of Reg is

BEGIN
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            Q <= "0000000000000000";
        elsif rising_edge(CLOCK) then
            if ENABLE = '1' then
                Q <= D;
            end if;
        end if;
    end process;	
	
end RTL ;
