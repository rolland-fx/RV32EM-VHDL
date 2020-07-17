library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Branch_Cmp is
  Port(
    Is_Branch : in std_logic;
    Funct3    : in std_logic_vector(2 downto 0);
    R_Data_1  : in std_logic_vector(31 downto 0);
    R_Data_2  : in std_logic_vector(31 downto 0);

    Branch_Cmp_Out : out std_logic
  );
end Branch_Cmp;
architecture Behavioral of Branch_Cmp is

  signal IsBEQ       : std_logic;
  signal IsBNE       : std_logic;
  signal IsBLT       : std_logic;
  signal IsBGE       : std_logic;
  signal IsBLTU      : std_logic;
  signal IsBGEU      : std_logic;
  signal Branch_True : std_logic;
begin

  IsBEQ  <= '1' when signed(R_Data_1) = signed(R_Data_2) else '0';
  IsBLT  <= '1' when signed(R_Data_1) < signed(R_Data_2) else '0';
  IsBNE  <= '1' when signed(R_Data_1) /= signed(R_Data_2) else '0';
  IsBGE  <= '1' when signed(R_Data_1) >= signed(R_Data_2) else '0';
  IsBLTU <= '1' when R_Data_1 < R_Data_2 else '0';
  IsBGEU <= '1' when R_Data_1 >= R_Data_2 else '0';

  with Funct3 select
  Branch_True <=
    IsBEQ  when "000",
    IsBNE  when "001",
    IsBLT  when "100",
    IsBGE  when "101",
    IsBLTU when "110",
    IsBGEU when "111",
    '0'    when others;

  Branch_Cmp_Out <= Is_Branch AND Branch_True;

end Behavioral;