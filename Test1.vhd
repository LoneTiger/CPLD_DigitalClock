----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:26 04/17/2021 
-- Design Name: 
-- Module Name:    Test1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------


-- JK Flip Flop --
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JKFF is
	port( J, K, CLK: in std_logic;
			Q: out std_logic);
end JKFF;

architecture Behavioral of JKFF is
	signal tmp: std_logic;
begin
	
	process (CLK)
	begin
		if rising_edge(CLK) then
			if (J='0' and K='0') then
				tmp <= tmp;
			elsif (J='0' and K='1') then
				tmp <= '0';
			elsif (J='1' and K='0') then
				tmp <= '1';
			elsif (J='1' and K='1') then
				tmp <= not tmp;
			end if;
		end if;
	end process;
	Q <= tmp;
end Behavioral;



-- Decade Counter --
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity C10 is
	port(UP, DOWN, RST: in std_logic;
			C: out std_logic;
			Q: inout std_logic_vector(3 downto 0));
end C10;

architecture Behavioral of C10 is
begin

	process(UP)
	begin
		if rising_edge(UP) then
			if(Q = "1001") then
				Q <= "0000";
				C <= '1';
			else
				Q <= Q+1;
				C <= '0';
			end if;
		end if;
	end process;
	
	process(DOWN)
	begin
		if rising_edge(DOWN) then
			if(Q = "0000") then
				Q <= "0000";
			else
				Q <= Q-1;
			end if;
		end if;
	end process;
	
	process(RST)
	begin
		if rising_edge(RST) then
			Q <= "0000";
			C <= '0';
		end if;
	end process;
	
end Behavioral;

--BCD to 7segment--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_7seg is
	port(BCD: in std_logic_vector (3 downto 0);
		SEG: out std_logic_vector (6 downto 0));
end bcd_7seg;

architecture Behavioral of bcd_7seg is
begin

process(BCD)
begin
	case BCD is
		when "0000" =>
			SEG <= "0000001";
		when "0001" =>
			SEG <= "1001111";
		when "0010" =>
			SEG <= "0010010";
		when "0011" =>
			SEG <= "0000110";
		when "0100" =>
			SEG <= "1001100";
		when "0101" =>
			SEG <= "0100100";
		when "0110" =>
			SEG <= "0100000";
		when "0111" =>
			SEG <= "0001111";
		when "1000" =>
			SEG <= "0000000";
		when "1001" =>
			SEG <= "0000100";
		when others =>
			SEG <= "1111111";
	end case;
end process;
end Behavioral;

-- 7-bit mux --
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux7 is
	port(IN0, IN1, IN2, IN3, IN4, IN5: in std_logic_vector (6 downto 0);
		SEL: in std_logic_vector (2 downto 0);
		OUTp: out std_logic_vector (6 downto 0));
end mux7;

architecture Behavioral of mux7 is
begin

process(SEL)
begin
	case SEL is
		when "000" =>
			OUTp <= IN0;
		when "001" =>
			OUTp <= IN1;
		when "010" =>
			OUTp <= IN2;
		when "011" =>
			OUTp <= IN3;
		when "100" =>
			OUTp <= IN4;
		when "101" =>
			OUTp <= IN5;
		when others =>
			OUTp <= "0000000";
	end case;
end process;
end Behavioral;

-- 6-way decoder --
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec6 is
	port (SEL: in std_logic_vector (2 downto 0);
		OUTp: out std_logic_vector (5 downto 0));
end dec6;

architecture Behavioral of dec6 is
begin

process (SEL)
begin
	case SEL is
		when "000" =>
			OUTp <= "111110";
		when "001" =>
			OUTp <= "111101";
		when "010" =>
			OUTp <= "111011";
		when "011" =>
			OUTp <= "110111";
		when "100" =>
			OUTp <= "101111";
		when "101" =>
			OUTp <= "011111";
		when others =>
			OUTp <= "111111";
	end case;
end process;
end Behavioral;

-- Debouncer --
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity deb is
	port (CLK, BUTTON: in std_logic;
			DEBOUNCED: out std_logic);
end deb;

architecture Behavioral of deb is

signal SET: std_logic := '0';
signal OUTPUT: std_logic;
signal TIME: std_logic_vector (18 downto 0) := "0000000000000000000";

begin

DEBOUNCED <= OUTPUT;

