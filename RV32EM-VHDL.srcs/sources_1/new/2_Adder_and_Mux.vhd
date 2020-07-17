library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder_and_Mux is
  Port(
    PC        : in std_logic_vector(31 downto 0);
    Shift_Imm : in std_logic_vector(31 downto 0);
    Imm       : in std_logic_vector(31 downto 0);
    R_Data_1  : in std_logic_vector(31 downto 0);
    Is_JalR   : in std_logic;

    Jump_Target_Address : out std_logic_vector(31 downto 0)
  );
end Adder_and_Mux;
architecture Behavioral of Adder_and_Mux is
begin

Jump_Target_Address  <= PC + Shift_Imm when Is_JalR = '0' else
                        Imm + R_Data_1;

end Behavioral;