library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end nand_gate;

architecture Behavioral of nand_gate is
begin
    Y <= not (A and B);
end Behavioral;