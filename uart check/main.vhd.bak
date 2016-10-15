
library IEEE;
use IEEE.STD_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity main is 
port (
rx : in std_logic;
tx : out std_logic;
clk : in std_logic);

end main;

architecture structure of main is

  -- Component Declaration
 ---------------- uart ------------------
component uart 
port (
data_rec : out std_logic;
load : in std_logic;
start : in std_logic;
rx : in std_logic;
tx : out std_logic;
din: in std_logic_vector(23 downto 0);
dout: out std_logic_vector(23 downto 0);
clock: in std_logic);
end component;
---------------- decode --------------------
component decode
    Port ( datain : in std_logic_vector(23 downto 0);
				  data_decoded : out std_logic_vector (117 downto 0)
);
end component; 
--------------- opponent mapping -----------
component opponent 
port (
opp : out std_logic_vector(431 downto 0);
din : in std_logic_vector(117 downto 0);
clk : in std_logic);
end component;
------------ game -----------------
component code 
port (
data_rec : in std_logic;
ok : out std_logic_vector(117 downto 0);
load : out std_logic;
start : out std_logic;
opponent : in std_logic_vector(431 downto 0);
clk : in std_logic);
end component;
---------- recode -----------------
component recode
    Port ( datain :in std_logic_vector (117 downto 0);
				  data_coded :  out std_logic_vector(23 downto 0)
);
end component;


for u:uart use Entity work.uartcom(uart);
for d:decode use Entity work.decode(Gate_level);
for o:opponent use Entity work.opponent(structure);
for c:code use Entity work.code(failure);
for r:recode use Entity work.recode(Gate_level);

signal din_dec,dout_rec : std_logic_vector(23 downto 0) ;
signal dout_dec,din_rec : std_logic_vector(117 downto 0) ;
signal load,start : std_logic;
signal opponentmap : std_logic_vector(431 downto 0) ;
signal data_rec : std_logic;

begin

-- Component Instantiation
	u: uart PORT MAP(data_rec,load,start,rx,tx,dout_rec,din_dec,clk);
	d: decode PORT MAP(din_dec,dout_dec);
	o: opponent PORT MAP(opponentmap,dout_dec,clk);
	c: code PORT MAP(data_rec,din_rec,load,start,opponentmap,clk);
	r: recode  PORT MAP(din_rec,dout_rec);



end structure;
