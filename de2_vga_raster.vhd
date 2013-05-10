-------------------------------------------------------------------------------
--
-- Simple VGA raster display
--
-- Stephen A. Edwards
-- sedwards@cs.columbia.edu
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de2_vga_raster is
  
  port (
    reset : in std_logic;
    clk   : in std_logic;                    -- Should be 25.125 MHz
	 bool     : in std_logic;

    VGA_CLK,                         -- Clock
    VGA_HS,                          -- H_SYNC
    VGA_VS,                          -- V_SYNC
    VGA_BLANK,                       -- BLANK
	 VGA_BLANK_SIG,
    VGA_SYNC 	 : out std_logic;      -- SYNC
    VGA_R,                           -- Red[9:0]
    VGA_G,                           -- Green[9:0]
    VGA_B 		 : out unsigned(9 downto 0); -- Blue[9:0]
	 
	 is_Side 	 : in std_logic;
--  line_height : in unsigned (8 downto 0);
	 Col_Color 	 : in unsigned (23 downto 0);
--	 Flr_Color 	 : in unsigned (7 downto 0);
	 Col_Color_sky : in unsigned (7 downto 0);
	 
	 Row_Start   : in unsigned (8 downto 0);
	 Row_Mid     : in unsigned (8 downto 0);
	 Row_End 	 : in unsigned (8 downto 0);
	 texNum      : in unsigned (3 downto 0);
	 texNum2      : in unsigned (3 downto 0);
	 
	 Cur_Row : out unsigned(9 downto 0);
	 Cur_Col : out unsigned(9 downto 0)
	 
    );

end de2_vga_raster;

architecture rtl of de2_vga_raster is
  
  -- Video parameters
  
  constant HTOTAL       : integer := 800;
  constant HSYNC        : integer := 96;
  constant HBACK_PORCH  : integer := 48;
  constant HACTIVE      : integer := 640;
  constant HFRONT_PORCH : integer := 16;
  
  constant VTOTAL       : integer := 525;
  constant VSYNC        : integer := 2;
  constant VBACK_PORCH  : integer := 33;
  constant VACTIVE      : integer := 480;
  constant VFRONT_PORCH : integer := 10;
  
  constant TEXTURE_HSTART : integer := 0;
  constant TEXTURE_HEND   : integer := 64;
  constant TEXTURE_VSTART : integer := 0;
  constant TEXTURE_VEND   : integer := 64;

  -- Signals for the video controller
  signal Hcount : unsigned(9 downto 0);  -- Horizontal position (0-800)
  signal Vcount : unsigned(9 downto 0);  -- Vertical position (0-524)
  signal EndOfLine, EndOfField : std_logic;

  signal write_pixel :std_logic;
  signal tex_Col : unsigned(5 downto 0);
  signal col_draw_prev : std_logic;
  signal col_draw_sky_prev : std_logic;
  
  
  signal vga_hblank, vga_hsync,
    vga_vblank, vga_vsync : std_logic;  -- Sync. signals

  signal Col_Draw : std_logic;  -- Column Signals area
  signal Col_Draw_sky : std_logic;  -- Column Signals area
  signal R, G, B : unsigned(9 downto 0);
  --signal R_sky, G_sky, B_sky : unsigned(9 downto 0);
  signal ROM_OUT : unsigned(7 downto 0);
  
  signal	 Cur_Row_local : unsigned(9 downto 0);
  
  signal Texture_h, Texture_v, Texture : std_logic;  -- texture area
  
  signal Floor_Draw : std_logic;
  --signal Rf, Gf, Bf : unsigned(9 downto 0);