process (CLK)
begin
	if(rising_edge(CLK)) then
		if(SET = '0') then
			if (OUTPUT = not BUTTON) then
				SET <= '1';
			end if;
		else
			if (TIME(18) = '1') then
				if (BUTTON = '1') then
					OUTPUT <= '1';
				else
					OUTPUT <= '0';
				end if;
				SET <= '0';
				TIME <= "0000000000000000000";
			else
				TIME <= TIME + 1;
			end if;
		end if;
	end if;
end process;
end Behavioral;

-- MAIN ENTITY --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Test1 is
    Port ( SW0, SW1, BTN0, BTN1, J3B1, J3B2, J3B4 : in  std_logic;
           LD0, LD1, LD2, LD3 : out  std_logic;
			  J1B1, J1B2, J1B3, J1B4, J1T1, J1T2, J1T3, J1T4, J2B1, J2B2, J2B3, J2B4, J2T1, J2T2, J2T3, J2T4 : out std_logic;
			  
			  CLK:in std_logic;
			  
			  --7 segment
			  AN1, AN2, AN3, AN4, CA, CB, CC, CD, CE, CF, CG, DP : out  std_logic);
end Test1;


architecture Behavioral of Test1 is

component bcd_7seg
Port(BCD: in std_logic_vector (3 downto 0);
		SEG: out std_logic_vector (6 downto 0));
end component;

component mux7
port(IN0, IN1, IN2, IN3, IN4, IN5: in std_logic_vector (6 downto 0);
		SEL: in std_logic_vector (2 downto 0);
		OUTp: out std_logic_vector (6 downto 0));
end component;

component dec6
port (SEL: in std_logic_vector (2 downto 0);
		OUTp: out std_logic_vector (5 downto 0));
end component;

component deb
port (CLK, BUTTON: in std_logic;
		DEBOUNCED: out std_logic);
end component;

-- Signals --

signal CLK_DIV: std_logic_vector (23 downto 0);

signal NUM0, NUM1, NUM2, NUM3, NUM4, NUM5: std_logic_vector (3 downto 0);
signal NUMSEL: std_logic_vector (2 downto 0);
signal SEGSEL: std_logic_vector (5 downto 0);
signal SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEGOUT: std_logic_vector (6 downto 0);

signal LEDs: std_logic_vector (3 downto 0) := "1110";
signal B0, B1: std_logic;

signal COUNT, CYCLE, BLINK, DEBOUNCED_CLK: std_logic;
signal CARRY0, CARRY1, CARRY2, CARRY3, CARRY4: std_logic;
signal CARRY1_2, CARRY3_2: std_logic;

