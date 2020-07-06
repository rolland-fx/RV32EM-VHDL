library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
	generic (
		address_size : integer;
		data_size    : integer;
		memory_size  : integer
	);
	Port (
		clk          : in  std_logic;
		MemRead      : in  std_logic;
		MemWrite     : in  std_logic;
		address      : in  std_logic_vector(address_size-1 downto 0);
		write_data   : in  std_logic_vector(data_size-1 downto 0);
		read_data    : out std_logic_vector(data_size-1 downto 0)
	);
end data_memory;

architecture Behavioral of data_memory is
	type ram_type is array(memory_size-1 downto 0) of std_logic_vector(data_size-1 downto 0);
	signal data_ram : ram_type;

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (MemRead = '1') then
				if (MemWrite = '1') then
					data_ram(to_integer(unsigned(address))) <= write_data;		
				else
					read_data <= data_ram(to_integer(unsigned(address)));
				end if;
			end if;
		end if;
	end process;

end Behavioral;
