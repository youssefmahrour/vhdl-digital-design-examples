library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_4bit is
    port (
        a       : in  std_logic_vector(3 downto 0);
        b       : in  std_logic_vector(3 downto 0);
        op      : in  std_logic_vector(2 downto 0);
        result  : out std_logic_vector(3 downto 0);
        carry   : out std_logic
    );
end entity alu_4bit;

architecture rtl of alu_4bit is
    signal temp : std_logic_vector(4 downto 0);
begin
    process(a, b, op)
    begin
        case op is
            when "000" => -- Addition
                temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
            when "001" => -- Subtraction
                temp <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));
            when "010" => -- AND
                temp <= '0' & (a and b);
            when "011" => -- OR
                temp <= '0' & (a or b);
            when "100" => -- XOR
                temp <= '0' & (a xor b);
            when "101" => -- NOT A
                temp <= '0' & (not a);
            when others => temp <= "00000";
        end case;
    end process;
    
    result <= temp(3 downto 0);
    carry <= temp(4);
end architecture rtl;