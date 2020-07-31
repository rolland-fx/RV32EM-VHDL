--------------------------------------------------------------------------------
-- Title       : Instruction memory testbench
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : Instruction_Memory_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Sat Jul 25 20:47:29 2020
-- Last update : Thu Jul 30 15:29:08 2020
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

entity Instruction_Memory_tb is
	generic (runner_cfg : string);
end entity Instruction_Memory_tb;

-----------------------------------------------------------

architecture testbench of Instruction_Memory_tb is

	-- Testbench DUT generics
	constant address_size : integer := 32;
	constant data_size    : integer := 32;
	constant memory_size  : integer := 20;

	-- Testbench DUT ports
	signal PC_in     : STD_LOGIC_VECTOR(address_size-1 DOWNTO 0);
	signal Instr_OUT : STD_LOGIC_VECTOR(data_size-1 DOWNTO 0);

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

		wait for 5 ns;

		PC_in <= x"00000000";
		wait for 10 ns;
		check_equal(Instr_OUT, std_logic_vector'(x"00000597"));

		PC_in <= x"00000004";
		wait for 10 ns;
		check_equal(Instr_OUT, std_logic_vector'(x"00058593"));

		test_runner_cleanup(runner);
	end process;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Instruction_Memory
		generic map (
			address_size => address_size,
			data_size    => data_size,
			memory_size  => memory_size
		)
		port map (
			PC_in     => PC_in,
			Instr_OUT => Instr_OUT
		);

end architecture testbench;