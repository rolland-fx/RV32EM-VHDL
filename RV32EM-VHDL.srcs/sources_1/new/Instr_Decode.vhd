library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Instr_Decode is
  Port(
    Instr : in std_logic_vector(31 downto 0);

    Opcode : out std_logic_vector(6 downto 0);
    Rd     : out std_logic_vector(4 downto 0);
    Funct3 : out std_logic_vector(2 downto 0);
    Rs1    : out std_logic_vector(4 downto 0);
    Rs2    : out std_logic_vector(4 downto 0);
    Funct7 : out std_logic_vector(6 downto 0);
    Imm    : out std_logic_vector(31 downto 0)
  );
end Instr_Decode;
architecture Behavioral of Instr_Decode is
begin

main_process : process(Instr)
begin
      Opcode <= Instr(6 downto 0);
      Rd     <= Instr(11 downto 7);
      Funct3 <= Instr(14 downto 12);
      Rs1    <= Instr(19 downto 15);
      Rs2    <= Instr(24 downto 20);
      Funct7 <= Instr(31 downto 25);

       if Instr(6 downto 0) = b"0110011"  then
			Imm <= (others => '0');
	   elsif Instr(6 downto 0) = b"0000011" or Instr(6 downto 0) = b"0001111" or Instr(6 downto 0) = b"0010011" or Instr(6 downto 0) = b"1100111" or Instr(6 downto 0) = b"1110011" then
	        Imm <= x"00000" & Instr(31 downto 20);
	   elsif Instr(6 downto 0) = b"0100011" then
	        Imm <= x"00000" & Instr(31 downto 25) & Instr(11 downto 7);
	   elsif Instr(6 downto 0) = b"1100011" then
	        Imm <= b"0000000000000000000" & Instr(31) & Instr(7) & Instr(30 downto 25) & Instr(11 downto 8) & b"0";
	   elsif Instr(6 downto 0) = b"0010111" or Instr(6 downto 0) = b"0110111" then
	       Imm <= Instr(31 downto 12) & x"000";
	   elsif Instr(6 downto 0) = b"1101111" then
	       Imm <= b"00000000000" & Instr(31) & (Instr(19 downto 12)) & Instr(20) & Instr(30 downto 21) & b"0";
	   else
	       Imm <= (others => '0');
	   end if;
      


end process;
end Behavioral;