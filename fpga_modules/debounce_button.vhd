library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce_button is
    generic (
        CLOCK_FREQ : integer := 50_000_000;  -- 50 MHz clock
        DEBOUNCE_MS : integer := 20           -- 20 ms debounce time
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        button_in : in std_logic;
        button_out : out std_logic
    );
end debounce_button;

architecture rtl of debounce_button is
    constant DEBOUNCE_COUNTER_MAX : integer := (CLOCK_FREQ * DEBOUNCE_MS) / 1_000;
    
    signal sync1 : std_logic;
    signal sync2 : std_logic;
    signal counter : integer range 0 to DEBOUNCE_COUNTER_MAX;
    signal debounced : std_logic;
    
begin
    
    process (clk, reset)
    begin
        if reset = '1' then
            sync1 <= '0';
            sync2 <= '0';
            counter <= 0;
            debounced <= '0';
        elsif rising_edge(clk) then
            -- Metastability synchronizer
            sync1 <= button_in;
            sync2 <= sync1;
            
            -- Debounce logic
            if sync2 = debounced then
                counter <= 0;
            else
                if counter = DEBOUNCE_COUNTER_MAX then
                    debounced <= sync2;
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    button_out <= debounced;
    
end rtl;