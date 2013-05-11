-- skygen_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity skygen_0 is
	port (
		clk          : in    std_logic                     := '0';             --          clock.clk
		reset_n      : in    std_logic                     := '0';             --    clock_reset.reset_n
		read         : in    std_logic                     := '0';             -- avalon_slave_0.read
		write        : in    std_logic                     := '0';             --               .write
		chipselect   : in    std_logic                     := '0';             --               .chipselect
		address      : in    std_logic_vector(17 downto 0) := (others => '0'); --               .address
		readdata     : out   std_logic_vector(15 downto 0);                    --               .readdata
		writedata    : in    std_logic_vector(15 downto 0) := (others => '0'); --               .writedata
		byteenable   : in    std_logic_vector(1 downto 0)  := (others => '0'); --               .byteenable
		SRAM_DQ      : inout std_logic_vector(15 downto 0) := (others => '0'); --    conduit_end.export
		SRAM_ADDR    : out   std_logic_vector(17 downto 0);                    --               .export
		SRAM_UB_N    : out   std_logic;                                        --               .export
		SRAM_LB_N    : out   std_logic;                                        --               .export
		SRAM_WE_N    : out   std_logic;                                        --               .export
		SRAM_CE_N    : out   std_logic;                                        --               .export
		SRAM_OE_N    : out   std_logic;                                        --               .export
		Cur_Row_in   : in    std_logic_vector(9 downto 0)  := (others => '0'); --               .export
		FB_angle_in  : in    std_logic_vector(9 downto 0)  := (others => '0'); --               .export
		Sky_pixel    : out   std_logic_vector(7 downto 0);                     --               .export
		Sram_mux_out : out   std_logic                                         --               .export
	);
end entity skygen_0;

architecture rtl of skygen_0 is
	component skygen is
		port (
			clk          : in    std_logic                     := 'X';             -- clk
			reset_n      : in    std_logic                     := 'X';             -- reset_n
			read         : in    std_logic                     := 'X';             -- read
			write        : in    std_logic                     := 'X';             -- write
			chipselect   : in    std_logic                     := 'X';             -- chipselect
			address      : in    std_logic_vector(17 downto 0) := (others => 'X'); -- address
			readdata     : out   std_logic_vector(15 downto 0);                    -- readdata
			writedata    : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			byteenable   : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			SRAM_DQ      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
			SRAM_ADDR    : out   std_logic_vector(17 downto 0);                    -- export
			SRAM_UB_N    : out   std_logic;                                        -- export
			SRAM_LB_N    : out   std_logic;                                        -- export
			SRAM_WE_N    : out   std_logic;                                        -- export
			SRAM_CE_N    : out   std_logic;                                        -- export
			SRAM_OE_N    : out   std_logic;                                        -- export
			Cur_Row_in   : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			FB_angle_in  : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			Sky_pixel    : out   std_logic_vector(7 downto 0);                     -- export
			Sram_mux_out : out   std_logic                                         -- export
		);
	end component skygen;

begin

	skygen_0 : component skygen
		port map (
			clk          => clk,          --          clock.clk
			reset_n      => reset_n,      --    clock_reset.reset_n
			read         => read,         -- avalon_slave_0.read
			write        => write,        --               .write
			chipselect   => chipselect,   --               .chipselect
			address      => address,      --               .address
			readdata     => readdata,     --               .readdata
			writedata    => writedata,    --               .writedata
			byteenable   => byteenable,   --               .byteenable
			SRAM_DQ      => SRAM_DQ,      --    conduit_end.export
			SRAM_ADDR    => SRAM_ADDR,    --               .export
			SRAM_UB_N    => SRAM_UB_N,    --               .export
			SRAM_LB_N    => SRAM_LB_N,    --               .export
			SRAM_WE_N    => SRAM_WE_N,    --               .export
			SRAM_CE_N    => SRAM_CE_N,    --               .export
			SRAM_OE_N    => SRAM_OE_N,    --               .export
			Cur_Row_in   => Cur_Row_in,   --               .export
			FB_angle_in  => FB_angle_in,  --               .export
			Sky_pixel    => Sky_pixel,    --               .export
			Sram_mux_out => Sram_mux_out  --               .export
		);

end architecture rtl; -- of skygen_0
