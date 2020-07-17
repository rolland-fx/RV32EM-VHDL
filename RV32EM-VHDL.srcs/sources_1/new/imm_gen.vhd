--------------------------------------------------------------------------------
-- Title       : IMM GEN
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : imm_gen.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Fri Jul 17 09:43:36 2020
-- Last update : Fri Jul 17 11:48:46 2020
-- Platform    : NùA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity imm_gen is
	port (
		instruction : in  std_logic_vector(31 downto 0);
		imm         : out std_logic_vector(31 downto 0)
	);
end entity imm_gen;

architecture rtl of imm_gen is
	signal I_type_artm : std_logic_vector(31 downto 0);
	signal I_type_load : std_logic_vector(31 downto 0);
	signal I_type_JALR : std_logic_vector(31 downto 0);
	signal S_type      : std_logic_vector(31 downto 0);
	signal B_type      : std_logic_vector(31 downto 0);
	signal U_type      : std_logic_vector(31 downto 0);
	signal J_type      : std_logic_vector(31 downto 0);

	signal I_type_imm : std_logic_vector(11 downto 0);
	signal S_type_imm : std_logic_vector(11 downto 0);
	signal B_type_imm : std_logic_vector(12 downto 1);
	signal U_type_imm : std_logic_vector(31 downto 12);
	signal J_type_imm : std_logic_vector(20 downto 1);
begin

	I_type_imm <= instruction(31 downto 20);
	S_type_imm <= instruction(31 downto 25) & instruction(11 downto 7);
	B_type_imm <= instruction(31) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 8);
	U_type_imm <= instruction(31 downto 12);
	J_type_imm <= instruction(31) & instruction(19 downto 12) & instruction(20) & instruction(30 downto 21);

	with instruction(14 downto 12) select
	I_type_artm <=
		std_logic_vector(resize(signed(I_type_imm), I_type_artm'length))   when "000",
		std_logic_vector(resize(signed(I_type_imm), I_type_artm'length))   when "010",
		std_logic_vector(resize(unsigned(I_type_imm), I_type_artm'length)) when "011",
		std_logic_vector(resize(unsigned(I_type_imm), I_type_artm'length)) when "100",
		std_logic_vector(resize(unsigned(I_type_imm), I_type_artm'length)) when "110",
		std_logic_vector(resize(unsigned(I_type_imm), I_type_artm'length)) when "111",
		(others => '0')                                                    when others;

	I_type_load <= std_logic_vector(resize(signed(I_type_imm), I_type_load'length));

	I_type_JALR <= std_logic_vector(resize(signed(I_type_imm), I_type_JALR'length));

	S_type <= std_logic_vector(resize(signed(S_type_imm), S_type'length));

	with instruction(14 downto 12) select
	B_type <=
		std_logic_vector(resize(signed(B_type_imm), B_type'length))   when "000",
		std_logic_vector(resize(signed(B_type_imm), B_type'length))   when "001",
		std_logic_vector(resize(signed(B_type_imm), B_type'length))   when "100",
		std_logic_vector(resize(signed(B_type_imm), B_type'length))   when "101",
		std_logic_vector(resize(unsigned(B_type_imm), B_type'length)) when "110",
		std_logic_vector(resize(unsigned(B_type_imm), B_type'length)) when "111",
		(others => '0')                                               when others;

	U_type <= U_type_imm & x"000";

	J_type <= std_logic_vector(resize(signed(J_type_imm), J_type'length));

	with instruction(6 downto 0) select
	imm <=
		I_type_load     when "0000011",
		I_type_artm     when "0010011",
		I_type_JALR     when "1100111",
		S_type          when "0100011",
		B_type          when "1100011",
		U_type          when "0110111",
		U_type          when "0010111",
		J_type          when "1101111",
		(others => '0') when others;


end architecture rtl;