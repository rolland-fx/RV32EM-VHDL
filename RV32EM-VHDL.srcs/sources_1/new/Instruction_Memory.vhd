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
                                            x"00000517",
                                            x"00052503",
                                            x"00000597",
                                            x"0005a583",-- x"ffc5a583",
                                            x"004000ef",
                                            x"00050663",
                                            x"00058463",
                                            x"00059663",
                                            x"00000513",
                                            x"00008067",
                                            x"00400397",
                                            x"fe03a383",
                                            x"00400417",
                                            x"fdc42403",
                                            x"007571b3",
                                            x"0171d193",
                                            x"0075f233",
                                            x"01725213",
                                            x"008572b3",
                                            x"0085f333",
											x"00140413",
											x"0082e2b3",
											x"00836333",
											x"004181b3",
											x"f8118193",
											x"0ff00213",
											x"fa324ce3",
											x"fa01cae3",
											x"0102d393",
											x"01029413",
											x"01045413",
											x"01035493",
											x"01031613",
											x"01065613",
											x"029383b3",
											x"02c40433",
											x"01039393",
											x"01045413",
											x"0083e2b3",
											x"40000313",
											x"01531313",
											x"0062f233",
											x"00021a63",
											x"00129293",
											x"fff18193",
											x"f601c6e3",
											x"fe0216e3",
											x"0082d293",
											x"40000413",
											x"00d41413",
											x"408282b3",
											x"00657533",
											x"0065f5b3",
											x"00b54533",
											x"01719193",
											x"00556533",
											x"00356533",
											x"00000073",
											x"00000000",
											x"00000000"			
                                            );
begin

    Instr_OUT <= Instruction_Rom(to_integer(shift_right(unsigned(PC_in),2)));
end Behavioral;
