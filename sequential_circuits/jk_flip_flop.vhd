library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_flip_flop is
    Port (
        J   : in  STD_LOGIC;
        K   : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
        Q   : out STD_LOGIC;
        Qn  : out STD_LOGIC
    );
end jk_flip_flop;

architecture Behavioral of jk_flip_flop is
    signal q_int : STD_LOGIC := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            case (J & K) is
                when "00" => q_int <= q_int;         -- No change
                when "01" => q_int <= '0';           -- Reset
                when "10" => q_int <= '1';           -- Set
                when "11" => q_int <= not q_int;     -- Toggle
                when others => q_int <= q_int;
            end case;
        end if;
    end process;

    Q  <= q_int;
    Qn <= not q_int;
end Behavioral;