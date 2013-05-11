library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mod_tb is
end mod_tb;

architecture tb of mod_tb is

signal clk : std_logic := '0';
signal control: std_logic := '0';
signal ready : std_logic := '0';
signal WE :  std_logic := '0';
signal reset : std_logic := '0';
signal bool : std_logic := '0';

signal posX : unsigned(31 downto 0) := x"03a4b84a";
signal posY : unsigned (31 downto 0) := x"0539b4aa";

signal tmpPosX : unsigned(31 downto 0) := x"00000000";
signal tmpPosY : unsigned (31 downto 0) := x"00000000";

signal rayDirX : signed (31 downto 0) := x"0001ddda";
signal rayDirY : signed (31 downto 0) := x"fffc7655";

signal countstep : unsigned (31 downto 0) := x"00000000";

signal colAddrIn : unsigned (9 downto 0) := "01" & x"6e";
signal colAddrOut : unsigned  (9 downto 0) := "0000000000";

signal isSide	: std_logic := '0' ;
signal isSide2	: std_logic := '0' ;
signal texNum	: unsigned (3 downto 0):= (others=> '0') ;
signal texNum2	: unsigned (3 downto 0):= (others=> '0') ;
signal texX		: unsigned (31 downto 0):= (others=> '0') ;
signal texX2		: unsigned (31 downto 0):= (others=> '0') ;
signal floorX	: unsigned (31 downto 0):= (others=> '0') ;
signal floorY	: unsigned (31 downto 0):= (others=> '0') ;

signal line_minus_h : unsigned (31 downto 0);
signal invline      : unsigned (31 downto 0);
signal line_minus_h2 : unsigned (31 downto 0);
signal invline2     : unsigned (31 downto 0);

signal invdist_out  : unsigned (31 downto 0);
signal drawStart    : unsigned (31 downto 0);
signal drawMid    : unsigned (31 downto 0);
signal drawEnd      : unsigned (31 downto 0);

signal countfinal : unsigned (31 downto 0):= (others=> '0') ;
signal countfinal2 : unsigned (31 downto 0):= (others=> '0') ;


component ray_FSM

	port (clk 			: in  std_logic;
			control		: in std_logic;
			reset 		: in std_logic;
			posX 			: in unsigned(31 downto 0);
			posY 			: in  unsigned (31 downto 0);
			countstep 	: in unsigned (31 downto 0);
			colAddrIn 	: in unsigned (9 downto 0);
			rayDirX 		: in signed (31 downto 0);
			rayDirY 		: in signed (31 downto 0);
			tmpPosXout  : out unsigned (31 downto 0);
			tmpPosYout  : out unsigned (31 downto 0);
			isSide		: out std_logic;
			isSide2     : out std_logic;
			bool        : out std_logic;
			texNum		: out unsigned (3 downto 0);
			texNum2     : out unsigned (3 downto 0);
			texX			: out unsigned (31 downto 0);
			texX2        : out unsigned (31 downto 0);
			floorX		: out unsigned (31 downto 0);
			floorY		: out unsigned (31 downto 0);
			countout		: out unsigned (31 downto 0);
			countout2   : out unsigned (31 downto 0);
			line_minus_h: out unsigned (31 downto 0);
			invline     : out unsigned (31 downto 0);
			line_minus_h2: out unsigned (31 downto 0);
			invline2    : out unsigned (31 downto 0);
			invdist_out : out unsigned (31 downto 0);
			drawStart   : out unsigned (31 downto 0);
			drawMid     : out unsigned (31 downto 0);
			drawEnd     : out unsigned (31 downto 0);
			colAddrOut  : out unsigned (9 downto 0);
			WE          : out std_logic;
			ready 		: out std_logic
);

end component;

begin
clk <= not clk after 10 ns;

process
begin

