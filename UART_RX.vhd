--
--	Ivan I. Ovchinnikov
--	last upd.: 2016.01.28
--	
--	8 бит UART, no parity, порядок - LSB, стартовый 0, стоповый 1.
--	модуль тактируется от 80МГц, битрейт передачи 5Мб/с
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY UART_RX IS
	PORT
	(
-------------------------------Тактирование модуля----------------------------------
		clk			: 	in STD_LOGIC;								-- 80.000.000 Hz
---------------------------------Приёмник УАРТ--------------------------------------
		iRX			: in std_logic;									-- входящий ПСК
		oData		: out std_logic_vector (7 downto 0);	 		-- исходящий параллельный код
		oValid		: out std_logic									-- сигнал о приёме одного байта
	);
END UART_RX;

ARCHITECTURE UART_RX_architecture OF UART_RX IS
signal rx_act		: std_logic;									-- вспомогательный сигнал разрешения приёма
signal Valid		: std_logic;
	
BEGIN

oValid<=Valid;
process (clk)
variable place	: integer range 0 to 8 := 0;						-- номер бита информации в переменной
variable data	: std_logic_vector (7 downto 0);					-- переменная с ответом
variable strtcnt: integer range 0 to 8 := 0;						-- счётчик стартового бита
variable stepcnt: integer range 0 to 16 := 0;						-- счётчик тактов между битами
variable delay	: integer range 0 to 10 := 0;						-- задержечка для удлинения сигнала Valid
begin
----------------------------------------------
----- Приёмник УАРТ, конвертер ПСК в ПРК  ----
----------------------------------------------
if rising_edge(clk) then
	if (Valid = '1') then
		delay := delay + 1;
		if (delay = 9) then delay := 0; Valid <= '0'; end if;
	end if;
																	-- передача по умолчанию считается некорректной
	if (iRX = '0') and (rx_act = '0') then							-- ловим стартовый бит
		strtcnt := strtcnt + 1;										-- отсчитаем середину стартового бита
		if (strtcnt = 8) then										--
			rx_act <= '1';											-- будем считать передачу активной
			strtcnt := 0;											-- и обнулим счётчик для следующей передачи
		end if;														--
	end if;
	if (rx_act = '1') then 											-- если передача считается активной
		stepcnt := stepcnt + 1;										-- начнём считать такты для каждого бита
		if (stepcnt = 16)then 										-- полезной информации
			if (place = 8) then 									-- в конце байта, если вышли за пределы переменной
				if (iRX = '1') then									-- если нашли стоп-бит
					rx_act <= '0';									-- будем считать передачу законченной
					Valid <= '1';									-- будем считать передачу корректной
					oData <= data;									-- отправим на шину собранную переменную
					place := 0;										-- обнулим счётчики
					stepcnt := 0;									-- информации и тактов
				else												-- в противном случае
					rx_act <= '0';									-- закончим передачу
					place := 0;										-- обнулим счётчики
					stepcnt := 0;									-- и не станем отправлять
				end if;												-- никаких сигналов более
			else													-- а если у нас не конец передачи, то
				data(place) := iRX;									-- запишем в переменную сигнал со входа
				place := place + 1;									-- инкрементируем место в переменной
				stepcnt := 0;										-- сбросим счётчик тактов
			end if;													-- продолжим в том же духе
		end if;														--
	end if;
end if;
end process;
END UART_RX_architecture;
