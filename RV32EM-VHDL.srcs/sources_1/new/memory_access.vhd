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

library work;
use work.part.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_access is
	Port (
		clk              : in std_logic;
		M                : in std_logic_vector(1 downto 0);
		ALU_OUT_in       : in std_logic_vector(31 downto 0);
		RD2_in           : in std_logic_vector(31 downto 0);

		DATA_out : out std_logic_vector(31 downto 0);
		ADDR_out : out std_logic_vector(31 downto 0)
	);
end memory_access;

architecture Behavioral of memory_access is
	signal MemWrite : std_logic;
	signal MemRead  : std_logic;

begin

	MemRead  <= M(1);
	MemWrite <= M(0);

	ADDR_out <= ALU_OUT_in;

	data_memory_1 : data_memory
		generic map (
			address_size => 12,
			data_size    => 32,
			memory_size  => 4096
		)
		port map (
			clk        => clk,
			MemRead    => MemRead,
			MemWrite   => MemWrite,
			address    => ALU_OUT_in(11 downto 0),
			write_data => RD2_in,
			read_data  => DATA_out
		);

end Behavioral;
