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
  signal Opcode_interne : std_logic_vector (6 downto 0);
begin

  Opcode_interne <= Instr(6 downto 0);

  Opcode <= Opcode_interne;
  Rd     <= Instr(11 downto 7);
  Funct3 <= Instr(14 downto 12);
  Rs1    <= Instr(19 downto 15);
  Rs2    <= Instr(24 downto 20);
  Funct7 <= Instr(31 downto 25);

  with Opcode_interne select
  Imm <=
    (others => '0')                                                                                   when "0110011",
    (x"00000" & Instr(31 downto 20))                                                                  when "0000011",
    (x"00000" & Instr(31 downto 20))                                                                  when "0001111",
    (x"00000" & Instr(31 downto 20))                                                                  when "0010011",
    (x"00000" & Instr(31 downto 20))                                                                  when "1100111",
    (x"00000" & Instr(31 downto 20))                                                                  when "1110011",
    (x"00000" & Instr(31 downto 25) & Instr(11 downto 7))                                             when "0100011",
    (b"0000000000000000000" & Instr(31) & Instr(7) & Instr(30 downto 25) & Instr(11 downto 8) & b"0") when "1100011",
    (Instr(31 downto 12) & x"000")                                                                    when "0010111",
    (Instr(31 downto 12) & x"000")                                                                    when "0110111",
    (b"00000000000" & Instr(31) & Instr(19 downto 12) & Instr(20) & Instr(30 downto 21) & b"0")       when "1101111",
    (others => '0')                                                                                   when others;
end Behavioral;