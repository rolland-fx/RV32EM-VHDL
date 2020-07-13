library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory_synthetisable is
	port (
		address     : in  std_logic_vector(11 downto 0);
		instruction : out std_logic_vector(31 downto 0)
	);
end Instruction_Memory_synthetisable;

architecture rtl of Instruction_Memory_synthetisable is

	constant rom_depth : natural := 256;
	constant rom_width : natural := 32;
	type rom_type is array (0 to rom_depth - 1) of std_logic_vector(rom_width - 1 downto 0);

	signal instr_rom : rom_type;
begin
	instruction <= instr_rom(to_integer(unsigned(address)));
end;






