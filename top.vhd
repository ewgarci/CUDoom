--
-- DE2 top-level module that includes the simple VGA raster generator
--
-- Stephen A. Edwards, Columbia University, sedwards@cs.columbia.edu
--
-- From an original by Terasic Technology, Inc.
-- (DE2_TOP.v, part of the DE2 system board CD supplied by Altera)
--



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is

  port (
    -- Clocks
    
    CLOCK_27,                                      -- 27 MHz
    CLOCK_50,                                      -- 50 MHz
    EXT_CLOCK : in std_logic;                      -- External Clock

    -- Buttons and switches
    
    KEY : in std_logic_vector(3 downto 0);         -- Push buttons
    SW : in std_logic_vector(17 downto 0);         -- DPDT switches

    -- LED displays

    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 -- 7-segment displays
       : out std_logic_vector(6 downto 0);
    LEDG : out std_logic_vector(8 downto 0);       -- Green LEDs
    LEDR : out std_logic_vector(17 downto 0);      -- Red LEDs

    -- RS-232 interface

    UART_TXD : out std_logic;                      -- UART transmitter   
    UART_RXD : in std_logic;                       -- UART receiver

    -- IRDA interface

--    IRDA_TXD : out std_logic;                      -- IRDA Transmitter
    IRDA_RXD : in std_logic;                       -- IRDA Receiver

    -- SDRAM
   
    DRAM_DQ : inout std_logic_vector(15 downto 0); -- Data Bus
    DRAM_ADDR : out std_logic_vector(11 downto 0); -- Address Bus    
    DRAM_LDQM,                                     -- Low-byte Data Mask 
    DRAM_UDQM,                                     -- High-byte Data Mask
    DRAM_WE_N,                                     -- Write Enable
    DRAM_CAS_N,                                    -- Column Address Strobe
    DRAM_RAS_N,                                    -- Row Address Strobe
    DRAM_CS_N,                                     -- Chip Select
    DRAM_BA_0,                                     -- Bank Address 0
    DRAM_BA_1,                                     -- Bank Address 0
    DRAM_CLK,                                      -- Clock
    DRAM_CKE : out std_logic;                      -- Clock Enable

    -- FLASH
    
    FL_DQ : inout std_logic_vector(7 downto 0);      -- Data bus
    FL_ADDR : out std_logic_vector(21 downto 0);  -- Address bus
    FL_WE_N,                                         -- Write Enable
    FL_RST_N,                                        -- Reset
    FL_OE_N,                                         -- Output Enable
    FL_CE_N : out std_logic;                         -- Chip Enable

    -- SRAM
    
    SRAM_DQ : inout std_logic_vector(15 downto 0); -- Data bus 16 Bits
    SRAM_ADDR : out std_logic_vector(17 downto 0); -- Address bus 18 Bits
    SRAM_UB_N,                                     -- High-byte Data Mask 
    SRAM_LB_N,                                     -- Low-byte Data Mask 
    SRAM_WE_N,                                     -- Write Enable
    SRAM_CE_N,                                     -- Chip Enable
    SRAM_OE_N : out std_logic;                     -- Output Enable

    -- USB controller
    
    OTG_DATA : inout std_logic_vector(15 downto 0); -- Data bus
    OTG_ADDR : out std_logic_vector(1 downto 0);    -- Address
    OTG_CS_N,                                       -- Chip Select
    OTG_RD_N,                                       -- Write
    OTG_WR_N,                                       -- Read
    OTG_RST_N,                                      -- Reset
    OTG_FSPEED,                     -- USB Full Speed, 0 = Enable, Z = Disable
    OTG_LSPEED : out std_logic;     -- USB Low Speed, 0 = Enable, Z = Disable
    OTG_INT0,                                       -- Interrupt 0
    OTG_INT1,                                       -- Interrupt 1
    OTG_DREQ0,                                      -- DMA Request 0
    OTG_DREQ1 : in std_logic;                       -- DMA Request 1   
    OTG_DACK0_N,                                    -- DMA Acknowledge 0
    OTG_DACK1_N : out std_logic;                    -- DMA Acknowledge 1

    -- 16 X 2 LCD Module
    
    LCD_ON,                     -- Power ON/OFF
    LCD_BLON,                   -- Back Light ON/OFF
    LCD_RW,                     -- Read/Write Select, 0 = Write, 1 = Read
    LCD_EN,                     -- Enable
    LCD_RS : out std_logic;     -- Command/Data Select, 0 = Command, 1 = Data
    LCD_DATA : inout std_logic_vector(7 downto 0); -- Data bus 8 bits

    -- SD card interface
    
    SD_DAT,                     -- SD Card Data
    SD_DAT3,                    -- SD Card Data 3
    SD_CMD : inout std_logic;   -- SD Card Command Signal
    SD_CLK : out std_logic;     -- SD Card Clock

    -- USB JTAG link
    
    TDI,                        -- CPLD -> FPGA (data in)
    TCK,                        -- CPLD -> FPGA (clk)
    TCS : in std_logic;         -- CPLD -> FPGA (CS)
    TDO : out std_logic;        -- FPGA -> CPLD (data out)

    -- I2C bus
    
    I2C_SDAT : inout std_logic; -- I2C Data
    I2C_SCLK : out std_logic;   -- I2C Clock

    -- PS/2 port

    PS2_DAT,                    -- Data
    PS2_CLK : in std_logic;     -- Clock

    -- VGA output
    
    VGA_CLK,                                            -- Clock
    VGA_HS,                                             -- H_SYNC
    VGA_VS,                                             -- V_SYNC
    VGA_BLANK,                                          -- BLANK
    VGA_SYNC : out std_logic;                           -- SYNC
    VGA_R,                                              -- Red[9:0]
    VGA_G,                                              -- Green[9:0]
    VGA_B : out unsigned(9 downto 0);                   -- Blue[9:0]

    --  Ethernet Interface
    
    ENET_DATA : inout std_logic_vector(15 downto 0);    -- DATA bus 16Bits
    ENET_CMD,           -- Command/Data Select, 0 = Command, 1 = Data
    ENET_CS_N,                                          -- Chip Select
    ENET_WR_N,                                          -- Write
    ENET_RD_N,                                          -- Read
    ENET_RST_N,                                         -- Reset
    ENET_CLK : out std_logic;                           -- Clock 25 MHz
    ENET_INT : in std_logic;                            -- Interrupt
    
    -- Audio CODEC
    
    AUD_ADCLRCK : inout std_logic;                      -- ADC LR Clock
    AUD_ADCDAT : in std_logic;                          -- ADC Data
    AUD_DACLRCK : inout std_logic;                      -- DAC LR Clock
    AUD_DACDAT : out std_logic;                         -- DAC Data
    AUD_BCLK : inout std_logic;                         -- Bit-Stream Clock
    AUD_XCK : out std_logic;                            -- Chip Clock
    
    -- Video Decoder
    
    TD_DATA : in std_logic_vector(7 downto 0);  -- Data bus 8 bits
    TD_HS,                                      -- H_SYNC
    TD_VS : in std_logic;                       -- V_SYNC
    TD_RESET : out std_logic;                   -- Reset
    
    -- General-purpose I/O
    
    GPIO_0,                                      -- GPIO Connection 0
    GPIO_1 : inout std_logic_vector(35 downto 0) -- GPIO Connection 1   
    );
  
