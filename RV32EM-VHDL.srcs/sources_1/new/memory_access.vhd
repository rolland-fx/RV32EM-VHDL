----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 06:48:07 PM
-- Design Name: 
-- Module Name: memory_access - Behavioral
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

entity memory_access is
  Port (
  		ALU_OUT_in : in std_logic_vector(31 downto 0);
		ALU_IN2_in : in std_logic_vector(31 downto 0);
		RI_in      : in std_logic_vector(31 downto 0);

		DATA_out : out std_logic_vector(31 downto 0);
		ADDR_out : out std_logic_vector(31 downto 0);
		RI_out : out std_logic_vector(31 downto 0)
   );
end memory_access;

architecture Behavioral of memory_access is

begin


end Behavioral;
