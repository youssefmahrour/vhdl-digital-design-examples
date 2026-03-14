library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    generic (
        CLK_FREQ   : integer := 50000000; -- Hz
        BAUD_RATE  : integer := 115200
    );
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        tx_start : in  std_logic;
        tx_data  : in  std_logic_vector(7 downto 0);
        tx_busy  : out std_logic;
        tx       : out std_logic
    );
end entity uart_tx;

architecture Behavioral of uart_tx is
    constant BAUD_TICK_CNT : integer := CLK_FREQ / BAUD_RATE;
    type state_type is (IDLE, START, DATA, STOP);
    signal state      : state_type := IDLE;
    signal baud_cnt   : integer range 0 to BAUD_TICK_CNT-1 := 0;
    signal bit_idx    : integer range 0 to 7 := 0;
    signal tx_shift   : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_reg     : std_logic := '1';
    signal busy_reg   : std_logic := '0';
begin

    tx <= tx_reg;
    tx_busy <= busy_reg;

    process(clk, rst)
    begin
        if rst = '1' then
            state    <= IDLE;
            baud_cnt <= 0;
            bit_idx  <= 0;
            tx_shift <= (others => '0');
            tx_reg   <= '1';
            busy_reg <= '0';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    tx_reg   <= '1';
                    busy_reg <= '0';
                    if tx_start = '1' then
                        tx_shift <= tx_data;
                        baud_cnt <= 0;
                        bit_idx  <= 0;
                        state    <= START;
                        busy_reg <= '1';
                    end if;

                when START =>
                    tx_reg <= '0'; -- Start bit
                    if baud_cnt = BAUD_TICK_CNT-1 then
                        baud_cnt <= 0;
                        state    <= DATA;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when DATA =>
                    tx_reg <= tx_shift(bit_idx);
                    if baud_cnt = BAUD_TICK_CNT-1 then
                        baud_cnt <= 0;
                        if bit_idx = 7 then
                            state <= STOP;
                        else
                            bit_idx <= bit_idx + 1;
                        end if;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when STOP =>
                    tx_reg <= '1'; -- Stop bit
                    if baud_cnt = BAUD_TICK_CNT-1 then
                        baud_cnt <= 0;
                        state    <= IDLE;
                        busy_reg <= '0';
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;

end architecture Behavioral;