library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity intercon is
port (
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
end intercon;

architecture structure of intercon is

signal state_reg,state_next : std_logic_vector(2 downto 0) := "000";
signal cont_reg,cont_next,contin_reg,contin_next : integer range 0 to 5;
signal load_out_reg,load_out_next,start_out_reg,start_out_next,data_rec_reg,data_rec_next : std_logic := '0';
signal data_reg,data_next : std_logic_vector(31 downto 0);
signal doutdec_reg,doutdec_next : std_logic_vector(31 downto 0);
signal doutuart_reg,doutuart_next : std_logic_vector(7 downto 0);
signal round_next,round_reg : std_logic_vector(1 downto 0) := "00";

begin


process (clock)
begin
	if (clock'event and clock='1') then
		state_reg<=state_next;
		data_reg <= data_next;
		data_rec_reg <= data_rec_next;
		doutdec_reg <= doutdec_next;
		doutuart_reg <= doutuart_next;
		load_out_reg <= load_out_next;
		start_out_reg <= start_out_next;
		round_reg <= round_next;
		contin_reg <= contin_next;
		cont_reg <= cont_next;	
	end if;

end process;


process(state_reg,load_in,dinuart,data_recin,data_recout,data_reg,data_rec_reg,doutdec_reg,doutuart_reg,load_out_reg,start_out_reg,round_reg,contin_reg,cont_reg)

begin 

state_next<=state_reg;
data_rec_next <= data_rec_reg;
doutdec_next <= doutdec_reg;
doutuart_next <= doutuart_reg;
data_rec_next <= data_rec_reg;
load_out_next <= load_out_reg;
start_out_next <= start_out_reg;
data_next <= data_reg;
round_next <= round_reg;
contin_next <= contin_reg;
cont_next <= cont_reg;

case state_reg is 
			when "000" => 
						if(data_recin = '1') then
							if ( dinuart = "00110000" ) then -- 0 in ASCII
								data_rec_next <= '0';
								cont_next <= 3;
								state_next <= "001";
								data_next <= (others => '00110000001100010110000101100001');  --1aa in ASCII
							elsif( unsigned(dinuart) = "00110010") then --- 2 in ASCII
								data_rec_next <= '1';
								round_next <= "01";
								state_next <= "101";
							elsif(unsigned(dinuart) = "00110011")  then ---- 3 in ASCII
								data_rec_next <= '0';
								state_next <= "100";
								contin_next <= 4;
							end if;
						else
							state_next <= "000";
						end if;
				when "100" =>
						if( contin_reg = 0 ) then
									data_rec_next <= '1';
									state_next <= "101";
						elsif(data_recin = '1') then
							if(data_reg(7 downto 0) = "01100001" and dinuart = "00110101") then --- a in ASCII & 5 in ASCII
								state_next <= "000";
								round_next <= "10";
							else
									contin_next <= contin_reg - 1;
									state_next <= "100";
									doutdec_next <= doutdec_reg(23 downto 0) & dinuart;
							end if;
						else 
							state_next <= "100";		
						end if;
				when "101" =>
								cont_next <= 4;
								if( load_in = '1') then
									data_next <= dinrec;
									state_next <= "001";
								else
									state_next <= "101";
								end if;
				when "001" =>
								data_rec_next <= '0';
								if(cont_reg = 0) then
									state_next <= "000";
								elsif( data_recout = '1') then
									doutuart_next <= data_reg((cont_reg)*8 -1 downto (cont_reg-1)*8);
									state_next <= "010";
									cont_next <= cont_reg - 1;
								else
									state_next <= "001";
								end if;
				when "010" =>
									load_out_next <= '1';
									start_out_next <= '0';
									state_next <= "011";
				when "011" =>
								start_out_next <= '1';
								load_out_next <= '0';
								state_next <= "001";
				when others =>
								state_next <= "000";
		end case;
end process;
	
doutdec <= doutdec_reg;
doutuart <= doutuart_reg;
data_rec <= data_rec_reg;
load_out <= load_out_reg;
start_out <= start_out_reg;
round <= round_reg;

end structure;


