library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_n_counter is
    generic (
        N : integer := 10  -- Set the modulus value here
    );
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        en    : in  std_logic;
        count : out unsigned(integer(ceil(log2(real(N))))-1 downto 0)
    );
end entity mod_n_counter;

architecture Behavioral of mod_n_counter is
    constant COUNTER_WIDTH : integer := integer(ceil(log2(real(N))));
    signal cnt : unsigned(COUNTER_WIDTH-1 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                if cnt = N-1 then
                    cnt <= (others => '0');
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    count <= cnt;
end architecture Behavioral;