library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder is
end tb_full_adder;

architecture sim of tb_full_adder is
    component full_adder is
        port (
            a     : in  std_logic;
            b     : in  std_logic;
            cin   : in  std_logic;
            sum   : out std_logic;
            cout  : out std_logic
        );
    end component;

    signal a_tb, b_tb, cin_tb : std_logic;
    signal sum_tb, cout_tb    : std_logic;

begin
    uut : full_adder port map (
        a    => a_tb,
        b    => b_tb,
        cin  => cin_tb,
        sum  => sum_tb,
        cout => cout_tb
    );

    process
    begin
        -- Test all 8 input combinations
        for i in 0 to 7 loop
            a_tb   <= std_logic(to_unsigned(i, 3)(2));
            b_tb   <= std_logic(to_unsigned(i, 3)(1));
            cin_tb <= std_logic(to_unsigned(i, 3)(0));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end sim;