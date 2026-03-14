library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 8-to-3 Encoder
entity encoder is
    Port (
        data_in : in  STD_LOGIC_VECTOR(7 downto 0);
        code_out : out STD_LOGIC_VECTOR(2 downto 0)
    );
end encoder;

architecture Behavioral of encoder is
begin
    process(data_in)
    begin
        case data_in is
            when "00000001" => code_out <= "000";
            when "00000010" => code_out <= "001";
            when "00000100" => code_out <= "010";
            when "00001000" => code_out <= "011";
            when "00010000" => code_out <= "100";
            when "00100000" => code_out <= "101";
            when "01000000" => code_out <= "110";
            when "10000000" => code_out <= "111";
            when others      => code_out <= "---"; -- invalid input
        end case;
    end process;
end Behavioral;