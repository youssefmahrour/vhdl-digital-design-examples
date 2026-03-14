library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop is
    Port (
        clk : in STD_LOGIC;
        d   : in STD_LOGIC;
        q   : out STD_LOGIC
    );
end d_flip_flop;

architecture Behavioral of d_flip_flop is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end Behavioral;