end top;

architecture datapath of top is

  signal clk_dram : std_logic := '0';
  signal clk_sys : std_logic := '0';
  signal clk25 : std_logic := '0';
  signal clk25_shift : std_logic := '1';
  signal reset_n : std_logic := '0'; 
  signal VGA_BLANK_SIG : std_logic := '0'; 
  signal counter : unsigned(15 downto 0);
 
  signal data_out    : STD_LOGIC_VECTOR (255 downto 0);
  signal mem_out 		: STD_LOGIC_VECTOR (255 downto 0);
  signal data_out1    : STD_LOGIC_VECTOR (63 downto 0);
  signal data_out2    : STD_LOGIC_VECTOR (255 downto 0);
  signal Cur_Col     : unsigned (9 downto 0);

  signal Cur_Row 		: unsigned (9 downto 0);
  signal cur_row_from_mem : unsigned (9 downto 0);
  signal tex_addr	: unsigned (13 downto 0);
  signal ctrl 			: std_logic := '0';
  
  signal row_s     : unsigned (8 downto 0);
  signal row_e     : unsigned (8 downto 0);
  signal tex_rom_out   : unsigned (23 downto 0);
  signal flr_rom_out   : unsigned (7 downto 0);
  signal frame_rate : unsigned (7 downto 0);
  signal state_out : std_LOGIC_VECTOR(11 downto 0);

  signal sky_out   : STD_LOGIC_VECTOR (7 downto 0);

   signal sram_mux		: std_logic;  
  
   signal data_rdy		: std_logic;
	signal isSide			: std_logic;
	signal isSide2			: std_logic;
	signal sideOut       : std_logic;
	signal write_en		: std_logic;
	signal bool          : std_logic;
	
	signal boolToTex     : std_logic;
	signal texNumToTex   : unsigned (3 downto 0);
	signal texNum2ToTex  : unsigned (3 downto 0);
	signal sideToTex     : std_logic;
	
	signal boolOut       : std_logic;
	signal texNum			: unsigned (3 downto 0);
	signal texNum2       : unsigned (3 downto 0);
	signal texNumOut	   : unsigned (3 downto 0);
	signal texNum2Out    : unsigned (3 downto 0);
	signal texX				: unsigned (31 downto 0);
	signal texX2			: unsigned (31 downto 0);
	signal floorX			: unsigned (31 downto 0);		
	signal floorY			: unsigned (31 downto 0);
	signal line_minus_h	: unsigned (31 downto 0);
	signal invline			: unsigned (31 downto 0);
	signal line_minus_h2	: unsigned (31 downto 0);
	signal invline2	   : unsigned (31 downto 0);
	signal invdist_out	: unsigned (31 downto 0);
	signal drawStart		: unsigned (31 downto 0);
	signal drawMid 		: unsigned (31 downto 0);
	signal drawEnd			: unsigned (31 downto 0);
	signal countout      : unsigned (31 downto 0);
	signal countout2     : unsigned (31 downto 0);
	signal colAddrOut		: unsigned (9 downto 0);
	signal floor_pixel	: unsigned (11 downto 0);
	signal tmpPosX  		: unsigned (31 downto 0);
	signal tmpPosY		   : unsigned (31 downto 0);
	
	--FIFO signals
	signal rdempty_sig : std_logic;
	signal wrfull_sig : std_logic;
	signal rdreq_sig : std_logic;
	signal  VGA_BLANK_OUT  : std_logic;
	signal q_fifo  : std_logic_vector (255 downto 0);
	
