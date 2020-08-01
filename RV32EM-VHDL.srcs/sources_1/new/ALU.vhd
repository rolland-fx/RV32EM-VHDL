--------------------------------------------------------------------------------
-- Title       : ALU
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca>
-- Company     : École de technologie Superieur
-- Created     : Fri Jul  3 19:04:26 2020
-- Last update : Fri Jul 31 19:46:19 2020
-- Platform    : N/A
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port (
		ALU_control : in std_logic_vector(4 downto 0);
		opA         : in std_logic_vector(31 downto 0);
		opB         : in std_logic_vector(31 downto 0);

		ALU_out : out std_logic_vector(31 downto 0)
	);

end entity ALU;

architecture rtl of ALU is


	signal MULSU_opA : std_logic_vector(32 downto 0);
	signal MULSU_opB : std_logic_vector(32 downto 0);


	signal ADD_sig   : std_logic_vector(31 downto 0);
	signal SUB_sig   : std_logic_vector(31 downto 0);
	signal SLL_sig   : std_logic_vector(31 downto 0);
	signal SRL_sig   : std_logic_vector(31 downto 0);
	signal SRA_sig   : std_logic_vector(31 downto 0);
	signal SLT_sig   : std_logic_vector(31 downto 0);
	signal SLTU_sig  : std_logic_vector(31 downto 0);
	signal AND_sig   : std_logic_vector(31 downto 0);
	signal OR_sig    : std_logic_vector(31 downto 0);
	signal XOR_sig   : std_logic_vector(31 downto 0);
	signal MUL_sig   : std_logic_vector(63 downto 0);
	signal MULSU_sig : std_logic_vector(65 downto 0);
	signal MULU_sig  : std_logic_vector(63 downto 0);
	signal DIV_sig   : std_logic_vector(31 downto 0);
	signal DIVU_sig  : std_logic_vector(31 downto 0);
	signal REM_sig   : std_logic_vector(31 downto 0);
	signal REMU_sig  : std_logic_vector(31 downto 0);
	signal ls_1      : std_logic_vector(31 downto 0);
	signal ls_2      : std_logic_vector(31 downto 0);

begin
	MULSU_opA              <= std_logic_vector(resize(signed(opA), MULSU_opA'length));
	MULSU_opB(32)          <= '0';
	MULSU_opB(31 downto 0) <= opB;

	ADD_sig   <= std_logic_vector(signed(opA) + signed(opB));
	SUB_sig   <= std_logic_vector(signed(opA) - signed(opB));
	SLL_sig   <= std_logic_vector(shift_left(unsigned(opA), to_integer(unsigned(opB(4 downto 0)))));
	SRL_sig   <= std_logic_vector(shift_right(unsigned(opA), to_integer(unsigned(opB(4 downto 0)))));
	SRA_sig   <= std_logic_vector(shift_right(signed(opA), to_integer(unsigned(opB(4 downto 0)))));
	SLT_sig   <= x"00000001" when signed(opA) < signed(opB) else x"00000000";
	SLTU_sig  <= x"00000001" when unsigned(opA) < unsigned(opB) else x"00000000";
	AND_sig   <= opA and opB;
	OR_sig    <= opA or opB;
	XOR_sig   <= opA xor opB;
	MUL_sig   <= std_logic_vector( signed(opA) * signed(opB));
	MULSU_sig <= std_logic_vector(std_logic_vector(signed(MULSU_opA) * signed(MULSU_opB)));
	MULU_sig  <= std_logic_vector(unsigned(opA)* unsigned(opB));
	ls_1      <= std_logic_vector(shift_left(signed(opA) + signed(opB), 1));
	ls_2      <= std_logic_vector(shift_left(signed(opA) + signed(opB), 2));
	with opB select
	DIV_sig <=
		x"7fffffff"                                 when x"00000000",
		std_logic_vector(signed(opA) / signed(opB)) when others;
	with opB select
	DIVU_sig <=
		x"7fffffff"                                     when x"00000000",
		std_logic_vector(unsigned(opA) / unsigned(opB)) when others;
	with opB select
	REM_sig <=
		x"7fffffff"                                   when x"00000000",
		std_logic_vector(signed(opA) rem signed(opB)) when others;
	with opB select
	REMU_sig <=
		x"7fffffff"                                       when x"00000000",
		std_logic_vector(unsigned(opA) rem unsigned(opB)) when others;

	with ALU_control select
	ALU_out <=
		ADD_sig                 when "00001",
		SUB_sig                 when "00010",
		AND_sig                 when "00011",
		OR_sig                  when "00100",
		XOR_sig                 when "00101",
		SLT_sig                 when "00110",
		SLTU_sig                when "00111",
		SLL_sig                 when "01000",
		SRL_sig                 when "01001",
		SRA_sig                 when "01010",
		MUL_sig(31 downto 0)    when "01011",
		MUL_sig(63 downto 32)   when "01100",
		MULSU_sig(63 downto 32) when "01101",
		MULU_sig(63 downto 32)  when "01110",
		DIV_sig                 when "01111",
		DIVU_sig                when "10000",
		REM_sig                 when "10001",
		REMU_sig                when "10010",
		ls_1                    when "11001",
		ls_2                    when "10101",
		(others => '0')         when others;



end architecture rtl;