library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
	port (
		address     : in  std_logic_vector(11 downto 0);
		instruction : out std_logic_vector(31 downto 0);
	);
end Instruction_Memory;

architecture rtl of Instruction_Memory is

	constant rom_depth : natural := 256;
	constant rom_width : natural := 32;
	type ram_type is array (0 to ram_depth - 1) of std_logic_vector(ram_width - 1 downto 0);

	signal instr_ram : ram_type := init_instruction_memory;
begin
	instruction <= instr_ram(address);
end;






