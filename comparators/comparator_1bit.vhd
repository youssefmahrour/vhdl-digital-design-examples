library ieee;
use ieee.std_logic_1164.all;

entity comparator_1bit is
    port (
        a : in std_logic;
        b : in std_logic;
        eq : out std_logic;
        gt : out std_logic;
        lt : out std_logic
    );
end entity comparator_1bit;

architecture rtl of comparator_1bit is
begin
    eq <= '1' when a = b else '0';
    gt <= '1' when a > b else '0';
    lt <= '1' when a < b else '0';
end architecture rtl;