wait for 1 us;
control <= '1';
wait for 20 us;
		if (isSide = '1') then
			report "side: success" severity note;
		else
			report "side: error" severity error;
		end if;
		
		if (isSide2 = '0') then
			report "side2: success" severity note;
		else
			report "side2: error" severity error;
		end if;
		
		if (bool = '0') then
			report "bool: success" severity note;
		else
			report "bool: error" severity error;
		end if;
		
		if (colAddrOut = "0000000110") then
			report "colAddress: success" severity note;
		else
			report "colAddress: error" severity error;
		end if;
		
		if (countfinal = x"00400eb1") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (countfinal2 = x"00400eb1") then
			report "count2: success" severity note;
		else
			report "count2: error" severity error;
		end if;
		
		if (texNum = x"00000002") then
			report "texNum: success" severity note;
		else
			report "texNum: error" severity error;
		end if;
		
		if (texNum2 = x"00000001") then
			report "texNum2: success" severity note;
		else
			report "texNum2: error" severity error;
		end if;
		
		if (texX = x"00000021") then
			report "texX: success" severity note;
		else
			report "texX: error" severity error;
		end if;
		
		if (texX2 = x"00000021") then
			report "texX2: success" severity note;
		else
			report "texX2: error" severity error;
		end if;
		
	   if (floorX = x"00006000") then
			report "floorX: success" severity note;
		else
			report "floorX: error" severity error;
		end if;
		
		if (floorY = x"000067a5") then
			report "floorY: success" severity note;
		else
			report "floorY: error" severity error;
		end if;
		
		if (tmpPosX = x"00005000") then
			report "tmpPosX: success" severity note;
		else
			report "tmpPosX: error" severity error;
		end if;
		
		if (tmpPosY = x"00007000") then
			report "tmpPosY: success" severity note;
		else
			report "tmpPosY: error" severity error;
		end if;
		
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawMid = x"00000000") then
			report "drawMid: success" severity note;
		else
			report "drawMid: error" severity error;
		end if;
		
		if (drawEnd = x"000001df") then
			report "drawEnd: success" severity note;
		else
			report "drawEnd: error" severity error;
		end if;
		
		if (invline = x"00001114") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h = x"ffffffff") then
			report "line_minus_h: success" severity note;
		else
			report "line_minus_h: error" severity error;
		end if;
		
		if (invline2 = x"00001114") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h2 = x"ffffffff") then
			report "line_minus_h2: success" severity note;
		else
			report "line_minus_h2: error" severity error;
		end if;
		
		if (invdist_out = x"00000ffd") then
			report "invdist_out: success" severity note;
		else
			report "invdist_out: error" severity error;
		end if;
		
wait for 1 us;
rayDirX <= x"0001df3e";
rayDirY <= x"fffc7711";
countstep <= x"fff3fd48";
colAddrIn <=  "01" & x"6f";
control <= '0';
wait for 5 us;
		if (isSide = '1') then
			report "side: success" severity note;
		else
			report "side: error" severity error;
		end if;
		
		if (isSide2 = '1') then
			report "side2: success" severity note;
		else
			report "side2: error" severity error;
		end if;
		
		if (colAddrOut = "0000000110") then
			report "colAddress: success" severity note;
		else
			report "colAddress: error" severity error;
		end if;
		
		if (countfinal = x"00400eb1") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (countfinal2 = x"00400eb1") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (texNum = x"00000011") then
			report "texNum: success" severity note;
		else
			report "texNum: error" severity error;
		end if;
		
		if (texNum2 = x"00000011") then
			report "texNum2: success" severity note;
		else
			report "texNum2: error" severity error;
		end if;
		
		if (texX = x"00000021") then
			report "texX: success" severity note;
		else
			report "texX: error" severity error;
		end if;
		
		if (texX2 = x"00000021") then
			report "texX2: success" severity note;
		else
			report "texX2: error" severity error;
		end if;
		
	   if (floorX = x"00006000") then
			report "floorX: success" severity note;
		else
			report "floorX: error" severity error;
		end if;
		
		if (floorY = x"000067a5") then
			report "floorY: success" severity note;
		else
			report "floorY: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawMid = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawEnd = x"000001df") then
			report "drawEnd: success" severity note;
		else
			report "drawEnd: error" severity error;
		end if;
		
		if (invline = x"00001114") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h = x"ffffffff") then
			report "line_minus_h: success" severity note;
		else
			report "line_minus_h: error" severity error;
		end if;
		
		if (invline2 = x"00001114") then
			report "invLine2: success" severity note;
		else
			report "invLine2: error" severity error;
		end if;
		
		if (line_minus_h2 = x"ffffffff") then
			report "line_minus_h2: success" severity note;
		else
			report "line_minus_h2: error" severity error;
		end if;
		
		if (invdist_out = x"00000ffd") then
			report "invdist_out: success" severity note;
		else
			report "invdist_out: error" severity error;
		end if;
		
