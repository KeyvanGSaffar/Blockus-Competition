library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity uartcom is
port (
data_rec : out std_logic;
load : in std_logic;
start : in std_logic;
rx : in std_logic;
tx : out std_logic;
din: in std_logic_vector(23 downto 0);
dout: out std_logic_vector(23 downto 0);
clock: in std_logic);
end uartcom;

architecture uart of uartcom is

signal tick : bit ;
signal counter_next: unsigned(6 downto 0) := (others => '0');
signal counter_reg: unsigned(6 downto 0) := (others => '0');
signal cnt_reg :unsigned(4 downto 0) := (others => '0');
signal cnt_next: unsigned(4 downto 0) := (others => '0');
signal cnt_reg1 :unsigned(4 downto 0) := (others => '0');
signal cnt_next1: unsigned(4 downto 0) := (others => '0');
type state_type is (	idle, read1, start1);
signal state_reg,state_next : state_type;
signal i_reg , i_next : unsigned(3 downto 0) := (others => '0');
signal d_reg , d_next : std_logic_vector (23 downto 0) := (others => '0');

type state_type1 is (	idle1, loaddata, write1);
signal state_reg1,state_next1 : state_type1;
signal i_reg1 , i_next1 : integer :=0;--unsigned(4 downto 0) := (others => '0');
signal d_next1,d_reg1 : std_logic_vector (7 downto 0):= (others =>'1');
signal tx_reg,tx_next : std_logic := '0';
signal data_rec_reg,data_rec_next : std_logic;
signal cont_reg,cont_next : integer range 0 to 3;
signal cnt_rd_reg,cnt_rd_next : integer range 0 to 3;

begin

process(clock)
begin 

if (clock'event and clock='1') then
	counter_reg <= counter_next;
	end if;
end process;
tick <= '1' when counter_reg = 0 else '0';
counter_next <= (others => '0') when counter_reg = 64 else counter_reg+1;

process (clock)
begin
	if (clock'event and clock='1') then
	cnt_reg <= cnt_next;
	state_reg<=state_next;
	i_reg<=i_next;
	d_reg <= d_next;
	data_rec_reg <= data_rec_next;
	cnt_rd_reg <= cnt_rd_next;	
	
	
	end if;

end process;


process(state_reg,rx,cnt_reg,i_reg,d_reg,tick,data_rec_reg)

begin 

state_next<=state_reg;
cnt_next<=cnt_reg;
i_next <= i_reg;
d_next <= d_reg;
data_rec_next <= data_rec_reg;
cnt_rd_next <= cnt_rd_reg;
case state_reg is 
			when idle => 
							data_rec_next <= '0';
							if(rx = '1')	then 
									state_next <= idle;
									d_next <= (others => '0');
									cnt_rd_next <= 3;
									elsif (cnt_rd_reg = 0) then
									state_next <= start1;
									i_next <= (others => '0');
									d_next <= (others => '0');	
									cnt_rd_next <= 3;
							else
									state_next <= start1;
									i_next <= (others => '0');
							end if;
				when start1 =>
				if tick = '0' then 
					state_next <= start1;
				else
					if(cnt_reg = 7) then	
							if ( rx='0') then
								state_next <= read1;
								cnt_next <=(others => '0');	
					  	else 
								state_next <= idle;
							end if;
					else 
								cnt_next<=cnt_reg+1; 
					end if;
				end if;
				
			when read1=>
			if tick = '0' then 
					state_next <= read1;
				else
					if(cnt_reg = 15 ) then
						cnt_next<= (others =>'0');
						if (i_reg = 8) then
							if(rx = '1') then 
								state_next <= idle;
								if (cnt_rd_reg = 0) then
									data_rec_next <= '1';
								else 
									cnt_rd_next <= cnt_rd_reg -1;
									data_rec_next <= '0';
								end if;
									else 
									d_next <= (others => '0');
									state_next <= idle;
							end if;
						else
								d_next <= rx & d_reg(23 downto 1);
								i_next<=i_reg+1;
								state_next<=read1;
						end if;
					else
								cnt_next<=cnt_reg+1;
					end if; 
			end if;		
		end case;
end process;
	
dout <= d_reg;
data_rec <= data_rec_reg;

---------------------------------transmitt-------------------------------------												 
process (clock)
begin
	if (clock'event and clock='1') then
	state_reg1<=state_next1;
	cnt_reg1<=cnt_next1;
	i_reg1<=i_next1;
	tx_reg<= tx_next;
	d_reg1 <= d_next1;
	cont_reg <= cont_next;
	end if;

end process;


process(state_reg1,din,cnt_reg1,i_reg1,load,start,tick,tx_reg,d_reg1)

begin 

cont_next<=cont_reg;
state_next1<=state_reg1;
cnt_next1<=cnt_reg1;
i_next1 <= i_reg1;
tx_next <= tx_reg;
d_next1 <= d_reg1;
case state_reg1 is 
			when idle1 => 
							if(load = '1')	then 
									state_next1 <= loaddata;
									i_next1 <= 0;
									d_next1 <= (others => '1');
									cont_next <= 3 ;
							else
									state_next1 <= idle1;
							end if;
				when loaddata =>
							d_next1 <= '1' & din((cont_reg)*8 -1 downto (cont_reg-1)*8) & '0';
							if (start = '1') then
									state_next1 <= write1;
							else
									state_next1 <= loaddata;
							end if;
			when write1=>
			if tick = '0' then 
					state_next1 <= write1;
				else
					if(cnt_reg1 = 15 ) then
						cnt_next1<= (others =>'0');
						if (i_reg1 = 8 ) then
							if (cont_reg = 0) then
							state_next1 <= idle1;
							else
								cont_next <= cont_reg - 1;
								state_next1 <= loaddata;
							end if;
								else
					
								tx_next <= d_reg1(i_reg1);--to_integer(i_reg));
								i_next1<=i_reg1+1;
								state_next1<=write1;

						end if;
					else
								cnt_next1<=cnt_reg1+1;
					end if; 
			end if;		
		end case;
end process;

tx<= tx_reg;


end uart;

