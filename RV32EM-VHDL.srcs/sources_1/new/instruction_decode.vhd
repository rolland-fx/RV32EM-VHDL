--------------------------------------------------------------------------------
-- Title       : Instruction Decode
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : instruction_decode.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Jun 30 18:14:47 2020
-- Last update : Fri Jul 17 11:15:52 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.part.all;

entity instruction_decode is
	Port (
		clk           : in std_logic;
		isJALR        : in std_logic;
		regWrite_in   : in std_logic;
		PC_in         : in std_logic_vector(31 downto 0);
		instr_in      : in std_logic_vector(31 downto 0);
		write_reg_in  : in std_logic_vector(4 downto 0);
		write_data_in : in std_logic_vector(31 downto 0);

		PC_out                     : out std_logic_vector(31 downto 0);
		RD1_out                    : out std_logic_vector(31 downto 0);
		RD2_out                    : out std_logic_vector(31 downto 0);
		IMM_out                    : out std_logic_vector(31 downto 0);
		instr_30_25_14_to_12_3_out : out std_logic_vector(5 downto 0);
		instr_11_to_7_out          : out std_logic_vector(4 downto 0);
		jump_out                   : out std_logic_vector(31 downto 0)
	);
end instruction_decode;

architecture Behavioral of instruction_decode is
	signal RD1         : std_logic_vector(31 downto 0);
	signal RD2         : std_logic_vector(31 downto 0);
	signal imm         : std_logic_vector(31 downto 0);
	signal branch_jump : std_logic_vector(31 downto 0);
	signal jalr_jump   : std_logic_vector(31 downto 0);

begin

	PC_out                     <= PC_in;
	RD1_out                    <= RD1;
	RD2_out                    <= RD2;
	IMM_out                    <= imm;
	instr_30_25_14_to_12_3_out <= instr_in(30) & instr_in(25) & instr_in(14 downto 12) & instr_in(3);
	instr_11_to_7_out          <= instr_in(11 downto 7);

	branch_jump <= std_logic_vector(unsigned(PC_in) + shift_left(unsigned(imm), 1));
	jalr_jump   <= std_logic_vector(unsigned(imm) + unsigned(RD1));

	Register_Memory_1 : entity work.Register_Memory
		generic map (
			address_width => 5,
			data_width    => 32,
			depth         => 16
		)
		port map (
			clk      => clk,
			we       => regWrite_in,
			R_Reg_1  => instr_in(19 downto 15),
			R_Reg_2  => instr_in(24 downto 20),
			W_Reg    => write_reg_in,
			W_Data   => write_data_in,
			R_Data_1 => RD1,
			R_Data_2 => RD2
		);

	imm_gen_1 : entity work.imm_gen
		port map (
			instruction => instr_in,
			imm         => imm
		);

	with isJALR select
	jump_out <=
		jalr_jump       when '1',
		branch_jump     when '0',
		(others => '0') when others;

end Behavioral;
