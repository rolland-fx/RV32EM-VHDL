--------------------------------------------------------------------------------
-- Title       : Imm Gen TestBench
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : imm_gen_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Sat Jul 25 15:00:46 2020
-- Last update : Sat Jul 25 20:15:37 2020
-- Platform    : NùA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

library demo_lib;

-----------------------------------------------------------

entity imm_gen_tb is
	generic (runner_cfg : string);
end entity imm_gen_tb;

-----------------------------------------------------------

architecture testbench of imm_gen_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal instruction : std_logic_vector(31 downto 0);
	signal imm         : std_logic_vector(31 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------

	-- N/A

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	main : process
	begin
		test_runner_setup(runner, runner_cfg);

		instruction <= x"fff00003"; -- LB
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff01003"; -- LH
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff02003"; -- LW
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff04003"; -- LBU
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff05003"; -- LHU
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff00013"; -- ADDI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff02013"; -- SLTI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fff03013"; -- SLTIU
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000fff"));

		instruction <= x"fff04013"; -- XORI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000fff"));

		instruction <= x"fff06013"; -- ORI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000fff"));

		instruction <= x"fff07013"; -- ANDI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000fff"));

		instruction <= x"fff00067"; -- JALR
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffff"));

		instruction <= x"fe000023"; -- SB
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffe0"));

		instruction <= x"fe001023"; -- SH
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffe0"));

		instruction <= x"fe002023"; -- SW
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"ffffffe0"));

		instruction <= x"fe000063"; -- BEQ
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffffbf0"));

		instruction <= x"fe001063"; -- BNE
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffffbf0"));

		instruction <= x"fe004063"; -- BLT
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffffbf0"));

		instruction <= x"fe005063"; -- BGE
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffffbf0"));

		instruction <= x"fe006063"; -- BLTU
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000bf0"));

		instruction <= x"fe007063"; -- BGEU
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"00000bf0"));

		instruction <= x"fffff037"; -- LUI
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffff000"));

		instruction <= x"fffff017"; -- AUIPC
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fffff000"));

		instruction <= x"8010006f"; -- JAL
		wait for 10 ns;
		check_equal(imm, std_logic_vector'(x"fff80400"));

		wait for 10 ns;

		test_runner_cleanup(runner);
	end process;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.imm_gen
		port map (
			instruction => instruction,
			imm         => imm
		);

end architecture testbench;