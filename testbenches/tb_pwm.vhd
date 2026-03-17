library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pwm is
end entity tb_pwm;

architecture testbench of tb_pwm is
    -- Component declaration
    component pwm is
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            duty_cycle  : in std_logic_vector(7 downto 0);
            pwm_out     : out std_logic
        );
    end component pwm;

    -- Signals
    signal clk         : std_logic := '0';
    signal rst         : std_logic := '1';
    signal duty_cycle  : std_logic_vector(7 downto 0) := (others => '0');
    signal pwm_out     : std_logic;

    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the PWM module
    uut : pwm port map (
        clk         => clk,
        rst         => rst,
        duty_cycle  => duty_cycle,
        pwm_out     => pwm_out
    );

    -- Clock generation
    clk <= not clk after CLK_PERIOD / 2;

    -- Test process
    process
    begin
        -- Reset
        rst <= '1';
        wait for CLK_PERIOD * 10;
        rst <= '0';

        -- Test different duty cycles
        duty_cycle <= x"00";  -- 0%
        wait for 100 us;

        duty_cycle <= x"7F";  -- ~50%
        wait for 100 us;

        duty_cycle <= x"FF";  -- 100%
        wait for 100 us;

        wait;
    end process;

end architecture testbench;