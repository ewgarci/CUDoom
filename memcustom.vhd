library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memcustom is
	port
	(
		clock		: in std_logic  := '1';
		data		: in std_logic_vector (255 downto 0);
		rdaddress		: in unsigned(9 downto 0);
		--wraddress	: in unsigned(9 downto 0);
		--wren		: in std_logic  := '0';
		rd_req : in std_logic := '0' ;
		VGA_BLANK : in std_logic := '0';
		row_in  : in unsigned (9 downto 0);
		row_out : out unsigned (9 downto 0);
		
		q		: out std_logic_vector(255 downto 0)
	);
end memcustom;


architecture rtl of memcustom is

signal toggle : std_logic := '1';
signal blank_prev : std_logic := '0';
signal wren : std_logic  := '0';

signal wraddress : unsigned(9 downto 0);
signal address_1_a : std_logic_vector (8 downto 0);
signal address_1_b : std_logic_vector (6 downto 0);
signal address_2_a : std_logic_vector (8 downto 0);
signal address_2_b : std_logic_vector (6 downto 0);
signal address_patch_1 : std_logic_vector (5 downto 0);
signal address_patch_2 : std_logic_vector (5 downto 0);

signal data_1_a : std_logic_vector (255 downto 0);
signal data_1_b : std_logic_vector (255 downto 0);
signal data_2_a : std_logic_vector (255 downto 0);
signal data_2_b : std_logic_vector (255 downto 0);
signal data_patch_1 : std_logic_vector (255 downto 0);
signal data_patch_2 : std_logic_vector (255 downto 0);

signal q_1_a : std_logic_vector (255 downto 0);
signal q_1_b : std_logic_vector (255 downto 0);
signal q_2_a : std_logic_vector (255 downto 0);
signal q_2_b : std_logic_vector (255 downto 0);
signal q_patch_1 : std_logic_vector (255 downto 0);
signal q_patch_2 : std_logic_vector (255 downto 0);

signal wren_1_a : std_logic;
signal wren_1_b : std_logic;
signal wren_2_a : std_logic;
signal wren_2_b : std_logic;
signal wren_patch_1 : std_logic;
signal wren_patch_2 : std_logic; 

type read_codes is (A, B, C, D, E , F);
signal read_code : read_codes;


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
	
	M5: entity work.mem_patch_2 port map(
	
		address		=> address_patch_1,
		clock		=> clock,
		data		=> data_patch_1,
		wren		=> wren_patch_1,
		q		=>	q_patch_1
	
  );
  
  	M6: entity work.mem_patch_2 port map(
		address		=> address_patch_2,
		clock		=> clock,
		data => data_patch_2,
		wren => wren_patch_2,
		q		=>	q_patch_2
	
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
--		when A =>   q <= q_1_a;
--		when B =>   q <= q_1_b;
--		when C =>   q <= q_2_a;
--		when D =>   q <= q_2_b;
--    when E =>   q <= q_patch_1;
--    when F =>   q <= q_patch_2;
--		when others => q <= (others => '0');
--	end case;

	row_out <= row_in;
	
	if (rd_req = '1') then
		wren <= '1';
	else
		wren <= '0';
	end if;
	
	
	if (toggle = '1') then
		if (rdaddress < "0111110000") then
			read_code <= C;
		elsif (rdaddress >= "1000010000") then
			read_code <= D;
		else
			read_code <= F;
		end if;
	else
		if (rdaddress < "0111110000") then
			read_code <= A;
		elsif (rdaddress >= "1000010000") then
			read_code <= B;
		else
			read_code <= E;
		end if;
	end if;

	
end if;	
	
end process;

-- MUX for address inputs and writes
--
process (data)
begin
	wraddress <= unsigned(data(241 downto 232));
end process;

process(toggle, wren, wraddress,rdaddress,data)

begin
	
	data_1_a <= data;
	data_1_b <= data;
	data_2_a <= data;
	data_2_b <= data;
	data_patch_1 <= data;
	data_patch_2 <= data;

	if (toggle = '1') then

		if (wren = '1') then
			if (wraddress < "0111111110") then
				wren_1_a <= '1';
				wren_1_b <= '0';
			elsif (wraddress >= "1000000010") then
				wren_1_a <= '0';
				wren_1_b <= '1';
			else
				wren_1_a <= '0';
				wren_1_b <= '0';
			end if;
			
			if (wraddress >= "0111100010" and wraddress < "1000011110" ) then
				wren_patch_1 <= '1';
			else
				wren_patch_1 <= '0';
			end if;
			
		else
			wren_1_a <= '0';
			wren_1_b <= '0';
			wren_patch_1 <= '0';
		end if;
		
		wren_2_a <= '0';
		wren_2_b <= '0'; 
		wren_patch_2 <= '0';
		
		
		address_1_a <= std_logic_vector (wraddress(8 downto 0));
		address_1_b <= std_logic_vector (wraddress(6 downto 0));
		address_patch_1 <= std_logic_vector (wraddress(5 downto 0));
		
		address_2_a <= std_logic_vector(rdaddress(8 downto 0));
		address_2_b <= std_logic_vector (rdaddress(6 downto 0));
		address_patch_2 <= std_logic_vector (rdaddress(5 downto 0));
		
	else

		if (wren = '1') then
			if (wraddress < "0111111110") then
				wren_2_a <= '1';
				wren_2_b <= '0';
			elsif (wraddress >= "1000000010") then
				wren_2_a <= '0';
				wren_2_b <= '1';
			else
				wren_2_a <= '0';
				wren_2_b <= '0';
			end if;
			
			if (wraddress >= "0111100010" and wraddress < "1000011110" ) then
				wren_patch_2 <= '1';
			else
				wren_patch_2 <= '0';
			end if;
			
		else
			wren_2_a <= '0';
			wren_2_b <= '0';
			wren_patch_2 <= '0';
		end if;
		
		wren_1_a <= '0';
		wren_1_b <= '0';
		wren_patch_1 <= '0';
		
		address_2_a <= std_logic_vector(wraddress(8 downto 0));
		address_2_b <= std_logic_vector(wraddress(6 downto 0));
		address_patch_2 <= std_logic_vector(wraddress(5 downto 0));
		
		address_1_a <= std_logic_vector(rdaddress(8 downto 0));
		address_1_b <= std_logic_vector(rdaddress(6 downto 0));
		address_patch_1 <= std_logic_vector(rdaddress(5 downto 0));
		
	end if;	

end process;


-- MUX for output read

process (read_code,q_1_a,q_1_b,q_2_a,q_2_b,q_patch_1,q_patch_2)

begin
	case read_code is
		when A =>   q <= q_1_a;
		when B =>   q <= q_1_b;
		when C =>   q <= q_2_a;
		when D =>   q <= q_2_b;
		when E =>   q <= q_patch_1;
		when F =>   q <= q_patch_2;
		when others => q <= (others => '0');
	end case;

end process;

end rtl;
