--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : control_unit_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Mon Jul 27 15:41:25 2020
-- Last update : Fri Jul 31 13:02:53 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library vunit_lib;
context vunit_lib.vunit_context;

library demo_lib;
-----------------------------------------------------------

entity control_unit_tb is
	generic (runner_cfg : string);
end entity control_unit_tb;

-----------------------------------------------------------

architecture testbench of control_unit_tb is

	-- Testbench DUT ports
	signal Funct3    : std_logic_vector(2 downto 0);
	signal Opcode    : std_logic_vector(6 downto 0);
	signal Jump      : std_logic;
	signal IF_Flush  : std_logic;
	signal ID_Flush  : std_logic;
	signal EX_Flush  : std_logic;
	signal WB        : std_logic_vector(1 downto 0);
	signal M         : std_logic_vector(1 downto 0);
	signal EX        : std_logic_vector(5 downto 0);
	signal IS_Branch : std_logic;
	signal IS_Jalr   : std_logic;

begin

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	main : process
	begin
		test_runner_setup(runner, runner_cfg);

		wait for 5 ns;
		Funct3 <= "001";
		Opcode <= "1100111";
		wait for 10 ns; --Invalid instruction
		check_equal(Jump,std_logic'('0'),"(Invalid instruction) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(Invalid instruction) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('1'),"(Invalid instruction) ID_Flush = 1");
		check_equal(EX_Flush,std_logic'('1'),"(Invalid instruction) EX_Flush = 1");
		check_equal(WB,std_logic_vector'("00"),"(Invalid instruction) WB = 00");
		check_equal(M,std_logic_vector'("00"),"(Invalid instruction) M = 00");
		check_equal(EX,std_logic_vector'("000000"),"(Invalid instruction) EX = 000000");
		check_equal(IS_Branch,std_logic'('0'),"(Invalid instruction) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(Invalid instruction) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "0110011";
		wait for 10 ns; --R type (ADD)
		check_equal(Jump,std_logic'('0'),"(R type) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(R type) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(R type) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(R type) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(R type) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(R type) M = 00");
		check_equal(EX,std_logic_vector'("100000"),"(R type) EX = 100000");
		check_equal(IS_Branch,std_logic'('0'),"(R type) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(R type) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "1100011";
		wait for 10 ns; --B type (BEQ)
		check_equal(Jump,std_logic'('1'),"(B type) Jump = 1");
		check_equal(IF_Flush,std_logic'('0'),"(B type) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(B type) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(B type) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("00"),"(B type) WB = 00");
		check_equal(M,std_logic_vector'("00"),"(B type) M = 00");
		check_equal(EX,std_logic_vector'("010000"),"(B type) EX = 010000");
		check_equal(IS_Branch,std_logic'('1'),"(B type) IS_Branch = 1");
		check_equal(IS_Jalr,std_logic'('0'),"(B type) IS_Jalr = 0");

		Funct3 <= "010";
		Opcode <= "0100011";
		wait for 10 ns; --S type (SW)
		check_equal(Jump,std_logic'('0'),"(S type) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(S type) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(S type) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(S type) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("01"),"(S type) WB = 01");
		check_equal(M,std_logic_vector'("01"),"(S type) M = 01");
		check_equal(EX,std_logic_vector'("000001"),"(S type) EX = 000001");
		check_equal(IS_Branch,std_logic'('0'),"(S type) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(S type) IS_Jalr = 0");

		Funct3 <= "010";
		Opcode <= "0000011";
		wait for 10 ns; -- Load (LW)
		check_equal(Jump,std_logic'('0'),"(Load) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(Load) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(Load) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(Load) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("11"),"(Load) WB = 11");
		check_equal(M,std_logic_vector'("10"),"(Load) M = 10");
		check_equal(EX,std_logic_vector'("000001"),"(Load) EX = 000001");
		check_equal(IS_Branch,std_logic'('0'),"(Load) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(Load) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "0010011";
		wait for 10 ns; --I type (ADDI)
		check_equal(Jump,std_logic'('0'),"(I type) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(I type) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(I type) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(I type) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(I type) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(I type) M = 00");
		check_equal(EX,std_logic_vector'("100001"),"(I type) EX = 100001");
		check_equal(IS_Branch,std_logic'('0'),"(I type) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(I type) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "0110111";
		wait for 10 ns; --LUI
		check_equal(Jump,std_logic'('0'),"(LUI) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(LUI) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(LUI) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(LUI) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(LUI) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(LUI) M = 00");
		check_equal(EX,std_logic_vector'("001001"),"(LUI) EX = 001001");
		check_equal(IS_Branch,std_logic'('0'),"(LUI) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(LUI) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "0010111";
		wait for 10 ns; --AUIPC
		check_equal(Jump,std_logic'('0'),"(AUIPC) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(AUIPC) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(AUIPC) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(AUIPC) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(AUIPC) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(AUIPC) M = 00");
		check_equal(EX,std_logic_vector'("000101"),"(AUIPC) EX = 000101");
		check_equal(IS_Branch,std_logic'('0'),"(AUIPC) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(AUIPC) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "1101111";
		wait for 10 ns; --JAL
		check_equal(Jump,std_logic'('1'),"(JAL) Jump = 1");
		check_equal(IF_Flush,std_logic'('1'),"(JAL) IF_Flush = 1");
		check_equal(ID_Flush,std_logic'('0'),"(JAL) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(JAL) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(JAL) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(JAL) M = 00");
		check_equal(EX,std_logic_vector'("000110"),"(JAL) EX = 000110");
		check_equal(IS_Branch,std_logic'('0'),"(JAL) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(JAL) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "1100111";
		wait for 10 ns; --JALR
		check_equal(Jump,std_logic'('1'),"(JALR) Jump = 1");
		check_equal(IF_Flush,std_logic'('1'),"(JALR) IF_Flush = 1");
		check_equal(ID_Flush,std_logic'('0'),"(JALR) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(JALR) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("10"),"(JALR) WB = 10");
		check_equal(M,std_logic_vector'("00"),"(JALR) M = 00");
		check_equal(EX,std_logic_vector'("000110"),"(JALR) EX = 000110");
		check_equal(IS_Branch,std_logic'('0'),"(JALR) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('1'),"(JALR) IS_Jalr = 1");

		Funct3 <= "000";
		Opcode <= "0001111";
		wait for 10 ns; --FENCE
		check_equal(Jump,std_logic'('0'),"(FENCE) Jump = 0");
		check_equal(IF_Flush,std_logic'('0'),"(FENCE) IF_Flush = 0");
		check_equal(ID_Flush,std_logic'('0'),"(FENCE) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(FENCE) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("00"),"(FENCE) WB = 00");
		check_equal(M,std_logic_vector'("00"),"(FENCE) M = 00");
		check_equal(EX,std_logic_vector'("000000"),"(FENCE) EX = 000000");
		check_equal(IS_Branch,std_logic'('0'),"(FENCE) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(FENCE) IS_Jalr = 0");

		Funct3 <= "000";
		Opcode <= "1110011";
		wait for 10 ns; --ECALL
		check_equal(Jump,std_logic'('0'),"(ECALL) Jump = 0");
		check_equal(IF_Flush,std_logic'('1'),"(ECALL) IF_Flush = 1");
		check_equal(ID_Flush,std_logic'('0'),"(ECALL) ID_Flush = 0");
		check_equal(EX_Flush,std_logic'('0'),"(ECALL) EX_Flush = 0");
		check_equal(WB,std_logic_vector'("00"),"(ECALL) WB = 00");
		check_equal(M,std_logic_vector'("00"),"(ECALL) M = 00");
		check_equal(EX,std_logic_vector'("000000"),"(ECALL) EX = 000000");
		check_equal(IS_Branch,std_logic'('0'),"(ECALL) IS_Branch = 0");
		check_equal(IS_Jalr,std_logic'('0'),"(ECALL) IS_Jalr = 0");

		test_runner_cleanup(runner);
	end process main;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.control_unit
		port map (
			Funct3    => Funct3,
			Opcode    => Opcode,
			Jump      => Jump,
			IF_Flush  => IF_Flush,
			ID_Flush  => ID_Flush,
			EX_Flush  => EX_Flush,
			WB        => WB,
			M         => M,
			EX        => EX,
			IS_Branch => IS_Branch,
			IS_Jalr   => IS_Jalr
		);

end architecture testbench;