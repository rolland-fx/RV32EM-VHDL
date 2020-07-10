library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package part is

	component instruction_fetch is
		port (
			PC_out : out std_logic_vector(31 downto 0);
			RI_out : out std_logic_vector(31 downto 0)
		);
	end component instruction_fetch;

	component instruction_decode is
		port (
			PC_in                      : in  std_logic_vector(31 downto 0);
			RI_in                      : in  std_logic_vector(31 downto 0);
			PC_out                     : out std_logic_vector(31 downto 0);
			RD1_out                    : out std_logic_vector(31 downto 0);
			RD2_out                    : out std_logic_vector(31 downto 0);
			IMM_out                    : out std_logic_vector(31 downto 0);
			instr_30_25_14_to_12_3_out : out std_logic_vector(5 downto 0);
			s_i_ID_instr_11_to_7_out   : out std_logic_vector(4 downto 0)
		);
	end component instruction_decode;	

	component execute is
		port (
			EX                        : in  std_logic_vector(5 downto 0);
			PC_in                     : in  std_logic_vector(31 downto 0);
			RD1_in                    : in  std_logic_vector(31 downto 0);
			RD2_in                    : in  std_logic_vector(31 downto 0);
			IMM_in                    : in  std_logic_vector(31 downto 0);
			instr_30_25_14_to_12_3_in : in  std_logic_vector(5 downto 0);
			ALU_OUT_out               : out std_logic_vector(31 downto 0);
			RD2_out                   : out std_logic_vector(31 downto 0)
		);
	end component execute;

	component memory_access is
		port (
			ALU_OUT_in       : in  std_logic_vector(31 downto 0);
			RD2_in           : in  std_logic_vector(31 downto 0);
			instr_11_to_7_in : in  std_logic_vector(4 downto 0);
			DATA_out         : out std_logic_vector(31 downto 0);
			ADDR_out         : out std_logic_vector(31 downto 0);
			RI_out           : out std_logic_vector(31 downto 0)
		);
	end component memory_access;	

	component ALU is
		port (
			ALU_control : in  std_logic_vector(4 downto 0);
			opA         : in  std_logic_vector(31 downto 0);
			opB         : in  std_logic_vector(31 downto 0);
			ALU_out     : out std_logic_vector(31 downto 0)
		);
	end component ALU;	

	component ALU_control is
		port (
			ALUOp                  : in  std_logic_vector(1 downto 0);
			instr_30_25_14_to_12_3 : in  std_logic_vector(5 downto 0);
			ALUControl             : out std_logic_vector(4 downto 0)
		);
	end component ALU_control;	
end package part;