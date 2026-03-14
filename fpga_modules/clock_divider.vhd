library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    generic (
        DIVIDE_BY : integer := 2  -- Divide input clock by this value (must be >=2)
    );
    port (
        clk_in  : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end entity clock_divider;

architecture Behavioral of clock_divider is
    signal counter : unsigned((integer(ceil(log2(real(DIVIDE_BY)))))-1 downto 0) := (others => '0');
    signal clk_reg : std_logic := '0';
begin

    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            clk_reg <= '0';
        elsif rising_edge(clk_in) then
            if counter = DIVIDE_BY/2 - 1 then
                clk_reg <= not clk_reg;
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;

end architecture Behavioral;