begin

--  process (clk_sys)
--  begin
--    if rising_edge(clk_sys) then
--      clk25 <= not clk25;
--		clk25_shift <= not clk25_shift;
--    end if;
--  end process;

  process (clk_sys)
  begin
    if counter = x"ffff" then
      reset_n <= '1';
    else
      reset_n <= '0';
      counter <= counter + 1;
    end if;
  end process;
  


  V0: entity work.sdram_pll port map (
		inclk0 => CLOCK_50,
		c0	=> clk_dram,	
		c1	=> clk_sys,
		c2	=> clk25
	);
	
--	V7: entity work.pll_25 port map (
--		
--		inclk0 => clk_sys,
--		c0 => clk25
--		
--	);

  V1: entity work.new_doom port map (
 -- 1) global signals:
     reset_n => reset_n,
     clk_0 => clk_sys,
	  
 
	 -- the_niosInterface_0
	  ctrl_from_the_niosInterface_1_0 => ctrl,
     hardware_data_to_the_niosInterface_1_0 => ("00000000000000000000" & std_logic_vector(frame_rate) & "000" & data_rdy),
     nios_data_from_the_niosInterface_1_0 =>  data_out,

  -- the_sram
    SRAM_ADDR_from_the_skygen_0 => SRAM_ADDR,
    SRAM_CE_N_from_the_skygen_0 => SRAM_CE_N,
    SRAM_DQ_to_and_from_the_skygen_0 => SRAM_DQ,
    SRAM_LB_N_from_the_skygen_0 => SRAM_LB_N,
    SRAM_OE_N_from_the_skygen_0 => SRAM_OE_N,
    SRAM_UB_N_from_the_skygen_0 => SRAM_UB_N,
    SRAM_WE_N_from_the_skygen_0 => SRAM_WE_N,

