
library IEEE;
use IEEE.STD_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity main is 
port (
rx : in std_logic;
tx : out std_logic;
clock : in std_logic);

end main;

architecture structure of main is

  -- Component Declaration
  --------------- pll ------------------
--component pll
--	PORT
--	(
--		inclk0		: IN STD_LOGIC  ;
--		c0		: OUT STD_LOGIC 
--	);
--END component;
 ---------------- uart ------------------
component uart 
port (
load_uart : out std_logic;
data_ch : in std_logic;
data_recin : out std_logic;
data_recout : out std_logic;
load : in std_logic;
start : in std_logic;
rx : in std_logic;
tx : out std_logic;
din: in std_logic_vector(7 downto 0);
dout: out std_logic_vector(7 downto 0);
clock: in std_logic);
end component;


---------------- decode --------------------
component decode
    Port ( datain : in std_logic_vector(31 downto 0);
				  data_decoded : out std_logic_vector (117 downto 0)
);
end component; 

------------ game -----------------
component code 
port (
data_code_ch : out std_logic;
load_code : in std_logic;
round : in std_logic_vector(1 downto 0);
data_rec : in std_logic;
ok : out std_logic_vector(117 downto 0);
load : out std_logic;
din : in std_logic_vector(117 downto 0);
clk : in std_logic);
end component;
---------- recode -----------------
component recode
    Port ( datain :in std_logic_vector (117 downto 0);
				  data_coded :  out std_logic_vector(31 downto 0)
);
end component;
 --------- interconnection ---------------
component intercon
port (
data_code_ch : in std_logic;
load_code : out std_logic;
load_uart : in std_logic;
data_ch : out std_logic;
data_recout : in std_logic;
data_recin : in std_logic;
round : out std_logic_vector(1 downto 0);
data_rec : out std_logic;
load_in : in std_logic;
load_out : out std_logic;
start_out : out std_logic;
dinuart : in std_logic_vector(7 downto 0);
doutuart : out std_logic_vector(7 downto 0);
dinrec : in std_logic_vector(31 downto 0);
doutdec : out std_logic_vector(31 downto 0);
clock: in std_logic);
end component;


for u:uart use Entity work.uartcom(uart);
for d:decode use Entity work.decode(Gate_level);
for c:code use Entity work.code(failure);
for r:recode use Entity work.recode(Gate_level);
for i:intercon use Entity work.intercon(structure);

signal din_dec,dout_rec : std_logic_vector(31 downto 0) ;
signal clk : std_logic ;
signal dinuart,doutuart : std_logic_vector(7 downto 0);
signal dout_dec,din_rec : std_logic_vector(117 downto 0) ;
signal load_uart,load_inter,start : std_logic;
signal data_rec,data_recin,data_recout,load_uart_ch,data_ch,load_code,data_code_ch : std_logic;
signal round : std_logic_vector(1 downto 0);

begin

-- Component Instantiation
	u: uart PORT MAP(load_uart_ch,data_ch,data_recin,data_recout,load_uart,start,rx,tx,doutuart,dinuart,clock);
	d: decode PORT MAP(din_dec,dout_dec);
	c: code PORT MAP(data_code_ch,load_code,round,data_rec,din_rec,load_inter,dout_dec,clock);
	r: recode  PORT MAP(din_rec,dout_rec);
	i: intercon PORT MAP(data_code_ch,load_code,load_uart_ch,data_ch,data_recout,data_recin,round,data_rec,load_inter,load_uart,start,dinuart,doutuart,dout_rec,din_dec,clock);
--	pll_inst : pll PORT MAP (
--		inclk0	 => clock,
--		c0	 => clk
--	);


end structure;

------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------
architecture test_bench of main is

  -- Component Declaration
Component x Port (rx : in std_logic;
tx : out std_logic;
clock : in std_logic);
end component;
for g:x use Entity work.main(structure);

signal rx1 : std_logic;
signal tx1 : std_logic;
signal clock1 : std_logic := '1';
begin

-- Component Instantiation
  g: x PORT MAP(rx1,tx1,clock1);
		 
--    datain1 <= "0011101011000000000000000000000000000000000000000011010011000000000010100010000000000010001010000000000011010011000000"; --"1100000000000000" after 2 ns,"1010101010101010" after 4 ns,"1111111111111111" after 6 ns,"1111111100000000" after 8 ns,"1111110011001001" after 10 ns; '1','0' after 10 ns;

	process
	begin
	clock1 <= not clock1;
	wait for 1 ns;
	end process;

	rx1 <= '1','0' after 2 ns,'0' after 4 ns,'1' after 6 ns,'1' after 8 ns,'0' after 10 ns,'0' after 12 ns,'0' after 14 ns,'0' after 16 ns,'0' after 18 ns,'1' after 80 ns, '0' after 82 ns,'0' after 84 ns,'1' after 86 ns,'1' after 88 ns,'0' after 90 ns,'0' after 92 ns,'1' after 94 ns,'0' after 96 ns,'0' after 98 ns,'1' after 100 ns,'0' after 102 ns,'0' after 104 ns,'1' after 106 ns,'1' after 108 ns,'0' after 110 ns,'1' after 112 ns,'0' after 114 ns,'1' after 116 ns,'0' after 118 ns,'1' after 190 ns,'0' after 192 ns,'0' after 194 ns,'1' after 196 ns,'1' after 198 ns,'1' after 200 ns,'0' after 202 ns,'0' after 204 ns,'1' after 206 ns,'0' after 208 ns,'1' after 210 ns,'0' after 212 ns,'0' after 214 ns,'1' after 216 ns,'1' after 218 ns,'1' after 220 ns,'0' after 222 ns,'0' after 224 ns,'1' after 226 ns,'0' after 228 ns,'1' after 230 ns,'0' after 232 ns,'1' after 234 ns,'1' after 236 ns,'1' after 238 ns,'0' after 240 ns,'0' after 242 ns,'0' after 244 ns,'1' after 246 ns,'0' after 248 ns,'1' after 250 ns,'0' after 252 ns,'0' after 254 ns,'1' after 256 ns,'1' after 258 ns,'0' after 260 ns,'0' after 262 ns,'0' after 264 ns,'0' after 266 ns,'0' after 268 ns;

end test_bench;




