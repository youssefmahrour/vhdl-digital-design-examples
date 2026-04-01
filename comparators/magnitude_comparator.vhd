library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity magnitude_comparator is
    generic (
        WIDTH : positive := 8
    );
    port (
        a : in std_logic_vector(WIDTH - 1 downto 0);
        b : in std_logic_vector(WIDTH - 1 downto 0);
        greater : out std_logic;
        equal : out std_logic;
        less : out std_logic
    );
end entity magnitude_comparator;

architecture rtl of magnitude_comparator is
begin
    process(a, b)
        variable a_unsigned : unsigned(WIDTH - 1 downto 0);
        variable b_unsigned : unsigned(WIDTH - 1 downto 0);
    begin
        a_unsigned := unsigned(a);
        b_unsigned := unsigned(b);
        
        if a_unsigned > b_unsigned then
            greater <= '1';
            equal <= '0';
            less <= '0';
        elsif a_unsigned = b_unsigned then
            greater <= '0';
            equal <= '1';
            less <= '0';
        else
            greater <= '0';
            equal <= '0';
            less <= '1';
        end if;
    end process;
end architecture rtl;