--------------------------------------------------------------------------------
-- Title       : ALU_testbench
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca>
-- Company     : École de technologie Superieur
-- Created     : Fri Jul  3 21:46:14 2020
-- Last update : Mon Jul 13 17:47:51 2020
-- Platform    : N/A
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

entity ALU_tb is
	generic (runner_cfg : string);
end entity ALU_tb;

-----------------------------------------------------------

architecture testbench of ALU_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal ALU_control : std_logic_vector(4 downto 0);
	signal opA     : std_logic_vector(31 downto 0);
	signal opB     : std_logic_vector(31 downto 0);
	signal ALU_out : std_logic_vector(31 downto 0);

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

		ALU_control <= "00001"; -- ADD
		opA <= std_logic_vector(to_signed(-10, opA'length));
		opB <= std_logic_vector(to_signed(5, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector(to_signed(-5, ALU_out'length)), "ADD -10 + 5 = -5");

		ALU_control <= "00010"; -- SUB
		opA <= std_logic_vector(to_signed(-5, opA'length));
		opB <= std_logic_vector(to_signed(-20, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector(to_signed(15, ALU_out'length)), "SUB -5 - -20 = 15");

		ALU_control <= "00011"; -- AND
		opA <= x"cccccccc";
		opB <= x"aaaaaaaa";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"88888888"), "AND 0xcccccccc & 0xaaaaaaaa = 0x88888888");

		ALU_control <= "00100"; -- OR
		opA <= x"cccccccc";
		opB <= x"aaaaaaaa";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"eeeeeeee"), "OR 0xcccccccc & 0xaaaaaaaa = 0xeeeeeeee");

		ALU_control <= "00101"; -- XOR
		opA <= x"cccccccc";
		opB <= x"aaaaaaaa";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"66666666"), "XOR 0xcccccccc & 0xaaaaaaaa = 0x66666666");

		ALU_control <= "00110"; -- SLT
		opA <= std_logic_vector(to_signed(-20, opA'length));
		opB <= std_logic_vector(to_signed(-5, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000001"), "SLT -20 < -5 = 1");

		ALU_control <= "00110"; -- SLT
		opA <= std_logic_vector(to_signed(-20, opA'length));
		opB <= std_logic_vector(to_signed(-20, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000000"), "SLT -20 >= -20 = 0");

		ALU_control <= "00110"; -- SLT
		opA <= std_logic_vector(to_signed(-5, opA'length));
		opB <= std_logic_vector(to_signed(-20, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000000"), "SLT -5 >= -20 = 0");

		ALU_control <= "00111"; -- SLTU
		opA <= x"80000000";
		opB <= x"80000001";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000001"), "SLTU 0x80000000 < 0x80000001 = 1");

		ALU_control <= "00111"; -- SLTU
		opA <= x"80000000";
		opB <= x"80000000";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000000"), "SLTU 0x80000000 >= 0x80000000 = 0");

		ALU_control <= "00111"; -- SLTU
		opA <= x"80000001";
		opB <= x"80000000";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"00000000"), "SLTU 0x80000001 >= 0x80000000 = 0");

		ALU_control <= "01000"; -- SLL
		opA <= x"03030303";
		opB <= x"ffffffe2";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"0c0c0c0c"), "SLL 0x03030303 << 2 = 0x0c0c0c0c");

		ALU_control <= "01001"; -- SRL
		opA <= x"83030303";
		opB <= x"ffffffe2";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"20C0C0C0"), "SRL 0x83030303 << 2 = 20c0c0c0");

		ALU_control <= "01010"; -- SRA
		opA <= x"83030303";
		opB <= x"ffffffe2";
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector'(x"e0c0c0c0"), "SRA 0x83030303 << 2 = e0c0c0c0");

		wait for 10 ns;

		test_runner_cleanup(runner);
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.ALU
		port map (
			ALU_control => ALU_control,
			opA     => opA,
			opB     => opB,
			ALU_out => ALU_out
		);

end architecture testbench;