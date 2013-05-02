-- memory256_16_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory256_16_0 is
	port (
		clk        : in  std_logic                      := '0';             --          clock.clk
		reset_n    : in  std_logic                      := '0';             --          reset.reset_n
		read       : in  std_logic                      := '0';             -- avalon_slave_0.read
		write      : in  std_logic                      := '0';             --               .write
		chipselect : in  std_logic                      := '0';             --               .chipselect
		address    : in  std_logic_vector(4 downto 0)   := (others => '0'); --               .address
		readdata   : out std_logic_vector(15 downto 0);                     --               .readdata
		writedata  : in  std_logic_vector(15 downto 0)  := (others => '0'); --               .writedata
		rdaddress  : in  std_logic_vector(9 downto 0)   := (others => '0'); --    conduit_end.export
		q          : out std_logic_vector(255 downto 0)                     --  conduit_end_1.export
	);
end entity memory256_16_0;

architecture rtl of memory256_16_0 is
	component memory256_16 is
		port (
			clk        : in  std_logic                      := 'X';             -- clk
			reset_n    : in  std_logic                      := 'X';             -- reset_n
			read       : in  std_logic                      := 'X';             -- read
			write      : in  std_logic                      := 'X';             -- write
			chipselect : in  std_logic                      := 'X';             -- chipselect
			address    : in  std_logic_vector(4 downto 0)   := (others => 'X'); -- address
			readdata   : out std_logic_vector(15 downto 0);                     -- readdata
			writedata  : in  std_logic_vector(15 downto 0)  := (others => 'X'); -- writedata
			rdaddress  : in  std_logic_vector(9 downto 0)   := (others => 'X'); -- export
			q          : out std_logic_vector(255 downto 0)                     -- export
		);
	end component memory256_16;

begin

	memory256_16_0 : component memory256_16
		port map (
			clk        => clk,        --          clock.clk
			reset_n    => reset_n,    --          reset.reset_n
			read       => read,       -- avalon_slave_0.read
			write      => write,      --               .write
			chipselect => chipselect, --               .chipselect
			address    => address,    --               .address
			readdata   => readdata,   --               .readdata
			writedata  => writedata,  --               .writedata
			rdaddress  => rdaddress,  --    conduit_end.export
			q          => q           --  conduit_end_1.export
		);

end architecture rtl; -- of memory256_16_0
