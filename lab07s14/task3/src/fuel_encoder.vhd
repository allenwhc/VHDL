-------------------------------------------------------------------------------
--
-- Title       : fuel_encoder
-- Design-name : task3
-- Author      : Haochen Wang
-- Experiment  : Lab 7
-- Section     : 
-------------------------------------------------------------------------------
--
-- File        : fuel_encoder.vhd
-- Generated   : Tue Apr  1 09:04:34 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Fuel Encoder
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {fuel_encoder} architecture {fuel_encoder}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fuel_encoder is
	 port(
		 fuel : in STD_LOGIC_VECTOR(3 downto 0);
		 empty : out STD_LOGIC;
		 leds : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end fuel_encoder;

--}} End of automatically maintained section

architecture fuel_encoder of fuel_encoder is
begin

	process (fuel)
		begin
		case fuel(3 downto 2) is
			when "00" => leds <= "1110"; -- 0 <= fuel < 1/4
			when "01" => leds <= "1100"; -- 1/4 <= fuel < 1/2
			when "10" => leds <= "1000"; -- 1/2 <= fuel < 3/4
			when "11" => leds <= "0000"; -- 3/4 <= fuel <= max
			when others => leds <= "1111"; -- all LEDs off indicates error
		end case;
	end process;
	empty <= '0' when fuel(3 downto 1) = "000" else '1';

end fuel_encoder;
