library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.part.all;

entity Main is
	Port (
		i_clk : in STD_LOGIC;
		o_clk : out std_logic
	);

end Main;

architecture Behavioral of Main is

	--------PC REGISTER-----------
	-- ENTRY OF PC REGISTER
	signal s_i_PC : std_logic_vector(31 downto 0);
	-- OUTPUT OF PC REGISTER
	signal s_o_PC : std_logic_vector(31 downto 0) := x"00000000";
	-- MANAG of PC REGISTER
	signal s_c_PC_stall : std_logic;

	--------IF/ID STAGE ----------
	-- ENTRY of IF/ID pipeline
	signal s_i_IF_PC    : std_logic_vector(31 downto 0);
	signal s_i_IF_instr : std_logic_vector(31 downto 0);
	-- OUPUT of IF/ID pipeline
	signal s_o_IF_PC    : std_logic_vector(31 downto 0);
	signal s_o_IF_instr : std_logic_vector(31 downto 0);
	-- MANAG of IF/ID pipeline
	signal s_c_IF_flush : std_logic;
	signal s_c_IF_stall : std_logic;

	--------ID/EX STAGE ----------
	-- ENTRY of ID/EX pipeline
	signal s_i_ID_PC                     : std_logic_vector(31 downto 0);
	signal s_i_ID_RD1                    : std_logic_vector(31 downto 0);
	signal s_i_ID_RD2                    : std_logic_vector(31 downto 0);
	signal s_i_ID_IMM                    : std_logic_vector(31 downto 0);
	signal s_i_ID_instr_30_25_14_to_12_3 : std_logic_vector(5 downto 0);
	signal s_i_ID_instr_11_to_7          : std_logic_vector(4 downto 0);
	-- CONTROL IN of ID/EX pipeline
	signal s_i_ID_WB : std_logic_vector(1 downto 0);
	signal s_i_ID_M  : std_logic_vector(1 downto 0);
	signal s_i_ID_EX : std_logic_vector(5 downto 0);
	-- OUPUT of ID/EX pipeline
	signal s_o_ID_PC                     : std_logic_vector(31 downto 0);
	signal s_o_ID_RD1                    : std_logic_vector(31 downto 0);
	signal s_o_ID_RD2                    : std_logic_vector(31 downto 0);
	signal s_o_ID_IMM                    : std_logic_vector(31 downto 0);
	signal s_o_ID_instr_30_25_14_to_12_3 : std_logic_vector(5 downto 0);
	signal s_o_ID_instr_11_to_7          : std_logic_vector(4 downto 0);
	-- CONTROL OUT of ID/EX pipeline
	signal s_o_ID_WB : std_logic_vector(1 downto 0);
	signal s_o_ID_M  : std_logic_vector(1 downto 0);
	signal s_o_ID_EX : std_logic_vector(5 downto 0);
	-- MANAG of ID/EX pipeline
	signal s_c_ID_flush : std_logic;
	signal s_c_ID_stall : std_logic;

	--------EX/MEM STAGE ----------
	-- ENTRY of ID/EX pipeline
	signal s_i_EX_ALU_OUT       : std_logic_vector(31 downto 0);
	signal s_i_EX_RD2           : std_logic_vector(31 downto 0);
	signal s_i_EX_instr_11_to_7 : std_logic_vector(4 downto 0);
	-- CONTROL IN of ID/EX pipeline
	signal s_i_EX_WB : std_logic_vector(1 downto 0);
	signal s_i_EX_M  : std_logic_vector(1 downto 0);
	-- OUPUT of ID/EX pipeline
	signal s_o_EX_ALU_OUT       : std_logic_vector(31 downto 0);
	signal s_o_EX_RD2           : std_logic_vector(31 downto 0);
	signal s_o_EX_instr_11_to_7 : std_logic_vector(4 downto 0);
	-- CONTROL OUT of ID/EX pipeline
	signal s_o_EX_WB : std_logic_vector(1 downto 0);
	signal s_o_EX_M  : std_logic_vector(1 downto 0);
	-- MANAG of ID/EX pipeline
	signal s_c_EX_flush : std_logic;
	signal s_c_EX_stall : std_logic;

	--------MEM/WB STAGE ----------
	-- ENTRY of MEM/WB pipeline
	signal s_i_MEM_DATA          : std_logic_vector(31 downto 0);
	signal s_i_MEM_ALU_OUT       : std_logic_vector(31 downto 0);
	signal s_i_MEM_instr_11_to_7 : std_logic_vector(4 downto 0);
	-- CONTROL IN of MEM/WB pipeline
	signal s_i_MEM_WB : std_logic_vector(1 downto 0);
	-- OUPUT of MEM/WB pipeline
	signal s_o_MEM_DATA          : std_logic_vector(31 downto 0);
	signal s_o_MEM_ALU_OUT       : std_logic_vector(31 downto 0);
	signal s_o_MEM_instr_11_to_7 : std_logic_vector(4 downto 0);
	-- CONTROL OUT of MEM/WB pipeline
	signal s_o_MEM_WB : std_logic_vector(1 downto 0);
	-- MANAG of MEM/WB pipeline
	signal s_c_MEM_flush : std_logic;
	signal s_c_MEM_stall : std_logic;
	signal WB_sig        : std_logic_vector(31 downto 0);

	-- Control Unit SIGNAL
	signal control_Jump      : std_logic;
	signal control_IF_Flush  : std_logic;
	signal control_ID_flush  : std_logic;
	signal control_EX_flush  : std_logic;
	signal control_WB        : std_logic_vector(1 downto 0);
	signal control_M         : std_logic_vector(1 downto 0);
	signal control_EX        : std_logic_vector(5 downto 0);
	signal contorl_IsBranch  : std_logic;
	signal control_IsJalr    : std_logic;
	signal control_Exception : std_logic;

	-- Hazard detection unit signal
	signal hazard_IF_stall : std_logic;
	signal hazard_ID_stall : std_logic;

	-- OTHER SIGNAL
	signal control_mux_select : std_logic;
	signal BranchCmp          : std_logic;
	signal PCsrc              : std_logic_vector(1 downto 0);
	signal jump_addr          : std_logic_vector(31 downto 0);

