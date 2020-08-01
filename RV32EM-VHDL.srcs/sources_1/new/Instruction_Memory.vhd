library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Memory is
	generic (
		address_size : integer;
		data_size    : integer;
		memory_size  : integer
	);
      PORT (
        PC_in : IN STD_LOGIC_VECTOR(address_size-1 DOWNTO 0);
        Instr_OUT : OUT STD_LOGIC_VECTOR(data_size-1 DOWNTO 0)
      );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
	type Bram_type is array(0 to memory_size-1) of std_logic_vector(data_size-1 downto 0);
	signal Instruction_Rom : Bram_type := (
                                            x"00000597",
                                            x"00058593",
                                            x"00c000ef",
                                            x"00050093",
                                            x"0200006f",
                                            x"00000513",
                                            x"00058283",
                                            x"00028863",
                                            x"00150513",
                                            x"00158593",
                                            x"fe0008e3",
                                            x"00008067",
                                            x"00000073",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
											x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000",
                                            x"00000000"
                                            );
begin

    Instr_OUT <= Instruction_Rom(to_integer(shift_right(unsigned(PC_in),2)));
end Behavioral;
