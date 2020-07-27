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

library work;
use work.part.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity execute is
	Port (
		EX                        : in std_logic_vector(5 downto 0);
		PC_in                     : in std_logic_vector(31 downto 0);
		RD1_in                    : in std_logic_vector(31 downto 0);
		RD2_in                    : in std_logic_vector(31 downto 0);
		IMM_in                    : in std_logic_vector(31 downto 0);
		instr_30_25_14_to_12_3_in : in std_logic_vector(5 downto 0);

		ALU_OUT_out : out std_logic_vector(31 downto 0);
		RD2_out     : out std_logic_vector(31 downto 0)
	);
end execute;

architecture Behavioral of execute is
	signal ALUcontrol_sig : std_logic_vector(4 downto 0);
	signal opA_mux        : std_logic_vector(31 downto 0);
	signal opB_mux        : std_logic_vector(31 downto 0);

begin

	with EX(3 downto 2) select
	opA_mux <=
		RD1_in          when "00",
		PC_in           when "01",
		(others => '0') when others;

	with EX(1 downto 0) select
	opB_mux <=
		RD2_in          when "00",
		IMM_in          when "01",
		x"00000004"     when "10",
		(others => '1') when others;

	RD2_out <= RD2_in;

	DUT_ALU_control : ALU_control
		port map (
			ALUOp                  => EX(5 downto 4),
			instr_30_25_14_to_12_3 => instr_30_25_14_to_12_3_in,
			ALUControl             => ALUcontrol_sig
		);

	DUT_ALU : ALU
		port map (
			ALU_control => ALUcontrol_sig,
			opA         => opA_mux,
			opB         => opB_mux,
			ALU_out     => ALU_OUT_out
		);

end Behavioral;
