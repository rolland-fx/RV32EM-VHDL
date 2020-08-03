--------------------------------------------------------------------------------
-- Title       : Hazard Detection Unit tesbench
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : Hazard_detection_unit.vhd
-- Author      : Francois-Xavier Rolland (francois-xavier.rolland.1@ens.etsmtl.ca)
-- Company     : École de technologie supérieur
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

entity Hazard_detection_unit_tb is
	generic (runner_cfg : string);
end entity Hazard_detection_unit_tb;

-----------------------------------------------------------

architecture testbench of Hazard_detection_unit_tb is

	-- Testbench DUT ports
	signal	IF_Instruction_RS1 :  std_logic_vector(4 downto 0);
	signal	IF_Instruction_RS2 :  std_logic_vector(4 downto 0);
	signal	ID_Instruction_RD  :  std_logic_vector(4 downto 0);
	signal	EX_Instruction_RD  :  std_logic_vector(4 downto 0);
	signal	ID_MemRead         :  std_logic;
	signal	ID_RegWrite        :  std_logic;
	signal	EX_RegWrite        :  std_logic;
	signal	IF_Stall           :  std_logic;
	signal	ID_Stall           :  std_logic;


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

		IF_Instruction_RS1 <= "00001";
		IF_Instruction_RS2 <= "00010";
		ID_Instruction_RD <=  "00001";
		EX_Instruction_RD <=  "00111";
		ID_MemRead <= '1';
		ID_RegWrite <= '0';
		EX_RegWrite <= '0';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS1=RD");
		
		IF_Instruction_RS1 <= "00001";
		IF_Instruction_RS2 <= "00010";
		ID_Instruction_RD <=  "00010";
		EX_Instruction_RD <=  "00011";
		ID_MemRead <= '1';
		ID_RegWrite <= '0';
		EX_RegWrite <= '0';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS2=RD");
		
		IF_Instruction_RS1 <= "00001";
		IF_Instruction_RS2 <= "00010";
		ID_Instruction_RD <=  "00001";
		EX_Instruction_RD <=  "00111";
		ID_MemRead <= '0';
		ID_RegWrite <= '1';
		EX_RegWrite <= '0';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS1=RD");
		
		IF_Instruction_RS1 <= "00001";
		IF_Instruction_RS2 <= "00010";
		ID_Instruction_RD <=  "00010";
		EX_Instruction_RD <=  "00011";
		ID_MemRead <= '0';
		ID_RegWrite <= '1';
		EX_RegWrite <= '0';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS2=RD");
		
		IF_Instruction_RS1 <= "00011";
		IF_Instruction_RS2 <= "00000";
		ID_Instruction_RD <=  "00001";
		EX_Instruction_RD <=  "00011";
		ID_MemRead <= '0';
		ID_RegWrite <= '0';
		EX_RegWrite <= '1';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS1=RD");
		
		IF_Instruction_RS1 <= "00001";
		IF_Instruction_RS2 <= "00010";
		ID_Instruction_RD <=  "00011";
		EX_Instruction_RD <=  "00010";
		ID_MemRead <= '0';
		ID_RegWrite <= '0';
		EX_RegWrite <= '1';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('1'),"RS2=RD");
		
		IF_Instruction_RS1 <=  "00000";
		IF_Instruction_RS2 <=  "00001";
		ID_Instruction_RD <=   "00000";
		EX_Instruction_RD <=   "00011";
		ID_MemRead <= '0';
		ID_RegWrite <= '0';
		EX_RegWrite <= '1';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('0'),"RS1=RD=0");
		
		IF_Instruction_RS1 <=  "00001";
		IF_Instruction_RS2 <=  "00010";
		ID_Instruction_RD <=   "00011";
		EX_Instruction_RD <=   "00100";
		ID_MemRead <= '1';
		ID_RegWrite <= '0';
		EX_RegWrite <= '0';
		
		wait for 10 ns;
		check_equal(IF_Stall, std_logic'('0'),"No hazard");


		wait for 10 ns;

		test_runner_cleanup(runner);
	end process main;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Hazard_detection_unit
		port map (
		IF_Instruction_RS1 => IF_Instruction_RS1,
		IF_Instruction_RS2 => IF_Instruction_RS2,
		ID_Instruction_RD  => ID_Instruction_RD,
		EX_Instruction_RD  => EX_Instruction_RD,
		ID_MemRead         => ID_MemRead,
		ID_RegWrite        => ID_RegWrite,
		EX_RegWrite        => EX_RegWrite,
		IF_Stall           => IF_Stall,
		ID_Stall           => ID_Stall
		);

end architecture testbench;