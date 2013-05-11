-------------------------------------------------------------------------------
--
-- Sky Generation
--
-- Wei-Hao, 
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity skygen is
  
  port (
    signal reset_n : in std_logic;
    signal clk   : in std_logic;                    -- Should be 50 MHz

   signal read       : in  std_logic;
   signal write      : in  std_logic;
   signal chipselect : in  std_logic;
   signal address    : in  std_logic_vector(17 downto 0);
   signal readdata   : out std_logic_vector(15 downto 0);
   signal writedata  : in  std_logic_vector(15 downto 0);
   signal byteenable : in std_logic_vector(1 downto 0);

    signal SRAM_DQ : inout std_logic_vector(15 downto 0);
    signal SRAM_ADDR : out std_logic_vector(17 downto 0);
    signal SRAM_UB_N, SRAM_LB_N : out std_logic;
    signal SRAM_WE_N, SRAM_CE_N : out std_logic;
    signal SRAM_OE_N            : out std_logic;

	 signal Cur_Row_in 	 : in std_logic_vector (9 downto 0);	 
	 signal FB_angle_in        : in std_logic_vector (9 downto 0);
	 signal Sky_pixel	 : out std_logic_vector (7 downto 0);
         signal Sram_mux_out         : out std_logic                   
	 
    );

end skygen;

ARCHITECTURE SYN OF skygen IS

        SIGNAL	sram_mux                : std_logic;
--	SIGNAL	cpu_data		: STD_LOGIC_VECTOR (15 DOWNTO 0);
--	SIGNAL	cpu_addr		: STD_LOGIC_VECTOR (16 DOWNTO 0) ;
--      SIGNAL  cpu_ub, cpu_lb;
--      SIGNAL  cpu_we, cpu_ce, cpu_oe;

	SIGNAL  Cur_Row                 : unsigned (9 downto 0);
        SIGNAL  FB_angle                : unsigned (9 downto 0);

	SIGNAL  vga_addr_lsb            : std_logic;   
	SIGNAL  vga_addr_tmp		: unsigned (18 downto 0) ;
	SIGNAL  vga_addr		: STD_LOGIC_VECTOR (17 downto 0) ;
  
BEGIN
  -- Communicate with MEM
  MEM : process (clk)
  begin
  if rising_edge (clk) then
	if reset_n = '0' then
                sram_mux <= '0';                 
	else
		if chipselect = '1' then
			if write = '1' then
				if address = "111111111111111111" then
					sram_mux <= writedata (0);
				end if;
			end if;		
		end if;
	end if;
  end if;
  end process MEM;

        Cur_Row <=  unsigned(Cur_Row_in(9 downto 0));
        FB_angle <= unsigned(FB_angle_in(9 downto 0)); 

	addrGen : process (clk)
	begin
		if rising_edge(clk) then
			vga_addr_tmp <= Cur_Row(9 downto 0)&"000000000" + (FB_angle srl 1);
                        vga_addr_lsb <= vga_addr_tmp(0);
		end if;
	end process addrGen;

  vga_addr <= std_logic_vector(vga_addr_tmp(17 downto 0));


  SRAM_DQ <= writedata when write = '1' and sram_mux = '0' else
               (others => 'Z');

  SRAM_ADDR <= address           when sram_mux = '0' else
               vga_addr          when sram_mux = '1' else     
               (others => '0');

  SRAM_UB_N <= not byteenable(1) when sram_mux = '0' else
              '0';

  SRAM_LB_N <= not byteenable(0) when sram_mux = '0' else
              '0';

  SRAM_WE_N <= not write         when sram_mux = '0' else
              '1';                
  SRAM_CE_N <= not chipselect    when sram_mux = '0' else
              '0'; 
  SRAM_OE_N <= not read          when sram_mux = '0' else
              '0';
  
  readdata <=  SRAM_DQ;

  Sky_pixel<=  (SRAM_DQ(7 downto 0)) when vga_addr_lsb = '0' else
               (SRAM_DQ(15 downto 8));  

  Sram_mux_out <= sram_mux;

END SYN;
