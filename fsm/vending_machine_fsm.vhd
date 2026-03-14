library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vending_machine_fsm is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        coin_5   : in  STD_LOGIC; -- 5 unit coin
        coin_10  : in  STD_LOGIC; -- 10 unit coin
        select   : in  STD_LOGIC; -- select item
        dispense : out STD_LOGIC;
        change   : out STD_LOGIC
    );
end vending_machine_fsm;

architecture Behavioral of vending_machine_fsm is
    type state_type is (IDLE, S5, S10, S15, DISPENSE, CHANGE);
    signal state, next_state : state_type;
begin

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Next state logic
    process(state, coin_5, coin_10, select)
    begin
        next_state <= state;
        case state is
            when IDLE =>
                if coin_5 = '1' then
                    next_state <= S5;
                elsif coin_10 = '1' then
                    next_state <= S10;
                end if;
            when S5 =>
                if coin_5 = '1' then
                    next_state <= S10;
                elsif coin_10 = '1' then
                    next_state <= S15;
                end if;
            when S10 =>
                if coin_5 = '1' then
                    next_state <= S15;
                elsif coin_10 = '1' then
                    next_state <= CHANGE; -- 20 units, overpay
                elsif select = '1' then
                    next_state <= DISPENSE; -- 10 units, exact
                end if;
            when S15 =>
                if select = '1' then
                    next_state <= CHANGE; -- 15 units, overpay
                end if;
            when DISPENSE =>
                next_state <= IDLE;
            when CHANGE =>
                next_state <= IDLE;
            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- Output logic
    process(state, select)
    begin
        dispense <= '0';
        change   <= '0';
        case state is
            when DISPENSE =>
                dispense <= '1';
            when CHANGE =>
                change <= '1';
            when others =>
                dispense <= '0';
                change   <= '0';
        end case;
    end process;

end Behavioral;