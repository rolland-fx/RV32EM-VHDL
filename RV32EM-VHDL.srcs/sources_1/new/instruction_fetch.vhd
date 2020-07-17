--------------------------------------------------------------------------------
-- Title       : Instruction Fetch
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : instruction_fetch.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Jun 30 17:59:58 2020
-- Last update : Fri Jul 17 12:25:36 2020
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.part.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_fetch is
	Port (
		clk       : in  std_logic;
		PC_in     : in  std_logic_vector(31 downto 0);
		INSTR_out : out std_logic_vector(31 downto 0)
	);
end instruction_fetch;

architecture Behavioral of instruction_fetch is

begin

	data_memory_1 : data_memory
		generic map (
			address_size => 12,
			data_size    => 32,
			memory_size  => 4096
		)
		port map (
			clk        => clk,
			MemRead    => std_logic'('1'),
			MemWrite   => std_logic'('0'),
			address    => PC_in(11 downto 0),
			write_data => (others => '0'),
			read_data  => INSTR_out
		);

end Behavioral;
