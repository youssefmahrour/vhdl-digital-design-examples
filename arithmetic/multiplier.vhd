library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
    generic (
        WIDTH : positive := 8
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        a : in std_logic_vector(WIDTH-1 downto 0);
        b : in std_logic_vector(WIDTH-1 downto 0);
        product : out std_logic_vector(2*WIDTH-1 downto 0)
    );
end entity multiplier;

architecture rtl of multiplier is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            product <= (others => '0');
        elsif rising_edge(clk) then
            product <= std_logic_vector(unsigned(a) * unsigned(b));
        end if;
    end process;
end architecture rtl;