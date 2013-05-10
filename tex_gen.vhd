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
	-- clk25 : in std_logic;
	 side1   : in std_logic;
	 side2   : in std_logic;
	 bool    : in std_logic;
	 boolOut    : out std_logic;
	 Cur_Row 	 : in unsigned (11 downto 0);
	 Row_End 	 : in unsigned (8 downto 0);
	 Row_Mid	    : in unsigned (8 downto 0);
	 texNum 	    : in unsigned (3 downto 0);
	 texNum2 	    : in unsigned (3 downto 0);
	 invLineHeight : in unsigned (17 downto 0);
	 line_minus_h  : in signed (17 downto 0);
	 invLineHeight2 : in unsigned (17 downto 0);
	 line_minus_h2  : in signed (17 downto 0);
	 texX				: in unsigned (5 downto 0);
	 texX2			: in unsigned (5 downto 0);
	 floorX		: in unsigned (17 downto 0);
	 floorY		: in unsigned (17 downto 0);
	 tmpPosX		: in unsigned (17 downto 0);
    tmpPosY		: in unsigned (17 downto 0);
	 invDistWall	: in unsigned (11 downto 0);
	 y				: in unsigned (8 downto 0);
	 textureIndexOut:	out unsigned (11 downto 0);
	 SideOut         : out std_logic;
	 texNumOut 	    : out unsigned (3 downto 0);
	 texNum2Out 	 : out unsigned (3 downto 0);
	 
--	 Row_Start  : out unsigned (8 downto 0);
--   Row_End 	: out unsigned (8 downto 0);
	 tex_addr_out	: out unsigned (13 downto 0)
	 
    );

end tex_gen;

architecture rtl of tex_gen is

type rom_type is array(0 to 239) of unsigned (15 downto 0);
constant DIVTABLE: rom_type := (
	x"1000",x"1011",x"1022",x"1033",x"1045",x"1057",x"1069",x"107b",x"108d",x"109f",x"10b2",
	x"10c4",x"10d7",x"10ea",x"10fd",x"1111",x"1124",x"1138",x"114c",x"1160",x"1174",x"1188",
	x"119d",x"11b2",x"11c7",x"11dc",x"11f1",x"1207",x"121c",x"1232",x"1249",x"125f",x"1276",
	x"128c",x"12a4",x"12bb",x"12d2",x"12ea",x"1302",x"131a",x"1333",x"134b",x"1364",x"137e",
	x"1397",x"13b1",x"13cb",x"13e5",x"1400",x"141a",x"1435",x"1451",x"146c",x"1488",x"14a5",
	x"14c1",x"14de",x"14fb",x"1519",x"1537",x"1555",x"1573",x"1592",x"15b1",x"15d1",x"15f1",
	x"1611",x"1632",x"1653",x"1674",x"1696",x"16b8",x"16db",x"16fe",x"1721",x"1745",x"176a",
	x"178e",x"17b4",x"17d9",x"1800",x"1826",x"184d",x"1875",x"189d",x"18c6",x"18ef",x"1919",
	x"1943",x"196e",x"1999",x"19c5",x"19f2",x"1a1f",x"1a4d",x"1a7b",x"1aaa",x"1ada",x"1b0a",
	x"1b3b",x"1b6d",x"1ba0",x"1bd3",x"1c07",x"1c3c",x"1c71",x"1ca8",x"1cdf",x"1d17",x"1d50",
	x"1d89",x"1dc4",x"1e00",x"1e3c",x"1e79",x"1eb8",x"1ef7",x"1f38",x"1f79",x"1fbc",x"2000",
	x"2044",x"208a",x"20d2",x"211a",x"2164",x"21af",x"21fb",x"2249",x"2298",x"22e8",x"233a",
	x"238e",x"23e3",x"2439",x"2492",x"24ec",x"2548",x"25a5",x"2605",x"2666",x"26c9",x"272f",
	x"2796",x"2800",x"286b",x"28d9",x"294a",x"29bd",x"2a32",x"2aaa",x"2b25",x"2ba2",x"2c23",
	x"2ca6",x"2d2d",x"2db6",x"2e43",x"2ed4",x"2f68",x"3000",x"309b",x"313b",x"31de",x"3286",
	x"3333",x"33e4",x"349a",x"3555",x"3615",x"36db",x"37a6",x"3878",x"3950",x"3a2e",x"3b13",
	x"3c00",x"3cf3",x"3def",x"3ef3",x"4000",x"4115",x"4234",x"435e",x"4492",x"45d1",x"471c",
	x"4873",x"49d8",x"4b4b",x"4ccc",x"4e5e",x"5000",x"51b3",x"537a",x"5555",x"5745",x"594d",
	x"5b6d",x"5da8",x"6000",x"6276",x"650d",x"67c8",x"6aaa",x"6db6",x"70f0",x"745d",x"7800",
	x"7bde",x"8000",x"8469",x"8924",x"8e38",x"93b1",x"9999",x"a000",x"a6f4",x"ae8b",x"b6db",
	x"c000",x"ca1a",x"d555",x"e1e1",x"f000",x"0000",x"1249",x"2762",x"4000",x"5d17",x"8000",
	x"aaaa",x"e000",x"2492",x"8000",x"0000",x"c000",x"0000",x"8000",x"0000"
);
--  constant SCREENHEIGHT        : unsigned(8 downto 0) := "111100000"; --480
--  constant SCREENHEIGHT_HALF   : unsigned(8 downto 0) := "011110000"; --240
--  constant SCREENHEIGHTMINUS1  : unsigned(8 downto 0) := "111111110"; --470
	
	signal y_local : unsigned (8 downto 0);
	signal cur_row_local : unsigned (11 downto 0);
	signal tex_addr : unsigned (13 downto 0);
	signal clk_enable : std_logic := '0';
	signal inA_0 : std_logic_vector(17 downto 0) := (others => '0');
	signal inB_0 : std_logic_vector(17 downto 0) := (others => '0');
	signal inA_1 : std_logic_vector(17 downto 0) := (others => '0');
	signal inB_1 : std_logic_vector(17 downto 0) := (others => '0');
	signal result_0 : std_logic_vector(35 downto 0);
	signal result_1 : std_logic_vector(35 downto 0);
	signal sideSig : std_logic;
	signal boolSig : std_logic := '0';
	signal texNumSig : unsigned (3 downto 0);
	signal texNum2Sig : unsigned (3 downto 0); 
