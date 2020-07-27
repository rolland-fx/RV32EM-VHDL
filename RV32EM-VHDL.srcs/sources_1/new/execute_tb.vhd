--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : execute_tb.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Sat Jul 25 20:25:41 2020
-- Last update : Sun Jul 26 16:37:02 2020
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

entity execute_tb is
	generic (runner_cfg : string);
end entity execute_tb;

-----------------------------------------------------------

architecture testbench of execute_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal EX                        : std_logic_vector(5 downto 0);
	signal PC_in                     : std_logic_vector(31 downto 0);
	signal RD1_in                    : std_logic_vector(31 downto 0);
	signal RD2_in                    : std_logic_vector(31 downto 0);
	signal IMM_in                    : std_logic_vector(31 downto 0);
	signal instr_30_25_14_to_12_3_in : std_logic_vector(5 downto 0);
	signal ALU_OUT_out               : std_logic_vector(31 downto 0);
	signal RD2_out                   : std_logic_vector(31 downto 0);

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

		--wait for 5 ns;

		EX <= "100000";
		PC_in <=  x"00000000";
		RD1_in <= x"00000001";
		RD2_in <= x"00000002";
		IMM_in <= x"00000000";
		instr_30_25_14_to_12_3_in <= "000000";
		wait for 10 ns;
		check_equal(ALU_OUT_out, std_logic_vector'(x"00000003"), "Type I ADD failed");

		wait for 10 ns;

		test_runner_cleanup(runner);
	end process main;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.execute
		port map (
			EX                        => EX,
			PC_in                     => PC_in,
			RD1_in                    => RD1_in,
			RD2_in                    => RD2_in,
			IMM_in                    => IMM_in,
			instr_30_25_14_to_12_3_in => instr_30_25_14_to_12_3_in,
			ALU_OUT_out               => ALU_OUT_out,
			RD2_out                   => RD2_out
		);

end architecture testbench;