begin

	PCsrc <= (BranchCmp and control_Jump) & control_Exception;

	with PCsrc select
	s_i_PC <=
		std_logic_vector(unsigned(s_o_PC) + 4) when "00",
		jump_addr                              when "10",
		s_o_IF_PC                              when "01",
		(others => '0')                        when others;

	s_c_PC_stall <= hazard_ID_stall or hazard_IF_stall;

	MainControl_PC : Process(i_clk) is
	begin
		if rising_edge(i_clk) and s_c_PC_stall = '0' then
			s_o_PC <= s_i_PC;
		end if;
	end process;

	s_c_IF_stall <= hazard_ID_stall or hazard_IF_stall;
	s_c_IF_flush <= control_IF_Flush or (contorl_IsBranch and BranchCmp);

	MainControl_IF : Process(i_clk) is -- IF/ID
	begin
		if rising_edge(i_clk) and s_c_IF_stall = '0' then -- on rising clock edge
			if s_c_IF_flush = '0' then                    -- run
				s_o_IF_PC    <= s_i_IF_PC;
				s_o_IF_instr <= s_i_IF_instr;
			else
				s_o_IF_PC    <= (others => '0');
				s_o_IF_instr <= (others => '0');
			end if;
		end if;
	end process;

	MainControl_ID : Process(i_clk) is -- ID/EX
	begin
		if rising_edge(i_clk) then -- on rising clock edge
			s_o_ID_PC                     <= s_i_ID_PC;
			s_o_ID_RD1                    <= s_i_ID_RD1;
			s_o_ID_RD2                    <= s_i_ID_RD2;
			s_o_ID_IMM                    <= s_i_ID_IMM;
			s_o_ID_instr_30_25_14_to_12_3 <= s_i_ID_instr_30_25_14_to_12_3;
			s_o_ID_instr_11_to_7          <= s_i_ID_instr_11_to_7;
			s_o_ID_WB                     <= s_i_ID_WB;
			s_o_ID_M                      <= s_i_ID_M;
			s_o_ID_EX                     <= s_i_ID_EX;
		end if;
	end process;

	MainControl_EX : Process(i_clk) is -- EX/MEM
	begin
		if rising_edge(i_clk) then -- on rising clock edge
			s_o_EX_ALU_OUT       <= s_i_EX_ALU_OUT;
			s_o_EX_RD2           <= s_i_EX_RD2;
			s_o_EX_instr_11_to_7 <= s_i_EX_instr_11_to_7;
			s_o_EX_WB            <= s_i_EX_WB;
			s_o_EX_M             <= s_i_EX_M;
		end if;
	end process;

	MainControl_MEM : Process(i_clk) is -- MEM/WB
	begin
		if rising_edge(i_clk) then -- on rising clock edge
			s_o_MEM_DATA          <= s_i_MEM_DATA;
			s_o_MEM_ALU_OUT       <= s_i_MEM_ALU_OUT;
			s_o_MEM_instr_11_to_7 <= s_i_MEM_instr_11_to_7;
			s_o_MEM_WB            <= s_i_MEM_WB;
		end if;
	end process;

	s_i_IF_PC <= s_o_PC;

	IF_stage : instruction_fetch
		port map (
			clk       => i_clk,
			PC_in     => s_o_PC,
			INSTR_out => s_i_IF_instr
		);

	with control_mux_select select
	s_i_ID_WB <=
		Control_WB      when '0',
		(others => '0') when others;

	with control_mux_select select
	s_i_ID_M <=
		Control_M       when '0',
		(others => '0') when others;

	with control_mux_select select
	s_i_ID_EX <=
		control_EX      when '0',
		(others => '0') when others;

	instruction_decode_1 : instruction_decode
		port map (
			clk                        => i_clk,
			isJALR                     => control_IsJalr,
			isBRANCH                   => contorl_IsBranch,
			regWrite_in                => s_o_MEM_WB(1),
			PC_in                      => s_o_IF_PC,
			instr_in                   => s_o_IF_instr,
			write_reg_in               => s_o_MEM_instr_11_to_7,
			write_data_in              => WB_sig,
			PC_out                     => s_i_ID_PC,
			RD1_out                    => s_i_ID_RD1,
			RD2_out                    => s_i_ID_RD2,
			IMM_out                    => s_i_ID_IMM,
			instr_30_25_14_to_12_3_out => s_i_ID_instr_30_25_14_to_12_3,
			instr_11_to_7_out          => s_i_ID_instr_11_to_7,
			jump_out                   => jump_addr,
			branch_cmp                 => BranchCmp
		);

	with control_EX_flush select
	s_i_EX_WB <=
		s_o_ID_WB       when '0',
		(others => '0') when others;

	with control_EX_flush select
	s_i_EX_M <=
		s_o_ID_M        when '0',
		(others => '0') when others;

	s_i_EX_instr_11_to_7 <= s_o_ID_instr_11_to_7;

	EX_stage : execute
		port map (
			EX                        => s_o_ID_EX,
			PC_in                     => s_o_ID_PC,
			RD1_in                    => s_o_ID_RD1,
			RD2_in                    => s_o_ID_RD2,
			IMM_in                    => s_o_ID_IMM,
			instr_30_25_14_to_12_3_in => s_o_ID_instr_30_25_14_to_12_3,

			ALU_OUT_out => s_i_EX_ALU_OUT,
			RD2_out     => s_i_EX_RD2
		);

	s_i_MEM_WB            <= s_o_EX_WB;
	s_i_MEM_instr_11_to_7 <= s_o_EX_instr_11_to_7;

	MEM_stage : memory_access
		port map (
			clk        => i_clk,
			M          => s_o_EX_M,
			ALU_OUT_in => s_o_EX_ALU_OUT,
			RD2_in     => s_o_EX_RD2,
			DATA_out   => s_i_MEM_DATA,
			ADDR_out   => s_i_MEM_ALU_OUT
		);

	WB_stage : write_back
		port map (
			WB         => s_o_MEM_WB,
			DATA_in    => s_o_MEM_DATA,
			ALU_OUT_in => s_o_MEM_ALU_OUT,
			DATA_out   => WB_sig
		);

	control_mux_select <= control_ID_flush or hazard_IF_stall or hazard_ID_stall;

	control_unit_1 : control_unit
		port map (
			Funct3    => s_o_IF_instr(14 downto 12),
			Opcode    => s_o_IF_instr(6 downto 0),
			Jump      => control_Jump,
			IF_Flush  => control_IF_Flush,
			ID_Flush  => control_ID_flush,
			EX_Flush  => control_EX_flush,
			WB        => control_WB,
			M         => control_M,
			EX        => control_EX,
			IS_Branch => contorl_IsBranch,
			IS_Jalr   => control_IsJalr,
			Exception => control_Exception
		);

	Hazard_detection_unit_1 : Hazard_detection_unit
		port map (
			IF_Instruction_RS1 => s_o_IF_instr(19 downto 15),
			IF_Instruction_RS2 => s_o_IF_instr(24 downto 20),
			ID_Instruction_RD  => s_o_ID_instr_11_to_7,
			EX_Instruction_RD  => s_o_EX_instr_11_to_7,
			ID_MemRead         => s_o_ID_M(1),
			ID_RegWrite        => s_o_ID_WB(1),
			EX_RegWrite        => s_o_EX_WB(1),
			IF_Stall           => hazard_IF_stall,
			ID_Stall           => hazard_ID_stall
		);
end Behavioral;