--	signal tmp : unsigned (12 downto 0);
--	signal floorXprev : unsigned (17 downto 0);  
--	signal floorYprev : unsigned (17 downto 0 );
--   signal tmpPosXprev : unsigned (17 downto 0);  
--	signal tmpPosYprev : unsigned (17 downto 0); 	
--	signal weight : unsigned (27 downto 0);
--  	signal texY_0 : unsigned (35 downto 0);
--	signal texY_1 : unsigned (35 downto 0);
--	
--	signal texXprev : unsigned (5 downto 0);
--	signal texX2prev : unsigned (5 downto 0);
--	
--   signal texNumprev : unsigned (3 downto 0);
--	signal texNum2prev : unsigned (3 downto 0);
--	
--	signal texNumprev_2 : unsigned (3 downto 0);
--	signal texNum2prev_2 : unsigned (3 downto 0);
--	
--	signal side1prev : std_logic;
--	signal side2prev :std_logic;
--	signal boolprev  : std_logic; 
--	
--	signal row_Mid_prev : unsigned (8 downto 0);
--	signal row_End_prev : unsigned ( 8 downto 0);
  
begin

   S0: entity work.mult port map (
		dataa		=> inA_0,
		datab		=> inB_0,
		result	=> result_0
  );
  
   S1: entity work.mult port map (
		dataa		=> inA_1,
		datab		=> inB_1,
		result	=> result_1
  );
	
	process (floorX, floorY, tmpPosX, tmpPosY, invDistWall, y ,row_end , cur_row, texX,texNum, line_minus_h,invLineHeight,texX2,texNum2, line_minus_h2,invLineHeight2, bool, side1, side2, result_0,result_1 ,row_Mid)
	
	--process (clk)
	
	variable texY_0 : unsigned (35 downto 0);
	variable texY_1 : unsigned (35 downto 0);
	variable currentDist : unsigned (15 downto 0);
	variable weight:	unsigned (27 downto 0);
	variable tmp : unsigned (12 downto 0);
	variable currentFloorX : unsigned (30 downto 0);
	variable currentFloorY : unsigned (30 downto 0);
	
	variable floorTexX : unsigned (5 downto 0);
	variable floorTexY : unsigned (5 downto 0);
	
	variable temp_mult_0 : unsigned (17 downto 0);
	variable temp_mult_1 : unsigned (17 downto 0);
	
	variable checker_board_pattern : unsigned (0 downto 0);

	begin
		--if (rising_edge(clk) )	then
			
			-- gated inputs from VGA
			-- gated outputs to asynchronous VGA and Texture ROM processes 
