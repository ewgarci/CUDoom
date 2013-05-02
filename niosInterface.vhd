library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity niosInterface is
  
  port (
    clk        : in  std_logic;
    reset_n    : in  std_logic;
    read       : in  std_logic;
    write      : in  std_logic;
    chipselect : in  std_logic;
    address    : in  std_logic_vector(4 downto 0);

    readdata   : out std_logic_vector(31 downto 0);
    writedata  : in  std_logic_vector(31 downto 0);

    hardware_data : in std_logic_vector(31 downto 0);
    ctrl          : out std_logic;
    nios_data     : out std_logic_vector(255 downto 0)
    
    );
  
end niosInterface;

architecture rtl of niosInterface is

signal control_store : std_logic := '0' ;


begin

  process (clk)
  begin
    if rising_edge(clk) then
      ctrl <= control_store;
      if reset_n = '0' then
        readdata <= (others => '0');
	control_store <= '0';      
      else
        if chipselect = '1' then
				if read = '1' then
					readdata <= hardware_data;
				elsif write = '1' then
						case address is
							when "00000" =>
								control_store <= writedata(0);
							when "00001" =>
								nios_data(31 downto 0) <= (writedata (31 downto 0));
							when "00010" =>
								nios_data(63 downto 32) <= (writedata (31 downto 0));
							when "00011" =>
								nios_data(95 downto 64) <= (writedata (31 downto 0));
							when "00100" =>
								nios_data(127 downto 96) <= (writedata (31 downto 0));
							when "00101" =>
								nios_data(159 downto 128) <= (writedata (31 downto 0));
							when "00110" =>
								nios_data(191 downto 160) <= (writedata (31 downto 0));
							when "00111" =>
								nios_data(223 downto 192) <= (writedata (31 downto 0));
							when "01000" =>
								nios_data(255 downto 224) <= (writedata (31 downto 0));
							when others =>
								control_store <= '0';
						end case;
				end if;
			end if;
		end if;
	end if;
  end process;

end rtl;


