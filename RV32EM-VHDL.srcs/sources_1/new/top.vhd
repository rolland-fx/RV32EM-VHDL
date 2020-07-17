library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.part.all;

entity Main is
	Port (
		i_clk   : in STD_LOGIC;
		i_run   : in STD_LOGIC;
		i_reset : in STD_LOGIC
	);

end Main;

architecture Behavioral of Main is

	--------GENERAL SIGNAL -------
	signal s_stall    : std_logic;
	signal s_IF_FLUSH : std_logic;

	--------PC REGISTER-----------
	-- ENTRY OF PC REGISTER
	signal s_i_PC : std_logic_vector(31 downto 0);
	-- OUTPUT OF PC REGISTER
	signal s_o_PC : std_logic_vector(31 downto 0);

	--------IF/ID STAGE ----------
	-- ENTRY of IF/ID pipeline
	signal s_i_IF_PC : std_logic_vector(31 downto 0);
	signal s_i_IF_instr : std_logic_vector(31 downto 0);
	-- OUPUT of IF/ID pipeline
	signal s_o_IF_PC : std_logic_vector(31 downto 0);
	signal s_o_IF_instr : std_logic_vector(31 downto 0);

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

	--------MEM/WB STAGE ----------
	-- ENTRY of MEM/WB pipeline
	signal s_i_MEM_DATA : std_logic_vector(31 downto 0);
	signal s_i_MEM_ALU_OUT : std_logic_vector(31 downto 0);
	signal s_i_MEM_instr_11_to_7   : std_logic_vector(4 downto 0);
	-- CONTROL IN of MEM/WB pipeline
	signal s_i_MEM_WB : std_logic_vector(1 downto 0);
	-- OUPUT of MEM/WB pipeline
	signal s_o_MEM_DATA : std_logic_vector(31 downto 0);
	signal s_o_MEM_ALU_OUT : std_logic_vector(31 downto 0);
	signal s_o_MEM_instr_11_to_7   : std_logic_vector(4 downto 0);
	-- CONTROL OUT of MEM/WB pipeline
	signal s_o_MEM_WB : std_logic_vector(1 downto 0);

	signal WB_sig : std_logic_vector(31 downto 0);

begin

	s_i_IF_PC <= s_o_ID_PC;

	s_i_EX_WB <= s_o_ID_WB; -- TODO : Add MUX for flush operation
	s_i_EX_M <= s_o_ID_M; -- TODO : Add MUX for flush operation
	s_i_EX_instr_11_to_7 <= s_o_ID_instr_11_to_7;

	s_i_MEM_WB <= s_o_EX_WB;
	s_i_MEM_instr_11_to_7 <= s_o_EX_instr_11_to_7;

	MainControl : Process(i_clk) is --synchron process
	begin
		if rising_edge(i_clk) then  -- on rising clock edge
			if i_reset = '0' then   -- reset is synchron 
				if i_run = '1' then -- run
					                -- ID/ID
					s_o_IF_PC <= s_i_IF_PC;
					s_o_IF_instr <= s_i_IF_instr;
					--ID/EX
					s_o_ID_PC                     <= s_i_ID_PC;
					s_o_ID_RD1                    <= s_i_ID_RD1;
					s_o_ID_RD2                    <= s_i_ID_RD2;
					s_o_ID_IMM                    <= s_i_ID_IMM;
					s_o_ID_instr_30_25_14_to_12_3 <= s_i_ID_instr_30_25_14_to_12_3;
					s_o_ID_instr_11_to_7          <= s_i_ID_instr_11_to_7;
					s_o_ID_WB                     <= s_i_ID_WB;
					s_o_ID_M                      <= s_i_ID_M;
					s_o_ID_EX                     <= s_i_ID_EX;
					-- EX/MEM
					s_o_EX_ALU_OUT       <= s_i_EX_ALU_OUT;
					s_o_EX_RD2           <= s_i_EX_RD2;
					s_o_EX_instr_11_to_7 <= s_i_EX_instr_11_to_7;
					s_o_EX_WB            <= s_i_EX_WB;
					s_o_EX_M             <= s_i_EX_M;
					-- MEM/WB
					s_o_MEM_DATA <= s_i_MEM_DATA;
					s_o_MEM_ALU_OUT <= s_i_MEM_ALU_OUT;
					s_o_MEM_instr_11_to_7   <= s_i_MEM_instr_11_to_7;
					s_o_MEM_WB   <= s_i_MEM_WB;
				end if;
			else -- reset =» all level are force to Zero
				s_o_IF_PC <= (others => '0');
				s_o_IF_instr <= (others => '0');
				--ID/EX
				s_o_ID_PC                     <= (others => '0');
				s_o_ID_RD1                    <= (others => '0');
				s_o_ID_RD2                    <= (others => '0');
				s_o_ID_IMM                    <= (others => '0');
				s_o_ID_instr_30_25_14_to_12_3 <= (others => '0');
				s_o_ID_instr_11_to_7          <= (others => '0');
				s_o_ID_WB                     <= (others => '0');
				s_o_ID_M                      <= (others => '0');
				s_o_ID_EX                     <= (others => '0');
				-- EX/MEM
				s_o_EX_ALU_OUT       <= (others => '0');
				s_o_EX_RD2           <= (others => '0');
				s_o_EX_instr_11_to_7 <= (others => '0');
				s_o_EX_WB            <= (others => '0');
				s_o_EX_M             <= (others => '0');
				-- MEM/WB
				s_o_MEM_DATA <= (others => '0');
				s_o_MEM_ALU_OUT <= (others => '0');
				s_o_MEM_instr_11_to_7   <= (others => '0');
				s_o_MEM_WB   <= (others => '0');
			end if;
		end if;
	end process;

	IF_stage : instruction_fetch
		port map (
			clk       => i_clk,
			PC_in     => s_o_PC,
			INSTR_out => s_i_IF_instr
		);	

	ID_stage : instruction_decode
		port map (
			clk                        => i_clk,
			isJALR                     => '0', -- TODO : provient du control_unit
			regWrite_in                => '0', -- TODO : provient du control_unit
			PC_in                      => s_o_IF_PC,
			instr_in                   => s_o_IF_instr,
			write_reg_in               => s_o_MEM_instr_11_to_7,
			write_data_in              => WB_sig,
			PC_out                     => s_i_ID_PC,
			RD1_out                    => s_i_ID_RD1,
			RD2_out                    => s_i_ID_RD1,
			IMM_out                    => s_i_ID_IMM,
			instr_30_25_14_to_12_3_out => s_i_ID_instr_30_25_14_to_12_3,
			instr_11_to_7_out          => s_i_ID_instr_11_to_7,
			jump_out                   => open -- TODO : diriger vers IF_stage
		);	

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

	MEM_stage : memory_access
		port map (
			clk              => i_clk,
			M                => s_o_EX_M,
			ALU_OUT_in       => s_o_EX_ALU_OUT,
			RD2_in           => s_o_EX_RD2,
			DATA_out         => s_i_MEM_DATA,
			ADDR_out         => s_i_MEM_ALU_OUT
		);

	WB_stage : write_back
		port map (
			WB         => s_o_MEM_WB,
			DATA_in    => s_o_MEM_DATA,
			ALU_OUT_in => s_o_MEM_ALU_OUT,
			DATA_out   => WB_sig
		);			
end Behavioral;