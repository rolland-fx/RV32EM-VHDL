--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : Main_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Mon Jul 27 19:05:12 2020
-- Last update : Mon Jul 27 22:01:11 2020
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

entity Main_tb is

	generic (runner_cfg : string);

end entity Main_tb;

-----------------------------------------------------------

architecture testbench of Main_tb is

	-- Testbench DUT ports
	signal clk : STD_LOGIC;

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	main : process
	begin
		test_runner_setup(runner, runner_cfg);

		wait for 500000 ns;

		test_runner_cleanup(runner);
	end process;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Main
		port map (
			i_clk => clk
		);

end architecture testbench;