-- SDRAM
      zs_addr_from_the_sdram_0 => DRAM_ADDR(11 downto 0),
      zs_ba_from_the_sdram_0(0) => DRAM_BA_0,
      zs_ba_from_the_sdram_0(1) => DRAM_BA_1,
      zs_cas_n_from_the_sdram_0 => DRAM_CAS_N,
      zs_cke_from_the_sdram_0 => DRAM_CKE,
      zs_cs_n_from_the_sdram_0 => DRAM_CS_N,
      zs_dq_to_and_from_the_sdram_0 => DRAM_DQ(15 downto 0),
      zs_dqm_from_the_sdram_0(0) => DRAM_LDQM,
      zs_dqm_from_the_sdram_0(1) => DRAM_UDQM,
      zs_ras_n_from_the_sdram_0 => DRAM_RAS_N,
      zs_we_n_from_the_sdram_0 => DRAM_WE_N,
-- New
      Cur_Row_in_to_the_skygen_0 =>  STD_LOGIC_VECTOR(Cur_Row(9 downto 0)),
      FB_angle_in_to_the_skygen_0 => STD_LOGIC_VECTOR(mem_out(169 downto 160)),   --Need to Modify !!!! 
      Sky_pixel_from_the_skygen_0 => sky_out(7 downto 0),
      Sram_mux_out_from_the_skygen_0 => sram_mux,

   -- PS2      
    PS2_Clk_to_the_de2_ps2_1 => PS2_CLK,
    PS2_Data_to_the_de2_ps2_1 => PS2_DAT
  );


  V2: entity work.de2_vga_raster port map (
    reset 		=> '0',
    clk 		=> clk25,
	 bool    => boolOut,
    VGA_CLK 	=> VGA_CLK,
    VGA_HS 		=> VGA_HS,
    VGA_VS 		=> VGA_VS,
    VGA_BLANK 	=> VGA_BLANK,
	 VGA_BLANK_SIG => VGA_BLANK_SIG,
    VGA_SYNC 	=> VGA_SYNC,
    VGA_R 		=> VGA_R,
    VGA_G 		=> VGA_G,
    VGA_B 		=> VGA_B,
	 is_Side 	=> sideOut,
	 Row_Start 	=> unsigned(mem_out(25 downto 17)), 
	 Row_Mid    => unsigned(mem_out(186 downto 178)),
	 Row_End 	=> unsigned(mem_out(16 downto 8)), 
	 Col_Color_sky => unsigned(sky_out),    --Need to Modify
	 Col_Color 	=> tex_rom_out,
	 texNum     => texNumOut,
	 texNum2    => texNum2Out,
--	 Flr_Color	=> flr_rom_out,
	 Cur_Row		=> Cur_Row,
	 Cur_Col 	=> Cur_Col
  );
  
   V3: entity work.tex_gen port map (
    reset => '0',
    clk   => clk25,        -- Should be 50 MHz
	 --clk25 => clk25,
	 bool => mem_out(223),
	 boolOut => boolOut,
	 Cur_Row		=> "00" & Cur_Row_from_mem,
	 side1 => mem_out(63),
	 side2 => mem_out(62),
	 texNumOut => texNumOut,
	 texNum2Out => texNum2Out, 
	 texNum => unsigned(mem_out(227 downto 224)),
	 texNum2 => unsigned(mem_out(231 downto 228)),
	 line_minus_h  => signed(mem_out(61 downto 44)),
	 line_minus_h2  => signed(mem_out(222 downto 205)),
 	 invLineHeight => unsigned(mem_out(43 downto 26)),
	 invLineHeight2 => unsigned(mem_out(204 downto 187)),
	 texX				=> unsigned(mem_out(7 downto 2)),
	 texX2			=> unsigned(mem_out(177 downto 172)),
	 tex_addr_out	=> tex_addr,
	 sideOut   => sideOut,
	 Row_End 	=> unsigned(mem_out(16 downto 8)), 
	 Row_Mid    => unsigned(mem_out(186 downto 178)),
	 floorX				=> unsigned(mem_out(81 downto 64)),
	floorY				=> unsigned(mem_out(99 downto 82)),
	tmpPosX				=> unsigned(mem_out(117 downto 100)),
	tmpPosY				=> unsigned(mem_out(135 downto 118)),
	invDistWall			=> unsigned(mem_out(147 downto 136)),
	y						=> Cur_Row_from_mem(8 downto 0)

  );
  
   V4: entity work.texture_rom port map (
    --clk 		=> clk_sys,
	 tex_addr => tex_addr,
	 tex_data => tex_rom_out
	
  );
  
  V9: ENTITY work.FIFO port map(
		data		=> x"FFF" &
							"0" &
							VGA_BLANK_OUT &
							std_logic_vector (colAddrOut) &
							std_logic_vector(texNum2) &
							std_logic_vector(texNum) &
							bool &
							std_logic_vector(line_minus_h2(17 downto 0)) &
							std_logic_vector(invline2(17 downto 0)) &
							std_logic_vector(drawMid(8 downto 0)) &
							std_logic_vector(texX2(5 downto 0)) &
							"00" &
							std_LOGIC_VECTOR(data_out(169 downto 160)) & 
							x"FFF"  & 
							STD_LOGIC_VECTOR(invdist_out(11 downto 0)) &  
							STD_LOGIC_VECTOR(tmpPosY(17 downto 0)) & 
							STD_LOGIC_VECTOR(tmpPosX(17 downto 0)) & 
							STD_LOGIC_VECTOR(floorY(17 downto 0)) & 
							STD_LOGIC_VECTOR(floorX(17 downto 0)) & 
							isSide & isSide2 & 
							STD_LOGIC_VECTOR(line_minus_h(17 downto 0)) & 
							STD_LOGIC_VECTOR(invline(17 downto 0)) & 
							STD_LOGIC_VECTOR(drawStart(8 downto 0)) & 
							STD_LOGIC_VECTOR(drawEnd(8 downto 0)) & 
							STD_LOGIC_VECTOR(texX(5 downto 0)) & 
							"00",
		rdclk		=> clk25,
		rdreq		=> rdreq_sig,
		wrclk		=>  clk_sys,
		wrreq		=>  write_en,
		q		=> q_fifo,
		rdempty	 => rdempty_sig ,
		wrfull	=> wrfull_sig 
	);
	
	rdReqGen: process (rdempty_sig) 
	
	begin 
	
		rdreq_sig <= not rdempty_sig;
	
	end process rdReqGen;
	
  
  V5: entity work.memcustom port map (
		clock			=> clk25,
--		data			=> data_out,
		data			=> q_fifo,
		rdaddress 	=> Cur_Col,
		rd_req      => rdreq_sig,
--		wraddress	=> colAddrOut,
--		wraddress	=>  data_out(255 downto 246),
		--wren	 		=> write_en,
   	--VGA_BLANK   => VGA_BLANK_SIG,
		row_in      => cur_row,
		row_out     => cur_row_from_mem,
--		wren	 		=> ctrl,
		q				=> mem_out
	);
	
	
	 V6: entity work.framerate_calc port map (
		 clk   		=> clk_sys,       -- Should be 50 MHz
		 wr_addr 	=> unsigned(data_out(255 downto 246)),
		 
		 frame_rate	=> frame_rate
	);
	
		
