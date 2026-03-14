library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Simple SR Latch
entity latch is
    Port (
        S : in  STD_LOGIC;  -- Set input
        R : in  STD_LOGIC;  -- Reset input
        Q : out STD_LOGIC;  -- Output
        Qn: out STD_LOGIC   -- Inverted Output
    );
end latch;

architecture Behavioral of latch is
begin
    process(S, R)
    begin
        if (S = '1' and R = '0') then
            Q  <= '1';
            Qn <= '0';
        elsif (S = '0' and R = '1') then
            Q  <= '0';
            Qn <= '1';
        elsif (S = '0' and R = '0') then
            -- Hold previous state (latch)
            -- No assignment, outputs retain value
        else
            Q  <= 'X'; -- Invalid state
            Qn <= 'X';
        end if;
    end process;
end Behavioral;