wait for 1 us;

control <= '1';
wait for 20 us;

		if (isSide = '1') then
			report "side: success" severity note;
		else
			report "side: error" severity error;
		end if;
		
		if (isSide2 = '1') then
			report "side2: success" severity note;
		else
			report "side2: error" severity error;
		end if;
		
		if (colAddrOut = "0000000111") then
			report "colAddress: success" severity note;
		else
			report "colAddress: error" severity error;
		end if;
		
		if (countfinal = x"00401b35") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (countfinal2 = x"00401b35") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (texNum = x"00000011") then
			report "texNum: success" severity note;
		else
			report "texNum: error" severity error;
		end if;
		
		if (texNum2 = x"00000011") then
			report "texNum2: success" severity note;
		else
			report "texNum2: error" severity error;
		end if;
		
		if (texX = x"00000021") then
			report "texX: success" severity note;
		else
			report "texX: error" severity error;
		end if;
		
		if (texX2 = x"00000021") then
			report "texX2: success" severity note;
		else
			report "texX2: error" severity error;
		end if;
		
	   if (floorX = x"00006000") then
			report "floorX: success" severity note;
		else
			report "floorX: error" severity error;
		end if;
		
		if (floorY = x"000067a5") then
			report "floorY: success" severity note;
		else
			report "floorY: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawMid = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawEnd = x"000001df") then
			report "drawEnd: success" severity note;
		else
			report "drawEnd: error" severity error;
		end if;
		
		if (invline = x"00001118") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h = x"ffffffff") then
			report "line_minus_h: success" severity note;
		else
			report "line_minus_h: error" severity error;
		end if;
		
		if (invline2 = x"00001118") then
			report "invLine2: success" severity note;
		else
			report "invLine2: error" severity error;
		end if;
		
		if (line_minus_h2 = x"ffffffff") then
			report "line_minus_h2: success" severity note;
		else
			report "line_minus_h2: error" severity error;
		end if;
		
		if (invdist_out = x"00000ffa") then
			report "invdist_out: success" severity note;
		else
			report "invdist_out: error" severity error;
		end if;
		
