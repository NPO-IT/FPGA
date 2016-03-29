--
--	Ivan I. Ovchinnikov
--	last upd.: 2016.01.28
--	
--	8 ��� UART, no parity, ������� - LSB, ��������� 0, �������� 1.
--	������ ����������� �� 80���, ������� �������� 5��/�
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY UART_RX IS
	PORT
	(
-------------------------------������������ ������----------------------------------
		clk			: 	in STD_LOGIC;								-- 80.000.000 Hz
---------------------------------������� ����--------------------------------------
		iRX			: in std_logic;									-- �������� ���
		oData		: out std_logic_vector (7 downto 0);	 		-- ��������� ������������ ���
		oValid		: out std_logic									-- ������ � ����� ������ �����
	);
END UART_RX;

ARCHITECTURE UART_RX_architecture OF UART_RX IS
signal rx_act		: std_logic;									-- ��������������� ������ ���������� �����
signal Valid		: std_logic;
	
BEGIN

oValid<=Valid;
process (clk)
variable place	: integer range 0 to 8 := 0;						-- ����� ���� ���������� � ����������
variable data	: std_logic_vector (7 downto 0);					-- ���������� � �������
variable strtcnt: integer range 0 to 8 := 0;						-- ������� ���������� ����
variable stepcnt: integer range 0 to 16 := 0;						-- ������� ������ ����� ������
variable delay	: integer range 0 to 10 := 0;						-- ���������� ��� ��������� ������� Valid
begin
----------------------------------------------
----- ������� ����, ��������� ��� � ���  ----
----------------------------------------------
if rising_edge(clk) then
	if (Valid = '1') then
		delay := delay + 1;
		if (delay = 9) then delay := 0; Valid <= '0'; end if;
	end if;
																	-- �������� �� ��������� ��������� ������������
	if (iRX = '0') and (rx_act = '0') then							-- ����� ��������� ���
		strtcnt := strtcnt + 1;										-- ��������� �������� ���������� ����
		if (strtcnt = 8) then										--
			rx_act <= '1';											-- ����� ������� �������� ��������
			strtcnt := 0;											-- � ������� ������� ��� ��������� ��������
		end if;														--
	end if;
	if (rx_act = '1') then 											-- ���� �������� ��������� ��������
		stepcnt := stepcnt + 1;										-- ����� ������� ����� ��� ������� ����
		if (stepcnt = 16)then 										-- �������� ����������
			if (place = 8) then 									-- � ����� �����, ���� ����� �� ������� ����������
				if (iRX = '1') then									-- ���� ����� ����-���
					rx_act <= '0';									-- ����� ������� �������� �����������
					Valid <= '1';									-- ����� ������� �������� ����������
					oData <= data;									-- �������� �� ���� ��������� ����������
					place := 0;										-- ������� ��������
					stepcnt := 0;									-- ���������� � ������
				else												-- � ��������� ������
					rx_act <= '0';									-- �������� ��������
					place := 0;										-- ������� ��������
					stepcnt := 0;									-- � �� ������ ����������
				end if;												-- ������� �������� �����
			else													-- � ���� � ��� �� ����� ��������, ��
				data(place) := iRX;									-- ������� � ���������� ������ �� �����
				place := place + 1;									-- �������������� ����� � ����������
				stepcnt := 0;										-- ������� ������� ������
			end if;													-- ��������� � ��� �� ����
		end if;														--
	end if;
end if;
end process;
END UART_RX_architecture;
