library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 1-to-4 Demultiplexer
entity demultiplexer is
    Port (
        din  : in  STD_LOGIC;
        sel  : in  STD_LOGIC_VECTOR(1 downto 0);
        dout : out STD_LOGIC_VECTOR(3 downto 0)
    );
end demultiplexer;

architecture Behavioral of demultiplexer is
begin
    process(din, sel)
    begin
        dout <= (others => '0');
        case sel is
            when "00" => dout(0) <= din;
            when "01" => dout(1) <= din;
            when "10" => dout(2) <= din;
            when "11" => dout(3) <= din;
            when others => dout <= (others => '0');
        end case;
    end process;
end Behavioral;