wait for 1 us;
rayDirX <= x"0001e0a1";
rayDirY <= x"fffc77cd";
countstep <= x"0003fd2a";
colAddrIn <=  "01" & x"70";
control <= '0';
--reset <= '1';
control <= '0';
wait for 6 us;

		if (isSide = '1') then
			report "side: success" severity note;
		else
			report "side: error" severity error;
		end if;
		
		if (isSide2 = '1') then
			report "side2: success" severity note;
		else
			report "side2: error" severity error;
		end if;
		
		if (colAddrOut = "0000000111") then
			report "colAddress: success" severity note;
		else
			report "colAddress: error" severity error;
		end if;
		
		if (countfinal = x"00401b35") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (countfinal2 = x"00401b35") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (texNum = x"00000011") then
			report "texNum: success" severity note;
		else
			report "texNum: error" severity error;
		end if;
		
		if (texNum2 = x"00000011") then
			report "texNum2: success" severity note;
		else
			report "texNum2: error" severity error;
		end if;
		
		if (texX = x"00000021") then
			report "texX: success" severity note;
		else
			report "texX: error" severity error;
		end if;
		
		if (texX2 = x"00000021") then
			report "texX2: success" severity note;
		else
			report "texX2: error" severity error;
		end if;
		
	   if (floorX = x"00006000") then
			report "floorX: success" severity note;
		else
			report "floorX: error" severity error;
		end if;
		
		if (floorY = x"000067a5") then
			report "floorY: success" severity note;
		else
			report "floorY: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawStart = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawMid = x"00000000") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawEnd = x"000001df") then
			report "drawEnd: success" severity note;
		else
			report "drawEnd: error" severity error;
		end if;
		
		if (invline = x"00001118") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h = x"ffffffff") then
			report "line_minus_h: success" severity note;
		else
			report "line_minus_h: error" severity error;
		end if;
		
		if (invline2 = x"00001118") then
			report "invLine2: success" severity note;
		else
			report "invLine2: error" severity error;
		end if;
		
		if (line_minus_h2 = x"ffffffff") then
			report "line_minus_h2: success" severity note;
		else
			report "line_minus_h2: error" severity error;
		end if;
		
		if (invdist_out = x"00000ffa") then
			report "invdist_out: success" severity note;
		else
			report "invdist_out: error" severity error;
		end if;
		
wait for 60 ns;
--reset <= '0';
control <= '1';
wait for 6 us;

		if (isSide = '1') then
			report "side: success" severity note;
		else
			report "side: error" severity error;
		end if;
		
		if (colAddrOut = "0101000111") then
			report "colAddress: success" severity note;
		else
			report "colAddress: error" severity error;
		end if;
		
		if (countfinal = x"00403e75") then
			report "count: success" severity note;
		else
			report "count: error" severity error;
		end if;
		
		if (texNum = x"00000000") then
			report "texNum: success" severity note;
		else
			report "texNum: error" severity error;
		end if;
		
		if (texX = x"0000001f") then
			report "texX: success" severity note;
		else
			report "texX: error" severity error;
		end if;
		
	   if (floorX = x"05c00000") then
			report "floorX: success" severity note;
		else
			report "floorX: error" severity error;
		end if;
		
		if (floorY = x"02e0deba") then
			report "floorY: success" severity note;
		else
			report "floorY: error" severity error;
		end if;
		
		if (drawStart = x"00000001") then
			report "drawStart: success" severity note;
		else
			report "drawStart: error" severity error;
		end if;
		
		if (drawEnd = x"000001df") then
			report "drawEnd: success" severity note;
		else
			report "drawEnd: error" severity error;
		end if;
		
		if (invline = x"00002243") then
			report "invLine: success" severity note;
		else
			report "invLine: error" severity error;
		end if;
		
		if (line_minus_h = x"fffffffe") then
			report "line_minus_h: success" severity note;
		else
			report "line_minus_h: error" severity error;
		end if;
		
		if (invdist_out = x"00000ff1") then
			report "invdist_out: success" severity note;
		else
			report "invdist_out: error" severity error;
		end if;
		
wait;
end process;

ray_tb: ray_FSM port map (
	clk => clk,
	control => control,
	bool => bool,
	posX => posX,
	posY => posY,
	tmpPosXout => tmpPosX,
	tmpPosYout => tmpPosY,
	countstep => countstep,
	rayDirX => rayDirX,
	rayDirY => rayDirY,
	isSide => isSide,
	isSide2 => isSide2,
	texNum => texNum,
	texNum2 => texNum2,
	texX => texX,
	texX2 => texX2,
	floorX => floorX,
	floorY => floorY,
	
	line_minus_h => line_minus_h,
	line_minus_h2 => line_minus_h2,
	invline      => invline,
	invline2      => invline2,
	invdist_out  => invdist_out,
	drawStart  => drawStart,
	drawMid  => drawMid,
	drawEnd  => drawEnd,
	colAddrIn => colAddrIn,
	colAddrOut => colAddrOut,
	ready => ready,
	WE => WE,
	reset => reset,
	countout	=> countfinal,
   countout2 => countfinal2
	);

end tb;





