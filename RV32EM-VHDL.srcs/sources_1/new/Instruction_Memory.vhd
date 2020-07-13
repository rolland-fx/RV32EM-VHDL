library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity Instruction_Memory is
	port (
		address     : in  std_logic_vector(11 downto 0);
		instruction : out std_logic_vector(31 downto 0);
	);
end Instruction_Memory;

architecture rtl of Instruction_Memory is

	constant File_name : text := "Instruction_file.txt";

	constant rom_depth : natural := 256;
	constant rom_width : natural := 32;
	type ram_type is array (0 to ram_depth - 1) of std_logic_vector(ram_width - 1 downto 0);


	-- La fonction ci-dessous n'est pas synthetisable. Elle est ici, seulement pour des fins de tests.
	function init_instruction_memory return ram_type is
		file file            : text open read mode is File_name;
		variable value_read  : line;
		variable rom_content : rom_type;
	begin
		for i in 0 to ram_depth - 1 identifier : loop
			readline(file, value_read);
			hread(value_read, rom_content(i));
		end loop ; -- identifier
		return rom_content;
	end function;

	signal instr_ram : ram_type := init_instruction_memory;
begin
	instruction <= instr_ram(address);
end;






