-------------------------------------------------------------------------------
--
-- Texture Generation
--
-- Edward Garcia
-- ewg2115@columbia.edu
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tex_gen is
  
  port (
    reset : in std_logic;
    clk   : in std_logic;                    -- Should be 50 MHz
	 Cur_Row 	 : in unsigned (11 downto 0);
	 
	 invLineHeight : in unsigned (17 downto 0);
	 line_minus_h  : in signed (17 downto 0);
	 texX				: in unsigned (5 downto 0);
	 
--	 Row_Start  : out unsigned (8 downto 0);
--   Row_End 	: out unsigned (8 downto 0);
	 tex_pixel	: out unsigned (11 downto 0)
	 
    );

end tex_gen;

architecture rtl of tex_gen is

--  constant SCREENHEIGHT        : unsigned(8 downto 0) := "111100000"; --480
--  constant SCREENHEIGHT_HALF   : unsigned(8 downto 0) := "011110000"; --240
--  constant SCREENHEIGHTMINUS1  : unsigned(8 downto 0) := "111111110"; --470
	signal texY : unsigned (35 downto 0);
	signal tex_pixel_local	: unsigned (35 downto 0);
	
  
begin

	texPixelGen : process (clk)
	begin
		if rising_edge(clk) then
			texY <= ( ( unsigned( signed("000000" & (cur_Row sll 1)) + line_minus_h ) * invLineHeight) srl 17 );
			tex_pixel_local <= (texY sll 6) + texX;
		end if;
	end process texPixelGen;

	tex_pixel <= tex_pixel_local(11 downto 0);

--  RowStartEndGen : process (clk)
--  begin
--      if rising_edge(clk) then
--			if (line_height > SCREENHEIGHT) then
--				Row_Start <= (others => '0');	
--				Row_End <= SCREENHEIGHTMINUS1;	
--			else 
--				Row_Start <= SCREENHEIGHT_HALF - ( "0" & line_height (8 downto 1));
--				Row_End <= SCREENHEIGHT_HALF + ( "0" & line_height(8 downto 1));	
--			end if;	
--		end if;
--  end process RowStartEndGen;

end rtl;