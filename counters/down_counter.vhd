library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity down_counter is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
        count   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end down_counter;

architecture Behavioral of down_counter is
    signal cnt : unsigned(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                cnt <= cnt - 1;
            end if;
        end if;
    end process;
    count <= std_logic_vector(cnt);
end Behavioral;