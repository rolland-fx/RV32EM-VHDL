library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
	generic (
		address_size : integer := 32;
		data_size    : integer := 32;
		memory_size  : integer := 64
	);
	Port (
		clk        : in  std_logic;
		MemRead    : in  std_logic;
		MemWrite   : in  std_logic;
		address    : in  std_logic_vector(address_size-1 downto 0);
		write_data : in  std_logic_vector(data_size-1 downto 0);
		read_data  : out std_logic_vector(data_size-1 downto 0)
	);
end data_memory;

architecture Behavioral of data_memory is
	type ram_type is array(0 to memory_size-1) of std_logic_vector(data_size-1 downto 0);
	signal data_ram : ram_type := (
			x"00000042", x"0000006f", x"0000006e", x"0000006a",
			x"0000006f", x"00000075", x"00000072", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000",
			x"00000000", x"00000000", x"00000000", x"00000000");

begin

	read_data <= data_ram(to_integer(unsigned(address)));
    process(clk)
    begin
        if rising_edge(clk) then
            if ((MemWrite = '1') and (MemRead = '0')) then
                data_ram(to_integer(shift_right(unsigned(address),2))) <= write_data;
            end if;
        end if;
    end process;


end Behavioral;
