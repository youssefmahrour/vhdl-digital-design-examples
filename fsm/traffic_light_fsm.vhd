library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light_fsm is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        red      : out STD_LOGIC;
        yellow   : out STD_LOGIC;
        green    : out STD_LOGIC
    );
end traffic_light_fsm;

architecture Behavioral of traffic_light_fsm is
    type state_type is (RED, GREEN, YELLOW);
    signal state, next_state : state_type;
    signal counter : unsigned(23 downto 0) := (others => '0'); -- adjust width for timing

    constant RED_TIME    : unsigned(23 downto 0) := to_unsigned(5_000_000, 24);    -- adjust for your clock
    constant GREEN_TIME  : unsigned(23 downto 0) := to_unsigned(5_000_000, 24);
    constant YELLOW_TIME : unsigned(23 downto 0) := to_unsigned(2_000_000, 24);

begin

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            state <= RED;
            counter <= (others => '0');
        elsif rising_edge(clk) then
            state <= next_state;
            if state /= next_state then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Next state logic
    process(state, counter)
    begin
        case state is
            when RED =>
                if counter >= RED_TIME then
                    next_state <= GREEN;
                else
                    next_state <= RED;
                end if;
            when GREEN =>
                if counter >= GREEN_TIME then
                    next_state <= YELLOW;
                else
                    next_state <= GREEN;
                end if;
            when YELLOW =>
                if counter >= YELLOW_TIME then
                    next_state <= RED;
                else
                    next_state <= YELLOW;
                end if;
            when others =>
                next_state <= RED;
        end case;
    end process;

    -- Output logic
    red    <= '1' when state = RED else '0';
    yellow <= '1' when state = YELLOW else '0';
    green  <= '1' when state = GREEN else '0';

end Behavioral;