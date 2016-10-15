library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

-------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
entity getFather is
    Port ( current :in unsigned(2 downto 0) ;
					b : in unsigned(2 downto 0);
				  father :  out unsigned(2 downto 0)
);
end getFather;
---------------------------------------------------------------------------------------
architecture Game of getFather is

--signal father : unsigned(2 downto 0) ;
--signal mymod : unsigned(2 downto 0) ;
signal curr : unsigned(2 downto 0);
--signal t_curr : unsigned(2 downto 0) := "000";

	begin
	curr <= current;
	process(curr)
	     variable t_curr : unsigned(2 downto 0);
	     variable mymod :  unsigned(2 downto 0);

		begin


			mymod := curr mod b;
			if (mymod /= 0) then
				t_curr := curr - mymod;
				father <= t_curr / b;
			end if;
	end process;
--data_coded <= father;
end Game;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
architecture test_bench of getFather is

  -- Component Declaration
Component x Port (current :in unsigned(2 downto 0);
					b : in unsigned(2 downto 0);
				  father :  out unsigned(2 downto 0)
				  );
end component;
for g:x use Entity work.getFather(Game);

signal current1 : unsigned(2 downto 0);
signal b1 :  unsigned(2 downto 0);
signal father1 : unsigned(2 downto 0);
begin

-- Component Instantiation
  g: x PORT MAP(current1,b1,father1);
		 
--    datain1 <= "00011100000110000000000000000000000000000000000000000011010011000000000010100010000000000010001010000000000011010011000000"; --"1100000000000000" after 2 ns,"1010101010101010" after 4 ns,"1111111111111111" after 6 ns,"1111111100000000" after 8 ns,"1111110011001001" after 10 ns; '1','0' after 10 ns;
		current1 <= "100", "011"  after 2 ns,"111" after 4 ns;
		b1 <= "011";

end test_bench;

