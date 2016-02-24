/*
	Svyatoslav Mishin
	last upd.: 2016.02.24
	8bit UART, startbit 0, stopbit 1,
	no parity
*/
module UARTRXn(
    input wire clkIN, // ������� ���� 80���
    input wire nResetIN, // ������ �����
    input wire Rx, // ����� Rx
    output reg[7:0] dataOUT, // ���� ��� �������� ��������� ������	
    output reg done // ������ ���������� ������
    );
`define READY 0 // �������� ������ ��������
`define ONCENTER 1 // �������� � ����� ����
`define STARTBIT 2 // �������� ���������� ����
`define HOLD 3 // ����� �������� ����� ������
`define BIT 4 // ������ �������� �������� �� ����� Rx
`define STOPBIT 5 // �������� �� �������

reg[3:0]state; 
reg[3:0]cnt1Clk;
reg[3:0]cnt2Clk;
reg[3:0]cntBIT;
reg [1:0] sync_reg_Rx; 
always @ (posedge clkIN)
begin
	sync_reg_Rx[1:0] <= {sync_reg_Rx[0],Rx}; // 2� �������� ��� ������������� ������� � 80��� ��� ���������� ����������������
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
				if(~sync_reg_Rx[1]) // ���� Rx ������� � 0 (������ ��������)
				begin
					state<=`ONCENTER;
					done<=1'b0;// ����� ����� ���������� ������
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
				if(~sync_reg_Rx[1]) // �������� �� ��������� ���
				begin
					state<=`HOLD; 
				end		
				else
				    state<=`READY;
			end
			`HOLD: // �������� �� �������� � ��������� ���
			begin
				if(cnt2Clk==4'b1110)
				begin
					if(cntBIT==4'b1000)//���� ������� 8 ���
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
				dataOUT <= { sync_reg_Rx[1], dataOUT[7:1] };// ��������� �������
				cntBIT<=cntBIT+1'b1;
				state<=`HOLD;
			end
			`STOPBIT:
			begin
				if(sync_reg_Rx[1])// �������� �� �������
			        done<=1'b1;// ���������� ������
				state<=`READY;
			end
			default :
			    state<=`READY;
		endcase
	end
endmodule