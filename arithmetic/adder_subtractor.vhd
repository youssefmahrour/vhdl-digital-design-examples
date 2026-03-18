library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
    generic (
        WIDTH : positive := 8
    );
    port (
        a       : in  std_logic_vector(WIDTH-1 downto 0);
        b       : in  std_logic_vector(WIDTH-1 downto 0);
        sel     : in  std_logic;  -- '0' for add, '1' for subtract
        result  : out std_logic_vector(WIDTH-1 downto 0);
        carry   : out std_logic;
        overflow: out std_logic
    );
end entity adder_subtractor;

architecture rtl of adder_subtractor is
    signal extended_a : std_logic_vector(WIDTH downto 0);
    signal extended_b : std_logic_vector(WIDTH downto 0);
    signal temp_result : std_logic_vector(WIDTH downto 0);
begin
    process(a, b, sel)
        variable b_complement : std_logic_vector(WIDTH-1 downto 0);
    begin
        extended_a <= '0' & a;
        
        if sel = '1' then
            b_complement := std_logic_vector(unsigned(b) xor to_unsigned((2**WIDTH)-1, WIDTH));
            extended_b <= '0' & std_logic_vector(unsigned(b_complement) + 1);
        else
            extended_b <= '0' & b;
        end if;
        
        temp_result <= std_logic_vector(unsigned(extended_a) + unsigned(extended_b));
    end process;
    
    result <= temp_result(WIDTH-1 downto 0);
    carry <= temp_result(WIDTH);
    overflow <= (a(WIDTH-1) xor b(WIDTH-1) xor temp_result(WIDTH-1)) and not sel;
end architecture rtl;