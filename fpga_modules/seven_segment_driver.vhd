library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment_driver is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        digit : in STD_LOGIC_VECTOR(3 downto 0);
        segments : out STD_LOGIC_VECTOR(6 downto 0)
    );
end seven_segment_driver;

architecture Behavioral of seven_segment_driver is
begin
    process(digit)
    begin
        case digit is
            when "0000" => segments <= "0111111"; -- 0
            when "0001" => segments <= "0000110"; -- 1
            when "0010" => segments <= "1011011"; -- 2
            when "0011" => segments <= "1001111"; -- 3
            when "0100" => segments <= "1100110"; -- 4
            when "0101" => segments <= "1101101"; -- 5
            when "0110" => segments <= "1111101"; -- 6
            when "0111" => segments <= "0000111"; -- 7
            when "1000" => segments <= "1111111"; -- 8
            when "1001" => segments <= "1101111"; -- 9
            when others => segments <= "0000000";
        end case;
    end process;
end Behavioral;