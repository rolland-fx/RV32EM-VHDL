----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 06:38:43 PM
-- Design Name: 
-- Module Name: execute - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity execute is
	Port (
		PC_out : in std_logic_vector(31 downto 0);
		RD1_in : in std_logic_vector(31 downto 0);
		RD2_in : in std_logic_vector(31 downto 0);
		IMM_in : in std_logic_vector(31 downto 0);
		RI_in  : in std_logic_vector(31 downto 0);

		ALU_OUT_out : out std_logic_vector(31 downto 0);
		ALU_IN2_out : out std_logic_vector(31 downto 0);
		RI_out      : out std_logic_vector(31 downto 0)
	);
end execute;

architecture Behavioral of execute is

begin


end Behavioral;
