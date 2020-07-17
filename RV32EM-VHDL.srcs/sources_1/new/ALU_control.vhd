--------------------------------------------------------------------------------
-- Title       : ALU control
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU_control.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Fri Jul 10 09:14:57 2020
-- Last update : Mon Jul 13 17:26:20 2020
-- Platform    : NùA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_control is
	port (
		ALUOp                  : in  std_logic_vector(1 downto 0);
		instr_30_25_14_to_12_3 : in  std_logic_vector(5 downto 0);
		ALUControl             : out std_logic_vector(4 downto 0)
	);
end entity ALU_control;

architecture rtl of ALU_control is
	signal mux_1 : std_logic_vector(4 downto 0);
	signal mux_2 : std_logic_vector(4 downto 0);

begin

	with ALUOp select
	ALUControl <=
		"00001" when "00",
		"00010" when "01" ,
		mux_1   when "10" ,
		mux_2   when "11",
		"00000" when others;

	with instr_30_25_14_to_12_3 select
	mux_1 <=
		"00001" when "000000" ,
		"00010" when "100000" ,
		"00011" when "001110" ,
		"00100" when "001100" ,
		"00101" when "001000" ,
		"00110" when "000100" ,
		"00111" when "000110" ,
		"01000" when "000010" ,
		"01001" when "001010" ,
		"01010" when "101010" ,
		"01011" when "010000" ,
		"01100" when "010010" ,
		"01101" when "010100" ,
		"01110" when "010110" ,
		"01111" when "011000" ,
		"10000" when "011010" ,
		"10001" when "011100" ,
		"10010" when "011110" ,
		"00000" when others;

	with instr_30_25_14_to_12_3(3 downto 1) select
	mux_2 <=
		"00001" when "000" ,
		"00011" when "111" ,
		"00100" when "110" ,
		"00101" when "100" ,
		"00110" when "010" ,
		"00111" when "011" ,
		"00000" when others;

end architecture rtl;