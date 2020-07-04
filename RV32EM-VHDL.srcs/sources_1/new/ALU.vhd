--------------------------------------------------------------------------------
-- Title       : ALU
-- Project     : RV32EM-VHDL
--------------------------------------------------------------------------------
-- File        : ALU.vhd
-- Author      : Alexandre Viau <alexandre.viau.2@ens.etsmtl.ca>
-- Company     : École de technologie Superieur
-- Created     : Fri Jul  3 19:04:26 2020
-- Last update : Sat Jul  4 10:19:24 2020
-- Platform    : N/A
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port (
		control : in std_logic_vector(5 downto 0);
		-- control(5 downto 3) : funct3
		-- control(2) : Inst(30) ou funct7_5
		-- control(1) : Inst(25) ou funct7_0
		-- control(0) : Inst(5) ou opcode_5
		opA : in std_logic_vector(31 downto 0);
		opB : in std_logic_vector(31 downto 0);

		ALU_out : out std_logic_vector(31 downto 0)
	);

end entity ALU;

architecture rtl of ALU is
	signal funct3   : std_logic_vector(2 downto 0);
	signal funct7_5 : std_logic;
	signal funct7_0 : std_logic;
	signal opcode_5 : std_logic;

	signal opB_sig : std_logic_vector(31 downto 0);

begin

	funct3   <= control(5 downto 3);
	funct7_5 <= control(2);
	funct7_0 <= control(1);
	opcode_5 <= control(0);

	imm_process : process(opcode_5, funct3(0), opB) begin
		if opcode_5 = '0' and funct3(0) = '0' then -- signed immediate
			opB_sig <= std_logic_vector(resize(signed(opB(11 downto 0)), opB_sig'length));
		elsif opcode_5 = '0' and funct3(0) = '1' then -- unsigned immediate
			opB_sig <= std_logic_vector(resize(unsigned(opB(11 downto 0)), opB_sig'length));
		else
			opB_sig <= opB;
		end if;
	end process;

	main_process : process(opA, opB_sig, funct3, funct7_5, opcode_5)
		variable mul_sig    : std_logic_vector(63 downto 0);
		variable mul_sig_65 : std_logic_vector(64 downto 0);
		variable opA_33     : std_logic_vector(32 downto 0);
		variable opB_33     : std_logic_vector(32 downto 0);

	begin

		if funct3 = "000" and funct7_0 = '0' then -- add and sub
			if opcode_5 = '1' and funct7_5 = '1' then
				ALU_out <= std_logic_vector(signed(opA) - signed(opB_sig));
			else
				ALU_out <= std_logic_vector(signed(opA) + signed(opB_sig));
			end if;
		elsif funct3(1 downto 0) = "01" and funct7_0 = '0' then -- shift
			if funct3(2) = '0' then
				ALU_out <= std_logic_vector(shift_left(unsigned(opA), to_integer(unsigned(opB_sig(4 downto 0)))));
			elsif funct3(2) = '1' and funct7_5 = '0' then
				ALU_out <= std_logic_vector(shift_right(unsigned(opA), to_integer(unsigned(opB_sig(4 downto 0)))));
			elsif funct3(2) = '1' and funct7_5 = '1' then
				ALU_out <= std_logic_vector(shift_right(signed(opA), to_integer(unsigned(opB_sig(4 downto 0)))));
			else
				ALU_out <= (others => '0');
			end if;
		elsif funct3 = "010" and funct7_0 = '0' then -- ser less then signed
			if signed(opA) < signed(opB_sig) then
				ALU_out <= x"00000001";
			else
				ALU_out <= x"00000000";
			end if;
		elsif funct3 = "011" and funct7_0 = '0' then -- ser less then unsigned
			if unsigned(opA) < unsigned(opB_sig) then
				ALU_out <= x"00000001";
			else
				ALU_out <= x"00000000";
			end if;
		elsif funct3 = "111" and funct7_0 = '0' then -- AND
			ALU_out <= opA and opB_sig;
		elsif funct3 = "110" and funct7_0 = '0' then -- OR
			ALU_out <= opA or opB_sig;
		elsif funct3 = "100" and funct7_0 = '0' then -- XOR
			ALU_out <= opA xor opB_sig;
		elsif funct7_0 = '1' then  -- M extension
			if funct3 = "000" then -- MUL
				mul_sig := std_logic_vector(unsigned(opA) * unsigned(opB));
				ALU_out <= mul_sig(31 downto 0);
			elsif funct3 = "001" then -- MULH
				mul_sig := std_logic_vector(signed(opA) * signed(opB));
				ALU_out <= mul_sig(63 downto 32);
			elsif funct3 = "010" then -- MULHSU
				opB_33(32)          := '0';
				opB_33(31 downto 0) := opB;
				opA_33(32)          := '0';
				opA_33(31 downto 0) := opA;
				mul_sig_65          := std_logic_vector(signed(opA_33) * signed(opB_33));
				ALU_out             <= mul_sig_65(63 downto 0);
			elsif funct3 = "011" then -- MULHU
				mul_sig := std_logic_vector(unsigned(opA) * unsigned(opB));
				ALU_out <= mul_sig(31 downto 0);
			elsif funct3 = "100" then -- DIV
				ALU_out <= std_logic_vector(signed(opA) / signed(opB));
			elsif funct3 = "101" then -- DIVU
				ALU_out <= std_logic_vector(unsigned(opA) / unsigned(opB));
			elsif funct3 = "110" then -- REM
				ALU_out <= std_logic_vector(signed(opA) rem signed(opB));
			elsif funct3 = "111" then -- REMU
				ALU_out <= std_logic_vector(unsigned(opA) rem unsigned(opB));
			else
			end if;
		else
			ALU_out <= (others => '0');
		end if;

	end process;

end architecture rtl;