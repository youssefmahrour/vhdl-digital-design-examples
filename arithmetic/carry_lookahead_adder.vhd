library ieee;
use ieee.std_logic_1164.all;

entity carry_lookahead_adder is
    port (
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity carry_lookahead_adder;

architecture rtl of carry_lookahead_adder is
    signal p : std_logic_vector(3 downto 0);
    signal g : std_logic_vector(3 downto 0);
    signal c : std_logic_vector(4 downto 0);
begin
    -- Generate propagate and generate signals
    p <= a xor b;
    g <= a and b;
    
    -- Carry lookahead logic
    c(0) <= cin;
    c(1) <= g(0) or (p(0) and c(0));
    c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c(0));
    c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c(0));
    c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and c(0));
    
    -- Sum outputs
    sum <= p xor c(3 downto 0);
    cout <= c(4);
end architecture rtl;