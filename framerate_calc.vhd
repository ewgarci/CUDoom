-------------------------------------------------------------------------------
--
-- Frame Rate Calculation
--
-- Edward Garcia
-- ewg2115@columbia.edu
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity framerate_calc is
  
  port (
    clk   		 : in std_logic;                    -- Should be 50 MHz
	 wr_addr 	 : in unsigned (9 downto 0);
	 
	 frame_rate	: out unsigned (7 downto 0)
	 
    );

end framerate_calc;

architecture rtl of framerate_calc is

   constant CLOCK_1_SECOND       : integer := 50000000; -- 50MHz
	constant MAX_COLUMN       		: integer := 640; 

  -- Signals for the video controller
   signal frame_count : unsigned(7 downto 0) := "00000000";  -- Horizontal position (0-800)
   signal clk_count   : unsigned(25 downto 0) := (others => '0');  -- Vertical position (0-524)
	signal prev_wr_addr : unsigned(9 downto 0) := "0000000000"; 
	type states is (A, B, B2, C);	
	signal state : states := A;
  
begin

  frame_counter : process (clk, wr_addr)
  begin
  if rising_edge(clk) then
		clk_count <= clk_count + 1;
		prev_wr_addr <= wr_addr;
		
		case state is
			when A =>
				if clk_count = CLOCK_1_SECOND then
					state <= B;
				elsif wr_addr = MAX_COLUMN -1 then
					state <= C;
				else
					state <= A;
				end if;
				
			when B =>
				frame_rate <= frame_count;
				clk_count <= (others => '0');
				state <= B2;
				
			when B2 =>
				frame_count <= (others => '0');

				state <= A;	
				
			when C =>
				if wr_addr = MAX_COLUMN -1 then
					state <= C;
				else	
					frame_count <= frame_count + 1;
					state <= A;
				end if;
				
			when others =>
				state <= A;
				
			end case;
		end if;
  end process frame_counter;
  
  
end rtl;