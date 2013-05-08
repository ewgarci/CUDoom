library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memcustom is
	port
	(
		clock		: in std_logic  := '1';
		data		: in std_logic_vector (255 downto 0);
		rdaddress		: in unsigned(9 downto 0);
		wraddress		: in unsigned(9 downto 0);
		wren		: in std_logic  := '0';
		VGA_BLANK : in std_logic := '0';
		row_in  : in unsigned (9 downto 0);
		row_out : out unsigned (9 downto 0);
		
		q		: out std_logic_vector(255 downto 0)
	);
end memcustom;


architecture rtl of memcustom is

signal toggle : std_logic := '1';
signal blank_prev : std_logic := '0';
signal address_1_a : std_logic_vector (8 downto 0);
signal address_1_b : std_logic_vector (6 downto 0);
signal address_2_a : std_logic_vector (8 downto 0);
signal address_2_b : std_logic_vector (6 downto 0);
signal data_1_a : std_logic_vector (255 downto 0);
signal data_1_b : std_logic_vector (255 downto 0);
signal data_2_a : std_logic_vector (255 downto 0);
signal data_2_b : std_logic_vector (255 downto 0);
signal q_1_a : std_logic_vector (255 downto 0);
signal q_1_b : std_logic_vector (255 downto 0);
signal q_2_a : std_logic_vector (255 downto 0);
signal q_2_b : std_logic_vector (255 downto 0);
signal wren_1_a : std_logic;
signal wren_1_b : std_logic;
signal wren_2_a : std_logic;
signal wren_2_b : std_logic;
signal read_code : unsigned (1 downto 0); 

begin

   M0: entity work.mem_custom_2_a port map (
		address	=> address_1_a,
		clock		=> clock,
		data	 => data_1_a,
		wren	=>  wren_1_a,
		q	=>	q_1_a
  );
  
   M1: entity work.mem_custom_2_b port map (
		address	=> address_1_b,
		clock		=> clock,
		data	 => data_1_b,
		wren	=>  wren_1_b,
		q	=>	q_1_b
  );
  
   M3: entity work.mem_custom_2_a port map (
		address	=> address_2_a,
		clock		=> clock,
		data	 => data_2_a,
		wren	=>  wren_2_a,
		q	=>	q_2_a
  );

   M4: entity work.mem_custom_2_b port map (
	
		address		=> address_2_b,
		clock		=> clock,
		data		=> data_2_b,
		wren		=> wren_2_b,
		q		=>	q_2_b
  );

process (clock)

begin

if (rising_edge(clock)) then	
	blank_prev <= VGA_BLANK;
	
	if blank_prev = '0' and VGA_BLANK = '1' then
		toggle <= not toggle;
	end if;	
	
	--read_code
		--00 = 1_a
		--01 = 1_b
		--10 = 2_a
		--11 = 2_b
--	case read_code is
--		when "00" =>   q <= q_1_a;
--		when "01" =>   q <= q_1_b;
--		when "10" =>   q <= q_2_a;
--		when "11" =>   q <= q_2_b;
--		when others => q <= (others => '0');
--	end case;

	row_out <= row_in;
	
		
	if (toggle = '1') then
		if (rdaddress < "1000000000") then
			read_code <= "10";
		else
			read_code <= "11";
		end if;
	else
		if (rdaddress < "1000000000") then
			read_code <= "00";
		else
			read_code <= "01";
		end if;
	end if;
	
end if;	
	
end process;

-- MUX for address inputs and writes

process(toggle, wren, wraddress,rdaddress,data)


begin
	
data_1_a <= data;
data_1_b <= data;
data_2_a <= data;
data_2_b <= data;


if (toggle = '1') then

	if (wren = '1') then
		if (wraddress < "1000000000") then
			wren_1_a <= '1';
			wren_1_b <= '0';
		else
			wren_1_a <= '0';
			wren_1_b <= '1';
		end if;
	else
		wren_1_a <= '0';
		wren_1_b <= '0';
	end if;
	
	wren_2_a <= '0';
	wren_2_b <= '0'; 
	
	address_1_a <= std_logic_vector (wraddress(8 downto 0));
	address_1_b <= std_logic_vector (wraddress(6 downto 0));
	
	address_2_a <= std_logic_vector(rdaddress(8 downto 0));
	address_2_b <= std_logic_vector (rdaddress(6 downto 0));
else

	if (wren = '1') then
		if (wraddress < "1000000000") then
			wren_2_a <= '1';
			wren_2_b <= '0';
		else
			wren_2_a <= '0';
			wren_2_b <= '1';
		end if;
	else
		wren_2_a <= '0';
		wren_2_b <= '0';
	end if;
	
	wren_1_a <= '0';
	wren_1_b <= '0';
	
	address_2_a <= std_logic_vector(wraddress(8 downto 0));
	address_2_b <= std_logic_vector(wraddress(6 downto 0));
	
	address_1_a <= std_logic_vector(rdaddress(8 downto 0));
	address_1_b <= std_logic_vector(rdaddress(6 downto 0));
	
end if;	

end process;


-- MUX for output read

process (read_code,q_1_a,q_1_b,q_2_a,q_2_b)

begin

	case read_code is
		when "00" =>   q <= q_1_a;
		when "01" =>   q <= q_1_b;
		when "10" =>   q <= q_2_a;
		when "11" =>   q <= q_2_b;
		when others => q <= (others => '0');
	end case;

end process;


--asynchronous read
--process (rdaddress,toggle)
--begin	
--
--end process;

end rtl;
