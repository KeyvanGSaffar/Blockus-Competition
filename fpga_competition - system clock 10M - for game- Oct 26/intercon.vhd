library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity intercon is
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
end intercon;

architecture structure of intercon is

signal state_reg,state_next : std_logic_vector(2 downto 0) := "000";
signal cont_reg,cont_next,contin_reg,contin_next : integer range 0 to 5;
signal load_out_reg,load_out_next,start_out_reg,start_out_next,data_rec_reg,data_rec_next : std_logic := '0';
signal data_reg,data_next : std_logic_vector(31 downto 0);
signal doutdec_reg,doutdec_next : std_logic_vector(31 downto 0);
signal doutuart_reg,doutuart_next : std_logic_vector(7 downto 0);
signal round_next,round_reg : std_logic_vector(1 downto 0) := "00";
signal data_ch_next,data_ch_reg : std_logic := '0';
signal load_code_next,load_code_reg: std_logic := '0';
signal s_reg,s_next : std_logic := '0';
signal game_round_reg,game_round_next : integer range 0 to 7;
signal x : std_logic := '1';

begin


process (clock)
begin
	if (clock'event and clock='1') then
		state_reg <= state_next;
		data_reg <= data_next;
		data_rec_reg <= data_rec_next;
		doutdec_reg <= doutdec_next;
		doutuart_reg <= doutuart_next;
		load_out_reg <= load_out_next;
		start_out_reg <= start_out_next;
		round_reg <= round_next;
		contin_reg <= contin_next;
		cont_reg <= cont_next;	
		data_ch_reg <= data_ch_next;
		load_code_reg <= load_code_next;
		s_reg <= s_next;
		game_round_reg <= game_round_next;
	
	end if;

end process;


process(game_round_reg,s_reg,data_code_ch,load_code_reg,load_uart,data_ch_reg,state_reg,load_in,dinrec,dinuart,data_recin,data_recout,data_reg,data_rec_reg,doutdec_reg,doutuart_reg,load_out_reg,start_out_reg,round_reg,contin_reg,cont_reg)

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
data_ch_next<= data_ch_reg;
load_code_next <= load_code_reg;
game_round_next <= game_round_reg;
s_next <= s_reg;

case state_reg is 
			when "000" => 
						if(s_reg = '0') then		
								doutuart_next <= (others => '0');
								state_next <= "000";
								load_out_next <= '1';
								start_out_next <= '1';
								s_next <= '1';
								game_round_next <= 0;
						else
							load_out_next <= '0';
							data_ch_next <= '1';
						if(data_recin = '1') then
							load_code_next <= '0';
							if ( unsigned(dinuart) = "00110000") then -- 0 in ASCII
								data_rec_next <= '0';
								cont_next <= 3;
								state_next <= "001";
								data_next <= "00110000001100010110000101100001";  --1aa in ASCII
							elsif( unsigned(dinuart) = "00110010") then --- 2 in ASCII
								data_rec_next <= '1';
								round_next <= "01";
								state_next <= "100";
								contin_next <= 1;
							elsif(unsigned(dinuart) = "00110011")  then ---- 3 in ASCII
								data_rec_next <= '0';
								state_next <= "100";
								contin_next <= 4;
							end if;
						else
							state_next <= "000";
						end if;
					end if;
				when "100" =>
						if( contin_reg = 0 ) then
									data_rec_next <= '1';
									state_next <= "101";
						elsif(data_recin = '1') then
							data_ch_next <= '1';
							if(contin_reg /= 1 and data_reg(7 downto 0) = "01100001" and dinuart = "00110101") then --- a in ASCII & 5 in ASCII
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
								game_round_next <= game_round_reg + 1;
								if(game_round_reg = 0) then
									if( round_reg = "01") then
										data_next <= x"35356934";
									elsif(doutdec_reg(31 downto 16) = x"3434" or doutdec_reg(31 downto 16) = x"3435" or doutdec_reg(31 downto 16) = x"3436" 
											or doutdec_reg(31 downto 16) = x"3232" or doutdec_reg(31 downto 16) = x"3233" or doutdec_reg(31 downto 16) = x"3234"
											or doutdec_reg(31 downto 16) = x"3235" or doutdec_reg(31 downto 16) = x"3236" or doutdec_reg(31 downto 16) = x"3332"
											or doutdec_reg(31 downto 16) = x"3333" or doutdec_reg(31 downto 16) = x"3334" or doutdec_reg(31 downto 16) = x"3335"
											or doutdec_reg(31 downto 16) = x"3336" or doutdec_reg(31 downto 16) = x"3432" or doutdec_reg(31 downto 16) = x"3433"
											or doutdec_reg(31 downto 16) = x"3532" or doutdec_reg(31 downto 16) = x"3533" or doutdec_reg(31 downto 16) = x"3534"
											or doutdec_reg(31 downto 16) = x"3535" or doutdec_reg(31 downto 16) = x"3536" or doutdec_reg(31 downto 16) = x"3632"
											or doutdec_reg(31 downto 16) = x"3633" or doutdec_reg(31 downto 16) = x"3634" or doutdec_reg(31 downto 16) = x"3635"
											or doutdec_reg(31 downto 16) = x"3636") then
										data_next <= x"38386931";
									else
										round_next <= "01";
										data_next <= x"34347130";
									end if;
								elsif(game_round_reg = 1) then
									if( round_reg = "01") then
										data_next <= x"36346d30";
									else
										data_next <= x"37396d35";
									end if;
								elsif(game_round_reg = 2) then
									if( round_reg = "01") then
										data_next <= x"38316a37";
									else
										data_next <= x"35636a32";
									end if;
								elsif(game_round_reg = 3) then
									if( round_reg = "01") then
										data_next <= x"34386237";
									else
										data_next <= x"39636232";
									end if;
								elsif(game_round_reg = 4) then
									if( round_reg = "01") then
										data_next <= x"32327030";
 									else 
										data_next <= x"62627035";
									end if;
								elsif(game_round_reg = 5) then
									if( round_reg = "01") then
										data_next <= x"32356e35";
									else
										data_next <= x"62386e30";
									end if;
								end if;
								if(doutdec_reg = x"30303030" and ( (game_round_reg /= 0) and (game_round_reg /= 1) and (game_round_reg /= 2) and (game_round_reg /= 3) ) ) then
									data_next <= x"30303030";
								end if;
								state_next <= "001";
								cont_next <= 4;
								--if (data_code_ch = '1') then 
									--data_rec_next <= '0';
								--end if;
								--data_ch_next <= '0';
								--cont_next <= 4;
								--if( load_in = '1') then
									--load_code_next <= '1';
									--data_next <= dinrec;
									--state_next <= "001";
								--else
									--state_next <= "101";
								--end if;
				when "001" =>
								
								data_ch_next <= '0';
								data_rec_next <= '0';
								if(cont_reg = 0) then
									state_next <= "000";
								elsif( data_recout = '1') then
									start_out_next <= '0';
									doutuart_next <= data_reg(((cont_reg)*8 - 1) downto (cont_reg-1)*8);
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
								if (load_uart = '1') then
									start_out_next <= '1';
									load_out_next <= '0';
									state_next <= "111";
								else 
									state_next <= "011";
								end if;
				when "111" =>
								if(load_uart = '0') then 
									state_next <= "001";
								else
									state_next <= "111";
								end if;
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
data_ch <= data_ch_reg;
load_code <= load_code_reg;

end structure;

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--architecture test_bench of intercon is
--
--  -- Component Declaration
--Component x Port (data_recout : in std_logic;
--data_recin : in std_logic;
--round : out std_logic_vector(1 downto 0);
--data_rec : out std_logic;
--load_in : in std_logic;
--load_out : out std_logic;
--start_out : out std_logic;
--dinuart : in std_logic_vector(7 downto 0);
--doutuart : out std_logic_vector(7 downto 0);
--dinrec : in std_logic_vector(31 downto 0);
--doutdec : out std_logic_vector(31 downto 0);
--clock: in std_logic);
--end component;
--
--for g:x use Entity work.intercon(structure);
--
--
--signal	data_recout1 : std_logic;
--signal	data_recin1 : std_logic;
--signal	round1 : std_logic_vector(1 downto 0);
--signal	data_rec1 : std_logic;
--signal	load_in1 : std_logic;
--signal	load_out1 : std_logic;
--signal	start_out1 : std_logic;
--signal	dinuart1 : std_logic_vector(7 downto 0);
--signal	doutuart1 : std_logic_vector(7 downto 0);
--signal	dinrec1 : std_logic_vector(31 downto 0);
--signal	doutdec1 : std_logic_vector(31 downto 0);
--signal	clock1 : std_logic	:= '1';
--begin
--
---- Component Instantiation
--  g: x PORT MAP(data_recout1,data_recin1,round1,data_rec1,load_in1,load_out1,start_out1,dinuart1,doutuart1,dinrec1,doutdec1,clock1);
--		 
----    datain1 <= "00011100000110000000000000000000000000000000000000000011010011000000000010100010000000000010001010000000000011010011000000"; --"1100000000000000" after 2 ns,"1010101010101010" after 4 ns,"1111111111111111" after 6 ns,"1111111100000000" after 8 ns,"1111110011001001" after 10 ns; '1','0' after 10 ns;
--	--	current1 <= "100", "011"  after 2 ns,"111" after 4 ns;
--	--	b1 <= "011";
---- process(clock1)
----	begin
----	clock1 <= not clock1 after 1 ns;
---- end process;
----	clock1 <= '0','1' after 1 ns;
--	process
--	begin
--	clock1 <= not clock1;
--	wait for 1 ns;
--	end process;	
--
--
-- dinuart1 <= "00110000", "00110011" after 20 ns;
-- data_recin1 <= '0','1' after 1 ns;
-- data_recout1 <= '1'; 
--
--end test_bench;
--
--
