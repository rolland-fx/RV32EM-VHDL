library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.part.all;
-----------------------------------------------------------

entity IF_stage_tb is
end entity IF_stage_tb;

-----------------------------------------------------------

architecture testbench of IF_stage_tb is

	-- Testbench DUT ports
	signal PC_in  : std_logic_vector(8-1 downto 0) := (others => '0');
	signal Instr_out  : std_logic_vector(32-1 downto 0) := (others => '0');


begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	main : process
	begin
        PC_in <= X"00";
		wait for 10 ns;
        PC_in <= X"01";
		wait for 10 ns;
        PC_in <= X"02";
		wait for 10 ns;
        PC_in <= X"03";
		wait for 10 ns;
        PC_in <= X"04";
		wait for 10 ns;
        PC_in <= X"05";
		wait for 10 ns;
        PC_in <= X"06";
		wait for 10 ns;
        PC_in <= X"07";
		wait for 10 ns;
        PC_in <= X"08";
		wait for 10 ns;
        PC_in <= X"09";
		wait for 10 ns;
        PC_in <= X"0a";
		wait for 10 ns;
        PC_in <= X"0b";
		wait for 10 ns;
        PC_in <= X"0c";
		wait for 10 ns;
        PC_in <= X"0d";
		wait for 10 ns;
        PC_in <= X"0e";
		wait;
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
DUT : Instruction_Memory
  PORT MAP (
    a => PC_in,
    spo => Instr_out
  );

end architecture testbench;