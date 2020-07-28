
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity control_unit is
	Port (
		Funct3    : in  std_logic_vector(2 downto 0);
		Opcode    : in  std_logic_vector(6 downto 0);
		Jump      : out std_logic;
		IF_Flush  : out std_logic;
		ID_Flush  : out std_logic;
		EX_Flush  : out std_logic;
		WB        : out std_logic_vector(1 downto 0); -- RegWrite(1) MemToReg(1) 
		M         : out std_logic_vector(1 downto 0); -- MemRead(1) MemWrite(1)
		EX        : out std_logic_vector(5 downto 0); -- AluOp(2) OpA_sel(2) OpB_sel(2)
		IS_Branch : out std_logic;
		IS_Jalr   : out std_logic
	);
end control_unit;

architecture Behavioral of control_unit is

begin

process(Opcode,Funct3)
begin
	case Opcode is
		when "0110011" => --R type
			Jump      <= '0';
			IF_Flush  <= '0';
			ID_Flush  <= '0';
			EX_Flush  <= '0';
			WB        <= "10";
			M         <= "00";
			EX        <= "100000";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
		when "0110111" => --LUI
			Jump      <= '0';
			IF_Flush  <= '0';
			ID_Flush  <= '0';
			EX_Flush  <= '0';
			WB        <= "10";
			M         <= "00";
			EX        <= "001001";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
		when "0010111" => --AUIPC
			Jump      <= '0';
			IF_Flush  <= '0';
			ID_Flush  <= '0';
			EX_Flush  <= '0';
			WB        <= "10";
			M         <= "00";
			EX        <= "000101";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
		when "1101111" => --JAL
			Jump      <= '1';
			IF_Flush  <= '1';
			ID_Flush  <= '0';
			EX_Flush  <= '0';
			WB        <= "10";
			M         <= "00";
			EX        <= "000110";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
		when "1100111" => --JALR
			if (Funct3 = "000") then
				Jump      <= '1';
				IF_Flush  <= '1';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "10";
				M         <= "00";
				EX        <= "000110";
				IS_Branch <= '0';
				IS_Jalr   <= '1';
			else
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			end if;
		when "1100011" => --B type
			if (Funct3 = "010" or Funct3 = "011") then
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			else
				Jump      <= '1';
				IF_Flush  <= '0';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "00";
				M         <= "00";
				EX        <= "010000";
				IS_Branch <= '1';
				IS_Jalr   <= '0';
			end if;
		when "0100011" => --S type
			if (Funct3 = "000" or Funct3 = "001" or Funct3 = "010") then
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "01";
				M         <= "01";
				EX        <= "000001";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			else
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			end if;
		when "0010011" => --I type
			Jump      <= '0';
			IF_Flush  <= '0';
			ID_Flush  <= '0';
			EX_Flush  <= '0';
			WB        <= "10";
			M         <= "00";
			EX        <= "100001";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
		when "0000011" => --LOAD
			if (Funct3 = "011" or Funct3 = "110" or Funct3 = "111") then
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			else
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "11";
				M         <= "10";
				EX        <= "000001";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			end if;
		when "0001111" => --FENCE
			if (Funct3 = "000") then
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			else
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			end if;
		when "1110011" => --ECALL/EBREAK
			if (Funct3 = "000") then
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '0';
				EX_Flush  <= '0';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			else
				Jump      <= '0';
				IF_Flush  <= '0';
				ID_Flush  <= '1';
				EX_Flush  <= '1';
				WB        <= "00";
				M         <= "00";
				EX        <= "000000";
				IS_Branch <= '0';
				IS_Jalr   <= '0';
			end if;
		when others =>
			Jump      <= '0';
			IF_Flush  <= '0';
			ID_Flush  <= '1';
			EX_Flush  <= '1';
			WB        <= "00";
			M         <= "00";
			EX        <= "000000";
			IS_Branch <= '0';
			IS_Jalr   <= '0';
	end case;
end process;

end Behavioral;