begin

  -- Horizontal and vertical counters

  HCounter : process (clk)
  begin
    if rising_edge(clk) then      
      if reset = '1' then
        Hcount <= (others => '0');
      elsif EndOfLine = '1' then
        Hcount <= (others => '0');
      else
        Hcount <= Hcount + 1;
      end if;      
    end if;
  end process HCounter;

  EndOfLine <= '1' when Hcount = HTOTAL - 1 else '0';
  
  VCounter: process (clk)
  begin
    if rising_edge(clk) then      
      if reset = '1' then
        Vcount <= (others => '0');
      elsif EndOfLine = '1' then
        if EndOfField = '1' then
          Vcount <= (others => '0');
        else
          Vcount <= Vcount + 1;
        end if;
      end if;
    end if;
  end process VCounter;

  EndOfField <= '1' when Vcount = VTOTAL - 1 else '0';

  -- State machines to generate HSYNC, VSYNC, HBLANK, and VBLANK

  HSyncGen : process (clk)
  begin
    if rising_edge(clk) then     
      if reset = '1' or EndOfLine = '1' then
        vga_hsync <= '1';
      elsif Hcount = HSYNC - 1 then
        vga_hsync <= '0';
      end if;
    end if;
  end process HSyncGen;
  
  HBlankGen : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        vga_hblank <= '1';
      elsif Hcount = HSYNC + HBACK_PORCH then
        vga_hblank <= '0';
      elsif Hcount = HSYNC + HBACK_PORCH + HACTIVE then
        vga_hblank <= '1';
      end if;      
    end if;
  end process HBlankGen;

  VSyncGen : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        vga_vsync <= '1';
      elsif EndOfLine ='1' then
        if EndOfField = '1' then
          vga_vsync <= '1';
        elsif Vcount = VSYNC - 1 then
          vga_vsync <= '0';
        end if;
      end if;      
    end if;
  end process VSyncGen;

  VBlankGen : process (clk)
  begin
    if rising_edge(clk) then    
      if reset = '1' then
        vga_vblank <= '1';
      elsif EndOfLine = '1' then
        if Vcount = VSYNC + VBACK_PORCH - 1 then
          vga_vblank <= '0';
        elsif Vcount = VSYNC + VBACK_PORCH + VACTIVE - 1 then
          vga_vblank <= '1';
        end if;
      end if;
    end if;
  end process VBlankGen;

  -- Rectangle generator

  ColumnHGen : process (clk)
  begin
    if rising_edge(clk) then     
--      if reset = '1' or Hcount = HSYNC + HBACK_PORCH + RECTANGLE_HSTART then
--        rectangle_h <= '1';
--      elsif Hcount = HSYNC + HBACK_PORCH + RECTANGLE_HEND then
--        rectangle_h <= '0';
--      end if;  
		if Hcount - HSYNC - HBACK_PORCH < 640 then
			Cur_Col <= Hcount - HSYNC - HBACK_PORCH;
			tex_Col <= Hcount(5 downto 0) - HSYNC - HBACK_PORCH;
		else
			Cur_Col <= (others => '0');
			tex_Col <= (others => '0');
		end if;
    end if;
  end process ColumnHGen;
  
 CurRowGen : process (clk)
  begin
    if rising_edge(clk) then     
		if Vcount - VSYNC - VBACK_PORCH -1 < 480 then
			Cur_Row <= Vcount - VSYNC - VBACK_PORCH - 1;
			Cur_Row_local <= Vcount - VSYNC - VBACK_PORCH - 1; 
		else
			Cur_Row <= (others => '0');
			Cur_Row_local <= (others => '0');
		end if;
    end if;
  end process CurRowGen;

  ColumnVGen : process (clk)
  begin
    if rising_edge(clk) then
		--col_draw_prev <= col_draw;
      if reset = '1' then       
			Col_Draw <= '0';
		elsif (Cur_Row_local > Row_Start or Cur_Row_local > Row_Mid) then
			Col_Draw <= '1';
			if (Cur_Row_local >= Row_End) then
				Floor_Draw <= '1';
			else
				Floor_Draw <= '0';
			end if;
		else
			Col_Draw <= '0';
    	end if;      
    end if;
  end process ColumnVGen;
  

  ColumnVGen_sky : process (clk)
  begin
    if rising_edge(clk) then
		--col_draw_sky_prev <= col_draw_sky;
      if reset = '1' then       
			Col_Draw_sky <= '0';
		elsif (Cur_Row_local <= Row_Start and Cur_Row_local <= Row_Mid) then
			Col_Draw_sky <= '1';
		else
			Col_Draw_sky <= '0';
    	end if;      
    end if;
  end process ColumnVGen_sky;
  
--   FloorVGen : process (clk)
--  begin
--    if rising_edge(clk) then
--      if reset = '1' then       
--			Floor_Draw <= '0';
--		elsif (Cur_Row_local >= Row_End) then
--			Floor_Draw <= '1';
--		else
--			Floor_Draw <= '0';
--    	end if;      
--    end if;
--  end process FloorVGen;
  
  ColorGen : process(Col_Color,Col_Color_sky,col_draw_sky, col_draw, is_Side, bool, texNum, texNum2)
  variable R_temp : unsigned (9 downto 0);
  variable G_temp : unsigned (9 downto 0);
  variable B_temp : unsigned (9 downto 0);
  
  variable R_sky : unsigned (9 downto 0);
  variable G_sky : unsigned (9 downto 0);
  variable B_sky : unsigned (9 downto 0);
  
  begin
