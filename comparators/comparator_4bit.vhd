library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
    port (
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        eq : out std_logic;  -- a = b
        lt : out std_logic;  -- a < b
        gt : out std_logic   -- a > b
    );
end entity comparator_4bit;

architecture rtl of comparator_4bit is
begin
    eq <= '1' when a = b else '0';
    lt <= '1' when a < b else '0';
    gt <= '1' when a > b else '0';
end architecture rtl;