--	V7: entity work.ray_FSM port map (
--				clk  			=> clk_sys,
--				VGA_BLANK   => VGA_BLANK_SIG,
--				control 		=> ctrl,
----				reset 		=> data_out(240),
--				posX 			=> unsigned(data_out(31 downto 0)),
--				posY 			=> unsigned(data_out(63 downto 32)),
--				countstep 	=> unsigned(data_out(95 downto 64)),
--				rayDirX 		=> signed(data_out(127 downto 96)),
--				rayDirY 		=> signed(data_out(159 downto 128)),
--				colAddrIn 	=> unsigned(data_out(255 downto 246)),
--				isSide		=> isSide,
--				texNum		=> texNum,
--				texX			=> texX,
--				floorX		=> floorX,
--				floorY		=> floorY,
--				tmpPosXout  => tmpPosX,
--				tmpPosYout  => tmpPosY,
--				countout		=> countout,
--				line_minus_h => line_minus_h,
--				invline      => invline,
--				invdist_out  => invdist_out,
--				drawStart    => drawStart,
--				drawEnd      => drawEnd,
--				colAddrOut   => colAddrOut,
--				state_out	 => state_out,
--				WE          => write_en,
--				ready 		=>	data_rdy
--	);
--	
	V8: entity work.ray_FSM port map (
				clk           => clk_sys,
				control       =>  ctrl,
				VGA_BLANK     => VGA_BLANK_SIG,
				VGA_BLANK_OUT => VGA_BLANK_OUT,
				wrfull	=> wrfull_sig ,
				posX 			  => unsigned(data_out(31 downto 0)),
				posY 			  => unsigned(data_out(63 downto 32)),
				countstep 	  => unsigned(data_out(95 downto 64)),
				rayDirX 		  => signed(data_out(127 downto 96)),
				rayDirY 		  => signed(data_out(159 downto 128)),
				colAddrIn 	  => unsigned(data_out(255 downto 246)),
				tmpPosXout    => tmpPosX,
				tmpPosYout    => tmpPosY,
				isSide        => isSide,
				isSide2       => isSide2,
				bool          => bool,
				texNum        => texNum,
				texNum2       => texNum2,
				texX          => texX,
				texX2         => texX2,
				floorX        => floorX,
				floorY        => floorY,
				countout		  => countout,
				countout2	  => countout2,
				line_minus_h  => line_minus_h,
				invline       => invline,
				line_minus_h2 => line_minus_h2,
				invline2      => invline2,
				invdist_out   => invdist_out,
				drawStart     => drawStart,
				drawMid       => drawMid,
				drawEnd       => drawEnd,
				colAddrOut    => colAddrOut,
				WE            => write_en,
				ready 		  => data_rdy,
				state_out     => state_out
				
);



