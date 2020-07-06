library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mux_type;


entity mux is
  generic(
    NUM : integer := 2; -- number of input
	SEL : integer := 1); -- size of the input sel bus
  port(
    i_input   : in mux_type.t_array(0 to NUM - 1);
    i_sel     : in std_logic_vector(SEL - 1 downto 0);
    s_output   : out std_logic_vector(31 downto 0));
end entity;

architecture rtl of mux is
begin
  s_output <= i_input(to_integer(unsigned(i_sel)));
end architecture;