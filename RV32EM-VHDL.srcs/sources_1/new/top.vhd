library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main is
Port ( 
i_clk : in STD_LOGIC;
i_run : in STD_LOGIC;
i_reset : in STD_LOGIC
);

end Main;

architecture Behavioral of Main is

--------GENERAL SIGNAL -------
signal s_stall : std_logic;
signal s_IF_FLUSH : std_logic;

--------ID/IF STAGE ----------
-- ENTRY of IF/ID pipeline
signal s_i_IF_PC : std_logic_vector(31 downto 0);
signal s_i_IF_RI : std_logic_vector(31 downto 0);
-- OUPUT of IF/ID pipeline
signal s_o_IF_PC : std_logic_vector(31 downto 0);
signal s_o_IF_RI : std_logic_vector(31 downto 0);

--------ID/EX STAGE ----------
-- ENTRY of ID/EX pipeline
signal s_i_ID_PC : std_logic_vector(31 downto 0);
signal s_i_ID_RD1 : std_logic_vector(31 downto 0);
signal s_i_ID_RD2 : std_logic_vector(31 downto 0);
signal s_i_ID_IMM : std_logic_vector(31 downto 0);
signal s_i_ID_RI : std_logic_vector(31 downto 0);
-- CONTROL IN of ID/EX pipeline
signal s_i_ID_WB : std_logic_vector(1 downto 0);
signal s_i_ID_M : std_logic_vector(4 downto 0);
signal s_i_ID_EX : std_logic_vector(5 downto 0);
-- OUPUT of ID/EX pipeline
signal s_o_ID_PC : std_logic_vector(31 downto 0);
signal s_o_ID_RD1 : std_logic_vector(31 downto 0);
signal s_o_ID_RD2 : std_logic_vector(31 downto 0);
signal s_o_ID_IMM : std_logic_vector(31 downto 0);
signal s_o_ID_RI : std_logic_vector(31 downto 0);
-- CONTROL OUT of ID/EX pipeline
signal s_o_ID_WB : std_logic_vector(1 downto 0);
signal s_o_ID_M : std_logic_vector(4 downto 0);
signal s_o_ID_EX : std_logic_vector(5 downto 0);

--------EM/MEM STAGE ----------
-- ENTRY of ID/EX pipeline
signal s_i_EM_ALU_OUT : std_logic_vector(31 downto 0);
signal s_i_EM_ALU_IN2 : std_logic_vector(31 downto 0);
signal s_i_EM_RI : std_logic_vector(31 downto 0);
-- CONTROL IN of ID/EX pipeline
signal s_i_EM_WB : std_logic_vector(1 downto 0);
signal s_i_EM_M : std_logic_vector(4 downto 0);
-- OUPUT of ID/EX pipeline
signal s_o_EM_ALU_OUT : std_logic_vector(31 downto 0);
signal s_o_EM_ALU_IN2 : std_logic_vector(31 downto 0);
signal s_o_EM_RI : std_logic_vector(31 downto 0);
-- CONTROL OUT of ID/EX pipeline
signal s_o_EM_WB : std_logic_vector(1 downto 0);
signal s_o_EM_M : std_logic_vector(4 downto 0);

--------MEM/WB STAGE ----------
-- ENTRY of MEM/WB pipeline
signal s_i_MEM_MEM_DATA : std_logic_vector(31 downto 0);
signal s_i_MEM_MEM_ADDR : std_logic_vector(31 downto 0);
signal s_i_MEM_RI : std_logic_vector(31 downto 0);
-- CONTROL IN of MEM/WB pipeline
signal s_i_MEM_WB : std_logic_vector(1 downto 0);
-- OUPUT of MEM/WB pipeline
signal s_o_MEM_MEM_DATA : std_logic_vector(31 downto 0);
signal s_o_MEM_MEM_ADDR : std_logic_vector(31 downto 0);
signal s_o_MEM_RI : std_logic_vector(31 downto 0);
-- CONTROL OUT of MEM/WB pipeline
signal s_o_MEM_WB : std_logic_vector(1 downto 0);


begin
	MainControl:Process(i_clk) is --synchron process
		begin
			if rising_edge(i_clk) then -- on rising clock edge
				if i_reset = '0' then -- reset is synchron 
					if i_run = '1' then -- run
	                   -- ID/ID
	                   s_o_IF_PC        <= s_i_IF_PC; 
	                   s_o_IF_RI        <= s_i_IF_RI;
	                   --ID/EX
	                   s_o_ID_PC        <= s_i_ID_PC;
	                   s_o_ID_RD1       <= s_i_ID_RD1;
	                   s_o_ID_RD2       <= s_i_ID_RD2;
	                   s_o_ID_IMM       <= s_i_ID_IMM;
	                   s_o_ID_RI        <= s_i_ID_RI;
	                   s_o_ID_WB        <= s_i_ID_WB; 
	                   s_o_ID_M         <= s_i_ID_M; 
	                   s_o_ID_EX        <= s_i_ID_EX;
	                   -- EX/MEM
	                   s_o_EM_ALU_OUT   <= s_i_EM_ALU_OUT;
	                   s_o_EM_ALU_IN2   <= s_i_EM_ALU_IN2;
	                   s_o_EM_RI        <= s_i_EM_RI;
	                   s_o_EM_WB        <= s_i_EM_WB;
	                   s_o_EM_M         <= s_i_EM_M;
	                   -- MEM/WB
	                   s_o_MEM_MEM_DATA <= s_i_MEM_MEM_DATA;
	                   s_o_MEM_MEM_ADDR <= s_i_MEM_MEM_ADDR;
	                   s_o_MEM_RI       <= s_i_MEM_RI;
	                   s_o_MEM_WB       <= s_i_MEM_WB;
					end if; 
				else -- reset =» all level are force to Zero
				end if;
			end if;
		end process;
end Behavioral;