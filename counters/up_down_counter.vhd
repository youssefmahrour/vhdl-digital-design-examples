library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        up_down : in  STD_LOGIC; -- '1' for up, '0' for down
        count   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end up_down_counter;

architecture Behavioral of up_down_counter is
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if up_down = '1' then
                cnt <= cnt + 1;
            else
                cnt <= cnt - 1;
            end if;
        end if;
    end process;

    count <= std_logic_vector(cnt);
end Behavioral;