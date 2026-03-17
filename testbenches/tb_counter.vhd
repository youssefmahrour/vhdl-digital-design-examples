library ieee;
use ieee.std_logic_1164.all;

entity tb_counter is
end tb_counter;

architecture test of tb_counter is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal count : std_logic_vector(7 downto 0);
    
begin
    -- Clock generation
    clk <= not clk after 10 ns;
    
    -- Reset pulse
    rst <= '0' after 20 ns;
    
    -- Instantiate counter
    uut: entity work.counter
        port map (
            clk => clk,
            rst => rst,
            count => count
        );
    
    -- Stimulus process
    process
    begin
        wait for 200 ns;
        wait;
    end process;
    
end architecture test;