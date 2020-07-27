--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : data_memory_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Mon Jul 13 11:47:11 2020
-- Last update : Mon Jul 27 18:58:43 2020
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

library vunit_lib;
context vunit_lib.vunit_context;

library demo_lib;
-----------------------------------------------------------

entity data_memory_tb is
	generic (runner_cfg : string);
end entity data_memory_tb;

-----------------------------------------------------------

architecture testbench of data_memory_tb is

	-- Testbench DUT generics
	constant address_size : integer := 32;
	constant data_size    : integer := 32;
	constant memory_size  : integer := 64;

	-- Testbench DUT ports
	signal clk        : std_logic;
	signal MemRead    : std_logic;
	signal MemWrite   : std_logic;
	signal address    : std_logic_vector(address_size-1 downto 0);
	signal write_data : std_logic_vector(data_size-1 downto 0);
	signal read_data  : std_logic_vector(data_size-1 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks
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

		wait for 5 ns;

		MemRead <= '0';
		MemWrite <= '1';
		address <= x"00000036"; --adresse : 54
		write_data <= X"05F13F87"; --data : 99696519
		wait for 10 ns;

		MemRead <= '1';
		MemWrite <= '0';
		address <= x"00000036"; --adresse : 54
		write_data <= X"00010F07"; --data : 69383
		wait for 10 ns;
		check_equal(read_data,99696519,"adresse(54) : good data");

		MemRead <= '0';
		MemWrite <= '1';
		address <= x"00000037"; --adresse : 55
		write_data <= X"00010F07"; --data : 69383
		wait for 10 ns;

		MemRead <= '1';
		MemWrite <= '0';
		address <= x"00000037"; --adresse : 55
		write_data <= X"01010F07"; --data : 16846599
		wait for 10 ns;
		check_equal(read_data,69383,"adresse(55) : good data");

		test_runner_cleanup(runner);
	end process main;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.data_memory
		generic map (
			address_size => address_size,
			data_size    => data_size,
			memory_size  => memory_size
		)
		port map (
			clk        => clk,
			MemRead    => MemRead,
			MemWrite   => MemWrite,
			address    => address,
			write_data => write_data,
			read_data  => read_data
		);

end architecture testbench;