--------------------------------------------------------------------------------
-- Title       : ALU_testbench
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca>
-- Company     : École de technologie Superieur
-- Created     : Fri Jul  3 21:46:14 2020
-- Last update : Fri Jul  3 22:56:45 2020
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
	signal control : std_logic_vector(4 downto 0);
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

		control <= "00001"; -- ADD
		opA <= std_logic_vector(to_signed(-10, opA'length));
		opB <= std_logic_vector(to_signed(5, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector(to_signed(-5, ALU_out'length)), "ADD -10 + 5 = -5");

		control <= "00000"; -- ADDI
		opA <= std_logic_vector(to_signed(5, opA'length));
		--opB <= std_logic_vector(to_signed(-20, opB'length));
		opB(11 downto 0) <= std_logic_vector(to_signed(-20, 12));
		opB(31 downto 12) <= (others => '0');
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector(to_signed(-15, ALU_out'length)), "ADDI 5 + -20 = -15");

		control <= "00011"; -- SUB
		opA <= std_logic_vector(to_signed(-5, opA'length));
		opB <= std_logic_vector(to_signed(-20, opB'length));
		wait for 10 ns;
		check_equal(ALU_out, std_logic_vector(to_signed(15, ALU_out'length)), "SUB -5 - -20 = 15");

		wait for 10 ns;

		test_runner_cleanup(runner);
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.ALU
		port map (
			control => control,
			opA     => opA,
			opB     => opB,
			ALU_out => ALU_out
		);

end architecture testbench;