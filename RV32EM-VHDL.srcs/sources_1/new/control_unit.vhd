library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
	Port (
		Funct3     : in  std_logic_vector(2 downto 0);
		Opcode     : in  std_logic_vector(6 downto 0);
		Exception  : out std_logic;
		Jump       : out std_logic;
		IF_Flush   : out std_logic;
		ID_Flush   : out std_logic;
		EX_Flush   : out std_logic;
		Control_WB : out std_logic_vector(1 downto 0); --
		Control_M  : out std_logic_vector(4 downto 0); --
		Control_EX : out std_logic_vector(5 downto 0); -- ALUOp(2) ALUSrc1(2) ALUSrc2(2)
		IS_Branch  : out std_logic;
		IS_Jalr    : out std_logic
	);
end control_unit;

architecture Behavioral of control_unit is

begin

process(Opcode,Funct3)
begin
	case Opcode is
		when "0110011" => --R type
			if (Funct3 = ) then

			else

			end if;
		when "0110111" => --LUI
			Exception  <= ;
			Jump       <= ;
			IF_Flush   <= ;
			ID_Flush   <= ;
			EX_Flush   <= ;
			Control_WB <= ;
			Control_M  <= ;
			Control_EX <= ;
			IS_Branch  <= ;
			IS_Jalr    <= ;
		when "0010111" => --AUIPC
			Exception  <= ;
			Jump       <= ;
			IF_Flush   <= ;
			ID_Flush   <= ;
			EX_Flush   <= ;
			Control_WB <= ;
			Control_M  <= ;
			Control_EX <= ;
			IS_Branch  <= ;
			IS_Jalr    <= ;
		when "1101111" => --JAL
			Exception  <= '0';
			Jump       <= '1';
			IF_Flush   <= '1';
			ID_Flush   <= '0';
			EX_Flush   <= '0';
			Control_WB <= ;
			Control_M  <= ;
			Control_EX <= ;
			IS_Branch  <= '0';
			IS_Jalr    <= '0';
		when "1100111" => --JALR
			if (Funct3 = "000") then
				Exception  <= '0';
				Jump       <= '1';
				IF_Flush   <= '1';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= ;
				Control_M  <= ;
				Control_EX <= ;
				IS_Branch  <= '0';
				IS_Jalr    <= '1';
			else
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			end if;
		when "1100011" => --B type
			if (Funct3 = "010" or Funct3 = "011") then
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			else
				Exception  <= '0';
				Jump       <= '1';
				IF_Flush   <= '1';
				ID_Flush   <=;
				EX_Flush   <=;
				Control_WB <=;
				Control_M  <=;
				Control_EX <=;
				IS_Branch  <= '1';
				IS_Jalr    <= '0';
			end if;
		when "0100011" => --S type
			if (Funct3 = "000" or Funct3 = "001" or Funct3 = "010") then
				Exception  <= '0';
				Jump       <= '0';
				IF_Flush   <=;
				ID_Flush   <=;
				EX_Flush   <=;
				Control_WB <=;
				Control_M  <=;
				Control_EX <=;
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			else
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			end if;
		when "0010011" => --I type
			if (Funct3 = ) then

			else

			end if;
		when "0000011" => --LOAD
			if (Funct3 = "011" or Funct3 = "110" or Funct3 = "111") then
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			else
				Exception  <= '0';
				Jump       <= '0';
				IF_Flush   <=;
				ID_Flush   <=;
				EX_Flush   <=;
				Control_WB <=;
				Control_M  <=;
				Control_EX <=;
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			end if;
		when "0001111" => --FENCE
			if (Funct3 = "000") then
				Exception  <=;
				Jump       <=;
				IF_Flush   <=;
				ID_Flush   <=;
				EX_Flush   <=;
				Control_WB <=;
				Control_M  <=;
				Control_EX <=;
				IS_Branch  <=;
				IS_Jalr    <=;
			else
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			end if;
		when "1110011" => --ECALL
			if (Funct3 = "000") then
				Exception  <=;
				Jump       <=;
				IF_Flush   <=;
				ID_Flush   <=;
				EX_Flush   <=;
				Control_WB <=;
				Control_M  <=;
				Control_EX <=;
				IS_Branch  <=;
				IS_Jalr    <=;
			else
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';
			end if;
		when others =>
				Exception  <= '1';
				Jump       <= '0';
				IF_Flush   <= '0';
				ID_Flush   <= '0';
				EX_Flush   <= '0';
				Control_WB <= "00";
				Control_M  <= "00000";
				Control_EX <= "000000";
				IS_Branch  <= '0';
				IS_Jalr    <= '0';;
	end case;
end process;


end Behavioral;
