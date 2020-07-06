library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

library demo_lib;
-----------------------------------------------------------

entity Instr_Decode_tb is
	generic (runner_cfg : string);
end entity Instr_Decode_tb;

-----------------------------------------------------------

architecture testbench of Instr_Decode_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal Instr  : std_logic_vector(31 downto 0);
	signal Opcode : std_logic_vector(6 downto 0);
	signal Rd     : std_logic_vector(4 downto 0);
	signal Funct3 : std_logic_vector(2 downto 0);
	signal Rs1    : std_logic_vector(4 downto 0);
	signal Rs2    : std_logic_vector(4 downto 0);
	signal Funct7 : std_logic_vector(6 downto 0);
	signal Imm    : std_logic_vector(31 downto 0);

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

		Instr <= "00000000000100000000010000010011";
		wait for 10 ns;
		check_equal(Opcode  , 19      , "Opcode : OK");
		check_equal(Rd      , 8        , "Rd     : OK");
		check_equal(Funct3  , 0          , "Funct3 : OK");
		check_equal(Rs1     , 0       , "Rs1    : OK");
		check_equal(Imm     , 1 , "Imm    : OK");

		test_runner_cleanup(runner);
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Instr_Decode
		port map (
			Instr  => Instr,
			Opcode => Opcode,
			Rd     => Rd,
			Funct3 => Funct3,
			Rs1    => Rs1,
			Rs2    => Rs2,
			Funct7 => Funct7,
			Imm    => Imm
		);

end architecture testbench;