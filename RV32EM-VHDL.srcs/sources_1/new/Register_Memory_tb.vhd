library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity Register_Memory_tb is
end entity Register_Memory_tb;

-----------------------------------------------------------

architecture testbench of Register_Memory_tb is

	-- Testbench DUT generics
	constant address_width : integer := 32;
	constant data_width    : integer := 32;
	constant depth         : integer := 4095;

	-- Testbench DUT ports
	signal clk      : std_logic;
	signal we       : std_logic;
	signal R_Reg_1  : std_logic_vector(address_width-1 downto 0) := X"00000050";
	signal R_Reg_2  : std_logic_vector(address_width-1 downto 0) := X"00000025";
	signal W_Reg    : std_logic_vector(address_width-1 downto 0);
	signal W_Data   : std_logic_vector(data_width-1 downto 0);
	signal R_Data_1 : std_logic_vector(data_width-1 downto 0);
	signal R_Data_2 : std_logic_vector(data_width-1 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;
	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	main : process
	begin
		R_Reg_1 <= X"000000F0";
		R_Reg_2 <= X"0000000F";
		we      <= '1';
		W_Reg   <= X"00000125";
		W_Data  <= X"00002500";
		wait for 10 ns;
		we      <= '0';
		R_Reg_1 <= X"00000125";
		wait;
	end process;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Register_Memory
		generic map (
			address_width => address_width,
			data_width    => data_width,
			depth         => depth
		)
		port map (
			clk      => clk,
			we       => we,
			R_Reg_1  => R_Reg_1,
			R_Reg_2  => R_Reg_2,
			W_Reg    => W_Reg,
			W_Data   => W_Data,
			R_Data_1 => R_Data_1,
			R_Data_2 => R_Data_2
		);

end architecture testbench;