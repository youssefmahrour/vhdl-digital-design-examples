library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    Generic (
        N : integer := 8  -- Width of the shift register
    );
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        din   : in  STD_LOGIC;
        dout  : out STD_LOGIC;
        q     : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end shift_register;

architecture Behavioral of shift_register is
    signal reg : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            reg <= reg(N-2 downto 0) & din;
        end if;
    end process;

    dout <= reg(N-1);
    q <= reg;
end Behavioral;