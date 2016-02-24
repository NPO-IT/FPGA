/*
	Svyatoslav Mishin
	last upd.: 2016.02.24
	8bit UART, startbit 0, stopbit 1,
	no parity
*/
module UARTRXn(
    input wire clkIN, // Входной клок 80Мгц
    input wire nResetIN, // Сигнал ресет
    input wire Rx, // Линия Rx
    output reg[7:0] dataOUT, // Шина для передачи пришедших данных	
    output reg done // Сигнал готовности данных
    );
`define READY 0 // Ожидание начала передачи
`define ONCENTER 1 // Смещение в центр бита
`define STARTBIT 2 // Проверка стартового бита
`define HOLD 3 // Время задержки между битами
`define BIT 4 // Чтение текущего значения на линии Rx
`define STOPBIT 5 // Проверка на стопбит

reg[3:0]state; 
reg[3:0]cnt1Clk;
reg[3:0]cnt2Clk;
reg[3:0]cntBIT;
reg [1:0] sync_reg_Rx; 
always @ (posedge clkIN)
begin
	sync_reg_Rx[1:0] <= {sync_reg_Rx[0],Rx}; // 2д триггера для синхронизации сигнала с 80Мгц для устранения метастабильности
end
always @ (posedge clkIN)
    if (~nResetIN) 
    begin
		 state<=`READY;
		 done<=0;
		 dataOUT<=0;
		 cnt1Clk<=0;
		 cnt2Clk<=0;
		 cntBIT<=0;
    end
    else
    begin    
		case (state)
			`READY:
			begin
				if(~sync_reg_Rx[1]) // Если Rx перешел в 0 (начало передачи)
				begin
					state<=`ONCENTER;
					done<=1'b0;// Сброс флага готовности данных
				end
				cnt1Clk<=4'b0000;
				cnt2Clk<=4'b0000;
				cntBIT<=4'b0000;
			end
			`ONCENTER:
			begin
				if(cnt1Clk==4'b0110)
					state<=`STARTBIT;
				else
					cnt1Clk<=cnt1Clk+1'b1;
			end
			`STARTBIT:
			begin
				if(~sync_reg_Rx[1]) // Проверка на стартовый бит
				begin
					state<=`HOLD; 
				end		
				else
				    state<=`READY;
			end
			`HOLD: // Задержка до перехода в следующий бит
			begin
				if(cnt2Clk==4'b1110)
				begin
					if(cntBIT==4'b1000)//Если приняли 8 бит
					begin
						state<=`STOPBIT;
					end
					else
					begin
						state<=`BIT;
					end
					cnt2Clk<=4'b0000;
				end
				else
					cnt2Clk<=cnt2Clk+1'b1;
			end
			`BIT:
			begin
				dataOUT <= { sync_reg_Rx[1], dataOUT[7:1] };// Сдвиговый регистр
				cntBIT<=cntBIT+1'b1;
				state<=`HOLD;
			end
			`STOPBIT:
			begin
				if(sync_reg_Rx[1])// Проверка на стопбит
			        done<=1'b1;// Готовность данных
				state<=`READY;
			end
			default :
			    state<=`READY;
		endcase
	end
endmodule