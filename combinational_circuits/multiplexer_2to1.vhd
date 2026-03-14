library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer_2to1 is
    Port (
        a    : in  STD_LOGIC;
        b    : in  STD_LOGIC;
        sel  : in  STD_LOGIC;
        y    : out STD_LOGIC
    );
end multiplexer_2to1;

architecture Behavioral of multiplexer_2to1 is
begin
    y <= a when sel = '0' else b;
end Behavioral;