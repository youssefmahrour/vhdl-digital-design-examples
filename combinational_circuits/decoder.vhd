library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 2-to-4 line decoder with enable
entity decoder is
    Port (
        en  : in  STD_LOGIC;
        a   : in  STD_LOGIC_VECTOR (1 downto 0);
        y   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end decoder;

architecture Behavioral of decoder is
begin
    process(en, a)
    begin
        if en = '1' then
            case a is
                when "00" => y <= "0001";
                when "01" => y <= "0010";
                when "10" => y <= "0100";
                when "11" => y <= "1000";
                when others => y <= "0000";
            end case;
        else
            y <= "0000";
        end if;
    end process;
end Behavioral;