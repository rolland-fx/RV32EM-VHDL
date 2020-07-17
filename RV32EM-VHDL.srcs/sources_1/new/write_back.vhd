--------------------------------------------------------------------------------
-- Title       : Write Back Stage
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : write_back.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca
-- Company     : École de technologie supérieur
-- Created     : Fri Jul 17 12:02:44 2020
-- Last update : Fri Jul 17 12:07:53 2020
-- Platform    : NùA
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.part.all;

entity write_back is
	port (
		WB         : in  std_logic_vector(1 downto 0);
		DATA_in    : in  std_logic_vector(31 downto 0);
		ALU_OUT_in : in  std_logic_vector(31 downto 0);
		DATA_out   : out std_logic_vector(31 downto 0)
	);
end entity write_back;

architecture rtl of write_back is
	signal MemToReg : std_logic;
begin
	MemToReg <= WB(0);

	with MemToReg select
	DATA_out <=
		DATA_in         when '1',
		ALU_OUT_in      when '0',
		(others => '0') when others;

end architecture rtl;