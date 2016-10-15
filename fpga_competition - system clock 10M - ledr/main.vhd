
library IEEE;
use IEEE.STD_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity main is 
port (
sw : in std_logic;
ledshow :out std_logic_vector(18 downto 0);
rx : in std_logic;
tx : out std_logic;
clock : in std_logic);

end main;

architecture structure of main is

  -- Component Declaration
  --------------- pll ------------------
component pll
	PORT
	(
		inclk0		: IN STD_LOGIC  ;
		c0		: OUT STD_LOGIC 
	);
END component;
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
sw : in std_logic;
ledshow :out std_logic_vector(18 downto 0);
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
	u: uart PORT MAP(load_uart_ch,data_ch,data_recin,data_recout,load_uart,start,rx,tx,doutuart,dinuart,clk);
	d: decode PORT MAP(din_dec,dout_dec);
	c: code PORT MAP(sw,ledshow,data_code_ch,load_code,round,data_rec,din_rec,load_inter,dout_dec,clk);
	r: recode  PORT MAP(din_rec,dout_rec);
	i: intercon PORT MAP(data_code_ch,load_code,load_uart_ch,data_ch,data_recout,data_recin,round,data_rec,load_inter,load_uart,start,dinuart,doutuart,dout_rec,din_dec,clk);
	pll_inst : pll PORT MAP (
		inclk0	 => clock,
		c0	 => clk
	);


end structure;
