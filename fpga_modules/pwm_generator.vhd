library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (
        COUNTER_WIDTH : integer := 8  -- PWM resolution (bits)
    );
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        duty     : in  unsigned(COUNTER_WIDTH-1 downto 0); -- Duty cycle input
        pwm_out  : out std_logic
    );
end entity pwm_generator;

architecture Behavioral of pwm_generator is
    signal counter : unsigned(COUNTER_WIDTH-1 downto 0) := (others => '0');
begin

    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            pwm_out <= '0';
        elsif rising_edge(clk) then
            if counter = (2**COUNTER_WIDTH - 1) then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;

            if counter < duty then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end architecture Behavioral;