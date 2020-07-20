--------------------------------------------------------------------------------
-- Title       : Hazard Detection Unit
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : Hazard_detection_unit.vhd
-- Author      : Francois-Xavier Rolland (francois-xavier.rolland.1@ens.etsmtl.ca)
-- Company     : École de technologie supérieur
-- Platform    : N/A
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hazard_detection_unit is
	port (
	IF_Instruction_RS1 : in std_logic_vector(4 downto 0);
	IF_Instruction_RS2 : in std_logic_vector(4 downto 0);
	ID_Instruction_RD  : in std_logic_vector(4 downto 0);
	EX_Instruction_RD  : in std_logic_vector(4 downto 0);
	ID_MemRead         : in std_logic;
	EX_RegWrite        : in std_logic;
	IF_Stall 	       : out std_logic;
	ID_Stall 	       : out std_logic
	);
end entity Hazard_detection_unit;

architecture rtl of Hazard_detection_unit is
	signal s_o_stall : std_logic;

begin
	s_o_stall <= '1' when ((ID_Instruction_RD = IF_Instruction_RS1 AND IF_Instruction_RS1 /= "00000" AND ID_MemRead = '1')
						 or(ID_Instruction_RD = IF_Instruction_RS2 AND IF_Instruction_RS2 /= "00000" AND ID_MemRead = '1')
                         or(EX_Instruction_RD = IF_Instruction_RS1 AND IF_Instruction_RS1 /= "00000" AND EX_RegWrite = '1')
                         or(EX_Instruction_RD = IF_Instruction_RS2 AND IF_Instruction_RS2 /= "00000" AND EX_RegWrite = '1'))
				 else '0';


	IF_Stall <= s_o_stall;
	ID_Stall <= s_o_stall;
	
end architecture rtl;