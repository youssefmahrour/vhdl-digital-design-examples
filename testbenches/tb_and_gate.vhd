library ieee;
use ieee.std_logic_1164.all;

entity tb_and_gate is
end tb_and_gate;

architecture testbench of tb_and_gate is
    component and_gate
        port (
            a : in std_logic;
            b : in std_logic;
            y : out std_logic
        );
    end component;

    signal a_tb : std_logic := '0';
    signal b_tb : std_logic := '0';
    signal y_tb : std_logic;

begin
    dut : and_gate port map (
        a => a_tb,
        b => b_tb,
        y => y_tb
    );

    process
    begin
        -- Test case 1: 0 AND 0 = 0
        a_tb <= '0';
        b_tb <= '0';
        wait for 10 ns;

        -- Test case 2: 0 AND 1 = 0
        a_tb <= '0';
        b_tb <= '1';
        wait for 10 ns;

        -- Test case 3: 1 AND 0 = 0
        a_tb <= '1';
        b_tb <= '0';
        wait for 10 ns;

        -- Test case 4: 1 AND 1 = 1
        a_tb <= '1';
        b_tb <= '1';
        wait for 10 ns;

        wait;
    end process;

end architecture testbench;