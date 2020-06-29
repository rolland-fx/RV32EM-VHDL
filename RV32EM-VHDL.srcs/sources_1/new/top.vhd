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
--signaux
begin
	MainControl:Process(i_clk) is -- processus synchrone
		begin
			if rising_edge(i_clk) then -- sur front montant d'horloge
				if i_reset = '0' then -- reset synchrone =� remise de tout les registres � z�ro
					if i_run = '1' then
					-- here when it runs
					end if; 
				else -- reset =� remise a z�ro de tout les registres
				--reset stages
				end if;
			end if;
		end process;
end Behavioral;