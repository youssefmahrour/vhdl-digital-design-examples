library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_master is
    generic (
        CLK_FREQ : integer := 100_000_000;  -- Clock frequency in Hz
        I2C_FREQ : integer := 400_000       -- I2C frequency in Hz
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        
        -- I2C interface
        scl         : inout std_logic;
        sda         : inout std_logic;
        
        -- Control interface
        start       : in std_logic;
        stop        : in std_logic;
        write_en    : in std_logic;
        read_en     : in std_logic;
        data_in     : in std_logic_vector(7 downto 0);
        data_out    : out std_logic_vector(7 downto 0);
        
        -- Status
        busy        : out std_logic;
        ack_received : out std_logic;
        ready       : out std_logic
    );
end entity i2c_master;

architecture rtl of i2c_master is
    
    constant DIVIDER : integer := (CLK_FREQ / (I2C_FREQ * 4)) - 1;
    
    type state_type is (IDLE, START_COND, STOP_COND, WRITE_BIT, READ_BIT, ACK_BIT);
    signal state : state_type := IDLE;
    
    signal clk_counter : integer range 0 to DIVIDER;
    signal i2c_clk : std_logic;
    signal scl_buf : std_logic := '1';
    signal sda_buf : std_logic := '1';
    
begin
    
    -- I2C clock divider
    process(clk, reset)
    begin
        if reset = '1' then
            clk_counter <= 0;
            i2c_clk <= '0';
        elsif rising_edge(clk) then
            if clk_counter = DIVIDER then
                clk_counter <= 0;
                i2c_clk <= not i2c_clk;
            else
                clk_counter <= clk_counter + 1;
            end if;
        end if;
    end process;
    
    -- I2C state machine
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            scl_buf <= '1';
            sda_buf <= '1';
            busy <= '0';
            ready <= '1';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= START_COND;
                        busy <= '1';
                        ready <= '0';
                    end if;
                    
                when START_COND =>
                    sda_buf <= '0';
                    scl_buf <= '0';
                    state <= IDLE;
                    
                when STOP_COND =>
                    scl_buf <= '1';
                    sda_buf <= '1';
                    state <= IDLE;
                    busy <= '0';
                    ready <= '1';
                    
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
    
    -- Open-drain output drivers
    scl <= '0' when scl_buf = '0' else 'Z';
    sda <= '0' when sda_buf = '0' else 'Z';
    
end architecture rtl;