--	V8: entity work.floorMod port map (
--			clk					=> clk_sys,
--			floorX				=> unsigned(mem_out(81 downto 64)),
--			floorY				=> unsigned(mem_out(99 downto 82)),
--			tmpPosX				=> unsigned(mem_out(117 downto 100)),
--			tmpPosY				=> unsigned(mem_out(135 downto 118)),
--			invDistWall			=> unsigned(mem_out(147 downto 136)),
--			y						=> Cur_Row(8 downto 0),
--			textureIndexOut	=> floor_pixel
--	);

  
  HEX7     <= "0001001"; -- Leftmost
  HEX6     <= "0000110";
  HEX5     <= "1000111";
  HEX4     <= "1000111";
  HEX3     <= "1000000";
  HEX2     <= (others => '1');
  HEX1     <= (others => '1');
  HEX0     <= (others => '1');          -- Rightmost
  LEDG     <= (others => '1');
  LEDR     <=  state_out & "000000";
  LCD_ON   <= '1';
  LCD_BLON <= '1';
  LCD_RW <= '1';
  LCD_EN <= '0';
  LCD_RS <= '0';

  SD_DAT3 <= '1';  
  SD_CMD <= '1';
  SD_CLK <= '1';

  UART_TXD <= '0';
  --DRAM_ADDR <= (others => '0');
  --DRAM_LDQM <= '0';
  --DRAM_UDQM <= '0';
  --DRAM_WE_N <= '1';
  --DRAM_CAS_N <= '1';
  --DRAM_RAS_N <= '1';
  --DRAM_CS_N <= '1';
  --DRAM_BA_0 <= '0';
  --DRAM_BA_1 <= '0';
  DRAM_CLK <= clk_dram;
  --DRAM_CKE <= '0';
  FL_ADDR <= (others => '0');
  FL_WE_N <= '1';
  FL_RST_N <= '0';
  FL_OE_N <= '1';
  FL_CE_N <= '1';
  OTG_ADDR <= (others => '0');
  OTG_CS_N <= '1';
  OTG_RD_N <= '1';
  OTG_RD_N <= '1';
  OTG_WR_N <= '1';
  OTG_RST_N <= '1';
  OTG_FSPEED <= '1';
  OTG_LSPEED <= '1';
  OTG_DACK0_N <= '1';
  OTG_DACK1_N <= '1';

  TDO <= '0';

  ENET_CMD <= '0';
  ENET_CS_N <= '1';
  ENET_WR_N <= '1';
  ENET_RD_N <= '1';
  ENET_RST_N <= '1';
  ENET_CLK <= '0';
  
  TD_RESET <= '0';
  
  I2C_SCLK <= '1';

  AUD_DACDAT <= '1';
  AUD_XCK <= '1';
  
  -- Set all bidirectional ports to tri-state
  DRAM_DQ     <= (others => 'Z');
  FL_DQ       <= (others => 'Z');
  SRAM_DQ     <= (others => 'Z');
  OTG_DATA    <= (others => 'Z');
  LCD_DATA    <= (others => 'Z');
  SD_DAT      <= 'Z';
  I2C_SDAT    <= 'Z';
  ENET_DATA   <= (others => 'Z');
  AUD_ADCLRCK <= 'Z';
  AUD_DACLRCK <= 'Z';
  AUD_BCLK    <= 'Z';
  GPIO_0      <= (others => 'Z');
  GPIO_1      <= (others => 'Z');

end datapath;
