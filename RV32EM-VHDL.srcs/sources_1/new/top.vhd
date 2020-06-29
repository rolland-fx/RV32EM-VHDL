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
signal s_sig_1 : std_logic_vector(31 downto 0); -- signal de sortie pipelin�
signal s_sig_2 : std_logic_vector(31 downto 0); -- signal de sortie pipelin�
signal s_sig_3 : std_logic_vector(31 downto 0); -- signal de sortie pipelin�
signal s_sig_4 : std_logic_vector(31 downto 0); -- signal de sortie pipelin�
signal s_sig_5 : std_logic_vector(31 downto 0); -- signal de sortie pipelin�
begin
	MainControl:Process(i_clk) is -- processus synchrone
		begin
			if rising_edge(i_clk) then -- sur front montant d'horloge
				if i_reset = '0' then -- reset synchrone =� remise de tout les registres � z�ro
					if i_run = '1' then
					   s_sig_2 <= s_sig_1;
					   s_sig_3 <= s_sig_2;
					   s_sig_4 <= s_sig_3;
					   s_sig_5 <= s_sig_4;	
					end if; 
				else -- reset =� remise a z�ro de tout les registres
				s_sig_1 <= (others => '0');
				s_sig_2 <= (others => '0'); 
				s_sig_3 <= (others => '0'); 
				s_sig_4 <= (others => '0'); 
				s_sig_5 <= (others => '0'); 		
				end if;
			end if;
		end process;
end Behavioral;