--------------------------------------------------------------------------------
-- Title       : Instruction Fetch
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : instruction_fetch.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Jun 30 17:59:58 2020
-- Last update : Tue Jun 30 18:08:37 2020
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_fetch is
	Port (
		PC_in : in std_logic_vector(31 downto 0);
		RI_in : in std_logic_vector(31 downto 0);

		PC_out : out std_logic_vector(31 downto 0);
		RI_out  : out std_logic_vector(31 downto 0)
	);
end instruction_fetch;

architecture Behavioral of instruction_fetch is

begin


end Behavioral;
