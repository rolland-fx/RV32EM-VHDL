library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package part is


    COMPONENT Branch_Compare
      Port(
        Is_Branch : in std_logic;
        Funct3    : in std_logic_vector(2 downto 0);
        R_Data_1  : in std_logic_vector(31 downto 0);
        R_Data_2  : in std_logic_vector(31 downto 0);
    
        Branch_Cmp_Out : out std_logic
      );
    END COMPONENT;
    
    COMPONENT Instruction_Memory
	generic (
		address_size : integer;
		data_size    : integer;
		memory_size  : integer 
	);
      PORT (
        PC_in : IN STD_LOGIC_VECTOR(address_size-1 DOWNTO 0);
        Instr_OUT : OUT STD_LOGIC_VECTOR(data_size-1 DOWNTO 0)
      );
    END COMPONENT;
    
	component instruction_fetch is
		port (
			clk       : in  std_logic;
			PC_in     : in  std_logic_vector(31 downto 0);
			INSTR_out : out std_logic_vector(31 downto 0)
		);
	end component instruction_fetch;	

	component instruction_decode is
		port (
			clk                        : in  std_logic;
			isJALR                     : in  std_logic;
			regWrite_in                : in  std_logic;
			PC_in                      : in  std_logic_vector(31 downto 0);
			instr_in                   : in  std_logic_vector(31 downto 0);
			write_reg_in               : in  std_logic_vector(4 downto 0);
			write_data_in              : in  std_logic_vector(31 downto 0);
			PC_out                     : out std_logic_vector(31 downto 0);
			RD1_out                    : out std_logic_vector(31 downto 0);
			RD2_out                    : out std_logic_vector(31 downto 0);
			IMM_out                    : out std_logic_vector(31 downto 0);
			instr_30_25_14_to_12_3_out : out std_logic_vector(5 downto 0);
			instr_11_to_7_out          : out std_logic_vector(4 downto 0);
			jump_out                   : out std_logic_vector(31 downto 0)
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
			clk              : in  std_logic;
			M                : in  std_logic_vector(1 downto 0);
			ALU_OUT_in       : in  std_logic_vector(31 downto 0);
			RD2_in           : in  std_logic_vector(31 downto 0);
			DATA_out         : out std_logic_vector(31 downto 0);
			ADDR_out         : out std_logic_vector(31 downto 0)
		);
	end component memory_access;

	component write_back is
		port (
			WB         : in  std_logic_vector(1 downto 0);
			DATA_in    : in  std_logic_vector(31 downto 0);
			ALU_OUT_in : in  std_logic_vector(31 downto 0);
			DATA_out   : out std_logic_vector(31 downto 0)
		);
	end component write_back;	

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

	component imm_gen is
		port (
			instruction : in  std_logic_vector(31 downto 0);
			imm         : out std_logic_vector(31 downto 0)
		);
	end component imm_gen;

	component Register_Memory is
		generic (
			address_width : integer;
			data_width    : integer;
			depth         : integer
		);
		port (
			clk      : in  std_logic;
			we       : in  std_logic;
			R_Reg_1  : in  std_logic_vector(address_width-1 downto 0);
			R_Reg_2  : in  std_logic_vector(address_width-1 downto 0);
			W_Reg    : in  std_logic_vector(address_width-1 downto 0);
			W_Data   : in  std_logic_vector(data_width-1 downto 0);
			R_Data_1 : out std_logic_vector(data_width-1 downto 0);
			R_Data_2 : out std_logic_vector(data_width-1 downto 0)
		);
	end component Register_Memory;

	component control_unit is
		port (
			Funct3    : in  std_logic_vector(2 downto 0);
			Opcode    : in  std_logic_vector(6 downto 0);
			Exception : out std_logic;
			Jump      : out std_logic;
			IF_Flush  : out std_logic;
			ID_Flush  : out std_logic;
			EX_Flush  : out std_logic;
			WB        : out std_logic_vector(1 downto 0);
			M         : out std_logic_vector(1 downto 0);
			EX        : out std_logic_vector(5 downto 0);
			IS_Branch : out std_logic;
			IS_Jalr   : out std_logic
		);
	end component control_unit;	

	component Hazard_detection_unit is
		port (
			IF_Instruction_RS1 : in  std_logic_vector(4 downto 0);
			IF_Instruction_RS2 : in  std_logic_vector(4 downto 0);
			ID_Instruction_RD  : in  std_logic_vector(4 downto 0);
			EX_Instruction_RD  : in  std_logic_vector(4 downto 0);
			ID_MemRead         : in  std_logic;
			EX_RegWrite        : in  std_logic;
			IF_Stall           : out std_logic;
			ID_Stall           : out std_logic
		);
	end component Hazard_detection_unit;

	component data_memory is
		generic (
			address_size : integer;
			data_size    : integer;
			memory_size  : integer
		);
		port (
			clk        : in  std_logic;
			MemRead    : in  std_logic;
			MemWrite   : in  std_logic;
			address    : in  std_logic_vector(address_size-1 downto 0);
			write_data : in  std_logic_vector(data_size-1 downto 0);
			read_data  : out std_logic_vector(data_size-1 downto 0)
		);
	end component data_memory;
		
end package part;