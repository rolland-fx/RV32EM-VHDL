--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU_control_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Mon Jul 13 17:07:31 2020
-- Last update : Fri Jul 31 19:50:08 2020
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

entity ALU_control_tb is
	generic (runner_cfg : string);
end entity ALU_control_tb;

-----------------------------------------------------------

architecture testbench of ALU_control_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal ALUOp                  : std_logic_vector(1 downto 0);
	signal instr_30_25_14_to_12_3 : std_logic_vector(5 downto 0);
	signal ALUControl             : std_logic_vector(4 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	main : process
	begin
		test_runner_setup(runner, runner_cfg);

		ALUOp <= "00";
		instr_30_25_14_to_12_3 <= "XXX10X";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00001"), "ALUOp = 00");

		ALUOp <= "01";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00001"), "ALUOp = 01");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "000000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00001"), "instr[30,25,14-12,3] = 000000");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "100000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00010"), "instr[30,25,14-12,3] = 100000");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "001110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00011"), "instr[30,25,14-12,3] = 001110");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "001100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00100"), "instr[30,25,14-12,3] = 001100");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "001000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00101"), "instr[30,25,14-12,3] = 001000");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "000100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00110"), "instr[30,25,14-12,3] = 000100");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "000110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00111"), "instr[30,25,14-12,3] = 000110");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "000010";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01000"), "instr[30,25,14-12,3] = 000010");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "001010";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01001"), "instr[30,25,14-12,3] = 001010");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "101010";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01010"), "instr[30,25,14-12,3] = 101010");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "010000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01011"), "instr[30,25,14-12,3] = 010000");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "010010";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01100"), "instr[30,25,14-12,3] = 010010");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "010100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01101"), "instr[30,25,14-12,3] = 010100");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "010110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01110"), "instr[30,25,14-12,3] = 010110");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "011000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("01111"), "instr[30,25,14-12,3] = 011000");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "011010";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("10000"), "instr[30,25,14-12,3] = 011010");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "011100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("10001"), "instr[30,25,14-12,3] = 011100");

		ALUOp <= "10";
		instr_30_25_14_to_12_3 <= "011110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("10010"), "instr[30,25,14-12,3] = 011110");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX0000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00001"), "instr[30,25,14-12,3] = xx0000");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX1110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00011"), "instr[30,25,14-12,3] = xx1110");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX1100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00100"), "instr[30,25,14-12,3] = xx1100");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX1000";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00101"), "instr[30,25,14-12,3] = xx1000");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX0100";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00110"), "instr[30,25,14-12,3] = xx0100");

		ALUOp <= "11";
		instr_30_25_14_to_12_3 <= "XX0110";
		wait for 10 ns;
		check_equal(ALUControl, std_logic_vector'("00111"), "instr[30,25,14-12,3] = xx0110");

		wait for 10 ns;

		test_runner_cleanup(runner);
	end process;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.ALU_control
		port map (
			ALUOp                  => ALUOp,
			instr_30_25_14_to_12_3 => instr_30_25_14_to_12_3,
			ALUControl             => ALUControl
		);

end architecture testbench;