begin
	
	--Clock divider bus--
	Clock_Divider: process(CLK)
	begin
		if rising_edge(CLK) then
			CLK_DIV <= CLK_DIV + '1';
		end if;
	end process;
	
	--CYCLE for blanking operation at 1Khz, BLINK at 4Hz, COUNT at 1Hz.
	CYCLE <= CLK_DIV(12);
	BLINK <= CLK_DIV(20);
	COUNT <= DEBOUNCED_CLK;
	--COUNT <= CLK_DIV(22);
	
	--Blinkenlights--
	blinken: process(BLINK)
	begin
		if rising_edge(BLINK) then
			case LEDs is
				when "1110" =>
					LEDs <= "1101";
				when "1101" =>
					LEDs <= "1011";
				when "1011" =>
					LEDs <= "0111";
				when "0111" =>
					LEDs <= "1110";
				when others =>
					LEDs <= "1110";
			end case;
		end if;
	end process;
	
	LD0 <= LEDs(0);
	LD1 <= LEDs(1);
	LD2 <= LEDs(2);
	LD3 <= LEDs(3);
	
	--Blanking--
	blanking: process(CYCLE)
	begin
		if rising_edge(CYCLE) then
			if(NUMSEL = "101") then
				NUMSEL <= "000";
			else
				NUMSEL <= NUMSEL + '1';
			end if;
		end if;
	end process;
	
	--Button Debounce--
	DEB0: deb port map (CLK, J3B1, B0);
	DEB1: deb port map (CLK, J3B2, B1);
	
	--555 Debounce--
	DEB2: deb port map (CLK, J3B4, DEBOUNCED_CLK);
	
	--Digit 1--
	dig1: process(COUNT)
	begin
		if rising_edge(COUNT) then
			if (NUM0 = "1001") then
				NUM0 <= "0000";
				CARRY0 <= '1';
			else
				NUM0 <= NUM0 + '1';
				CARRY0 <= '0';
			end if;
		end if;
	end process;
	
	--Digit 2--
	dig2: process(CARRY0)
	begin
		if rising_edge(CARRY0) then
			if (NUM1 = "0101") then
				NUM1 <= "0000";
				CARRY1_2 <= '1';
			else
				NUM1 <= NUM1 + 1;
				CARRY1_2 <= '0';
			end if;
		end if;
	end process;
	
	--Button to advance minutes--
	minadj: process(CARRY1_2)
	begin
		if (CARRY1_2 = '1') then
			CARRY1 <= not B0;
		else
			CARRY1 <= B0;
		end if;
	end process;
	
	--Digit 3--
	dig3: process(CARRY1)
	begin
		if rising_edge(CARRY1) then
			if (NUM2 = "1001") then
				NUM2 <= "0000";
				CARRY2 <= '1';
			else
				NUM2 <= NUM2 + 1;
				CARRY2 <= '0';
			end if;
		end if;
	end process;
	
	--Digit 4--
	dig4: process(CARRY2)
	begin
		if rising_edge(CARRY2) then
			if (NUM3 = "0101") then
				NUM3 <= "0000";
				CARRY3_2 <= '1';
			else
				NUM3 <= NUM3 + 1;
				CARRY3_2 <= '0';
			end if;
		end if;
	end process;
	
	--Button to advance hours--
	houradj: process(CARRY3_2)
	begin
		if (CARRY3_2 = '1') then
			CARRY3 <= not B1;
		else
			CARRY3 <= B1;
		end if;
	end process;
	
	--Digit 5--
	dig5: process(CARRY3)
	begin
		if rising_edge(CARRY3) then
			if ((NUM4 = "0011") and (NUM5 = "0010")) then
				NUM4 <= "0000";
				CARRY4 <= '1';
			elsif (NUM4 = "1001") then
				NUM4 <= "0000";
				CARRY4 <= '1';
			else
				NUM4 <= NUM4 + 1;
				CARRY4 <= '0';
			end if;
		end if;
	end process;
	
	--Digit 6--
	dig6: process(CARRY4)
	begin
		if rising_edge(CARRY4) then
			if(NUM5 = "0010") then
				NUM5 <= "0000";
			else
				NUM5 <= NUM5 + 1;
			end if;
		end if;
	end process;
	
	
	DECODE0: bcd_7seg port map(NUM0, SEG0);
	DECODE1: bcd_7seg port map(NUM1, SEG1);
	DECODE2: bcd_7seg port map(NUM2, SEG2);
	DECODE3: bcd_7seg port map(NUM3, SEG3);
	DECODE4: bcd_7seg port map(NUM4, SEG4);
	DECODE5: bcd_7seg port map(NUM5, SEG5);
	
	
	MUX: mux7 port map (SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, NUMSEL, SEGOUT);
	DEC: dec6 port map (NUMSEL, SEGSEL);
	
	--AN1 <= SEGSEL(5);
	--AN2 <= SEGSEL(4);
	--AN3 <= SEGSEL(3);
	--AN4 <= SEGSEL(2);
	--CA <= SEGOUT(6);
	--CB <= SEGOUT(5);
	--CC <= SEGOUT(4);
	--CD <= SEGOUT(3);
	--CE <= SEGOUT(2);
	--CF <= SEGOUT(1);
	--CG <= SEGOUT(0);
	--DP <= '1';
	
	J2B1 <= not SEGSEL(5);
	J2B2 <= not SEGSEL(4);
	J2B3 <= not SEGSEL(3);
	J2B4 <= not SEGSEL(2);
	J2T1 <= not SEGSEL(1);
	J2T2 <= not SEGSEL(0);
	J1B1 <= SEGOUT(6);
	J1B2 <= SEGOUT(5);
	J1B3 <= SEGOUT(4);
	J1B4 <= SEGOUT(3);
	J1T1 <= SEGOUT(2);
	J1T2 <= SEGOUT(1);
	J1T3 <= SEGOUT(0);
	
	J2T4 <= CLK_DIV(22);
	
end Behavioral;