--			if (clk25 = '1') then			
--				y_local <= y;
--				cur_row_local <= cur_row;
--				
--				tex_addr_out <= tex_addr;
--				sideOut <= sideSig;
--				boolOut <= boolSig;
--				texNumOut  <= texNum;
--				texNum2Out <=  texNum2;
--				
--
--			end if;
--			
			----------------------------------------------------------------
			
			-- stage 1 pipeline
			temp_mult_0 :=  unsigned(signed(cur_row sll 1)+ line_minus_h) (17 downto 0);
			inA_0 <= std_logic_vector(temp_mult_0);
			inB_0 <= std_logic_vector(invlineHeight);
			texY_0 := unsigned(result_0) srl 16 ;
			
			temp_mult_1 :=  unsigned(signed(cur_row sll 1)+ line_minus_h2) (17 downto 0);
			inA_1 <= std_logic_vector(temp_mult_1);
			inB_1 <= std_logic_vector(invlineHeight2);
			texY_1 := unsigned(result_1) srl 16 ;	
			
			currentDist := DIVTABLE(to_integer(480 - y));
			weight := currentDist * invDistWall;
			tmp := "1000000000000" - weight(23 downto 12);
			
--			y_prev <= y;		
--			
--			texXprev <=  texX;
--			texX2prev <=  texX2;
--			texNumprev <=  texNum;
--			texNum2prev <=  texNum2;
--			
--			tmpPosXprev <= tmpPosX;
--			tmpPosYprev <= tmpPosY;
--			
--			floorXprev <= floorX;
--			floorYprev <= floorY;
--			
--			side1prev <= side1;
--			side2prev <= side2;
--			boolprev  <= bool; 
--			row_Mid_prev <= row_Mid;
--			row_End_prev <= row_End;
			
			---------------------------------------------------------------
			
			--stage 2 pipeline
			currentFloorX := (weight(23 downto 12) * floorX + tmp * tmpPosX);
			currentFloorY := (weight(23 downto 12) * floorY + tmp * tmpPosY);
				
			floorTexX := currentFloorX(23 downto 18);
			floorTexY := currentFloorY(23 downto 18);
	
			checker_board_pattern := unsigned(currentFloorX(29 downto 24) + currentFloorY(29 downto 24))(0 downto 0);
			
			if (y <= row_end +1 ) then				
	
				if (bool ='1' or (y >= row_mid)) then
					boolSig <= '1';
					tex_addr <= texNum(1 downto 0) & texY_0(5 downto 0) & texX;
					sideSig <= side1;
				else
					boolSig <= '0';
					tex_addr <= texNum2(1 downto 0) & texY_1(5 downto 0) & texX2;
					
					sideSig <= side2;	
				end if;
				
				texNumSig <= texNum;
				texNum2Sig <= texNum2;
			else

				if (checker_board_pattern = "1") then
					tex_addr <= ( "11"& floorTexY & floorTexX);
				else 
					tex_addr <= ( "00"& floorTexY & floorTexX);
				end if;
				texNumSig <= "0000";
				texNum2Sig <= "0000";
				sideSig <= '1';
				boolSig <= '0';
			end if;
			
--			texNumprev_2 <= texNumprev;
--			texNum2prev_2 <= texNum2prev;

			--------------------------------------------------------
			--Gated Outputs
			

	
	--end if;
	
	end process;
	
	
	

			
	process (clk)
	begin
		if (rising_edge(clk)) then
			tex_addr_out <= tex_addr;
			sideOut <= sideSig;
			boolOut <= boolSig;
			texNumOut  <= texNumSig;
			texNum2Out <=  texNum2Sig;
		end if;
	end process;
--	

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