--		  R_temp := Col_Color(7 downto 5) & Col_Color(7 downto 5) & Col_Color(7 downto 5) & Col_Color(7);
--        G_temp := Col_Color(4 downto 2) & Col_Color(4 downto 2) & Col_Color(4 downto 2) & Col_Color(4);
--        B_temp := Col_Color(1 downto 0) & Col_Color(1 downto 0) & Col_Color(1 downto 0) & Col_Color(1 downto 0) & Col_Color(1 downto 0);
--		  
--		  R_sky :=  Col_Color_sky(7 downto 5) & Col_Color_sky(7 downto 5) & Col_Color_sky(7 downto 5) & Col_Color_sky(7);
--        G_sky :=  Col_Color_sky(4 downto 2) & Col_Color_sky(4 downto 2) & Col_Color_sky(4 downto 2) & Col_Color_sky(4);
--        B_sky :=  Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0);
		
		 R_sky :=  "0" & Col_Color_sky(7 downto 0) & "0";
       G_sky :=  "0" & Col_Color_sky(7 downto 0) & "0";
		 B_sky :=   "0" & Col_Color_sky(7 downto 0) & "0" ;
		
		  R_temp := Col_Color(23 downto 16) & "00" ;
        G_temp := Col_Color(15 downto 8) & "00";
        B_temp := Col_Color(7 downto 0) & "00";
		
		if (Col_Draw_sky = '1' or (bool = '1' and texNum = x"4") or (bool = '0' and texNum2 = x"4") ) then
			R <= R_sky;
			G <= G_sky;
			B <= B_sky;
			
		elsif (col_draw = '1') then				
			if (is_Side = '0') then
				R <= R_temp;
				G <= G_temp;
				B <= B_temp;
			else 
				R <= (R_temp srl 1);
				G <= (G_temp srl 1);
				B <= (B_temp srl 1);
			end if;
		else
			R <= "0000000000";
			G <= "0000000000";
			B <= "0000000000"; 
		end if;
		
  end process ColorGen;

	BlankGen : process(vga_hblank,vga_vblank)
	begin
		if (vga_hblank = '0' and vga_vblank = '0') then
			write_pixel <= '1';
		else
			write_pixel <= '0';
		end if; 
		
	end process BlankGen;

--  ColorGen_sky : process(Col_Color_sky)
--  begin
--		  R_sky <=  Col_Color_sky(7 downto 5) & Col_Color_sky(7 downto 5) & Col_Color_sky(7 downto 5) & Col_Color_sky(7);
--        G_sky <=  Col_Color_sky(4 downto 2) & Col_Color_sky(4 downto 2) & Col_Color_sky(4 downto 2) & Col_Color_sky(4);
--        B_sky <=  Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0) & Col_Color_sky(1 downto 0);
--	end process ColorGen_sky;
--	
--	FloorGen : process(Flr_Color)
--  begin
--		  Rf <= Flr_Color(7 downto 5) & Flr_Color(7 downto 5) & Flr_Color(7 downto 5) & Flr_Color(7);
--        Gf <= Flr_Color(4 downto 2) & Flr_Color(4 downto 2) & Flr_Color(4 downto 2) & Flr_Color(4);
--        Bf <= Flr_Color(1 downto 0) & Flr_Color(1 downto 0) & Flr_Color(1 downto 0) & Flr_Color(1 downto 0) & Flr_Color(1 downto 0);
--	end process FloorGen;

  -- Registered video signals going to the video DAC

  VideoOut: process (clk, reset)
  begin
    if reset = '1' then
      VGA_R <= "0000000000";
      VGA_G <= "0000000000";
      VGA_B <= "0000000000";
    elsif clk'event and clk = '1' then
		if write_pixel = '1' then
			VGA_R <= R;
			VGA_G <= G;
			VGA_B <= B;
		else
			VGA_R <= "0000000000";
			VGA_G <= "0000000000";
			VGA_B <= "0000000000";    
		end if;
    end if;
  end process VideoOut;

  VGA_CLK <= clk;
  VGA_HS <= not vga_hsync;
  VGA_VS <= not vga_vsync;
  VGA_SYNC <= '0';
  VGA_BLANK <= not (vga_hsync or vga_vsync);
  VGA_BLANK_SIG <= vga_vblank;
end rtl;
