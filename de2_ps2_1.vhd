-- de2_ps2_1.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity de2_ps2_1 is
	port (
		clk        : in  std_logic                    := '0'; --          clock.clk
		reset      : in  std_logic                    := '0'; --          reset.reset
		address    : in  std_logic                    := '0'; -- avalon_slave_0.address
		read       : in  std_logic                    := '0'; --               .read
		chipselect : in  std_logic                    := '0'; --               .chipselect
		readdata   : out std_logic_vector(7 downto 0);        --               .readdata
		PS2_Clk    : in  std_logic                    := '0'; --    conduit_end.export
		PS2_Data   : in  std_logic                    := '0'  --               .export
	);
end entity de2_ps2_1;

architecture rtl of de2_ps2_1 is
	component de2_ps2 is
		port (
			clk        : in  std_logic                    := 'X'; -- clk
			reset      : in  std_logic                    := 'X'; -- reset
			address    : in  std_logic                    := 'X'; -- address
			read       : in  std_logic                    := 'X'; -- read
			chipselect : in  std_logic                    := 'X'; -- chipselect
			readdata   : out std_logic_vector(7 downto 0);        -- readdata
			PS2_Clk    : in  std_logic                    := 'X'; -- export
			PS2_Data   : in  std_logic                    := 'X'  -- export
		);
	end component de2_ps2;

begin

	de2_ps2_1 : component de2_ps2
		port map (
			clk        => clk,        --          clock.clk
			reset      => reset,      --          reset.reset
			address    => address,    -- avalon_slave_0.address
			read       => read,       --               .read
			chipselect => chipselect, --               .chipselect
			readdata   => readdata,   --               .readdata
			PS2_Clk    => PS2_Clk,    --    conduit_end.export
			PS2_Data   => PS2_Data    --               .export
		);

end architecture rtl; -- of de2_ps2_1
