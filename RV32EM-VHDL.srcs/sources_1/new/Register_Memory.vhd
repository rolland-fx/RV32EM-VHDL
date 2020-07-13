--------------------------------------------------------------------------------
-- Simple Dual-Port Block RAM with One Clock
-- Correct modelization with a shared variable
-- Adapted from Xilinx UG901 p.116
--
-- author : Simon
-- date : Wed 01 May 2019 11:02:37 PM EDT
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_Memory is
  generic (
    address_width : integer;
    data_width    : integer;
    depth         : integer
  );
  port (
    clk     : in std_logic;
    we      : in std_logic;
    R_Reg_1 : in std_logic_vector(address_width-1 downto 0);
    R_Reg_2 : in std_logic_vector(address_width-1 downto 0);
    W_Reg   : in std_logic_vector(address_width-1 downto 0);
    W_Data  : in std_logic_vector(data_width-1 downto 0);

    R_Data_1 : out std_logic_vector(data_width-1 downto 0);
    R_Data_2 : out std_logic_vector(data_width-1 downto 0)
  );
end Register_Memory;

architecture rtl of Register_Memory is
  type ram_type is array (depth-1 downto 0) of std_logic_vector(data_width-1 downto 0);
  shared variable RAM : ram_type := (others => (others => '0')) ;

begin
  process(clk)
  begin
    if clk'event and clk = '1' then
     R_Data_1 <= RAM(to_integer(unsigned(R_Reg_1)));
     R_Data_2 <= RAM(to_integer(unsigned(R_Reg_2)));
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '0' then
      if we = '1' then
        RAM(to_integer(unsigned(W_Reg))) := W_Data;
      end if;
    end if;
  end process;

end rtl;
