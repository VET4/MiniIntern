///////////////////////////////////////
// TSN Lab 미니인턴
// 추가 과제 1
// 작성: 노지훈
// 1차 완성일: 
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module dut_7segment_2(
	input clk,
	input rst,
	output [7:0] seg
);
	integer count = 0;
	reg [7:0] s;

// 리셋 여부에 대한 내부 count 동작 선언
always @ (posedge clk) begin
	if (rst == 1) begin
		count = 0;
	end else begin
		if (count == 9) begin
			count = 0;
		end else begin
			count = count + 1;
		end
	end
end

// count 값에 따른 7-segment 선언
always @ (negedge clk) begin
	s <= 	(count == 0) ? 8'b11111100: //0
			(count == 1) ? 8'b01100000: //1
			(count == 2) ? 8'b11011010: //2
			(count == 3) ? 8'b11110010: //3
			(count == 4) ? 8'b01100110: //4
			(count == 5) ? 8'b10110110: //5
			(count == 6) ? 8'b10111110: //6
			(count == 7) ? 8'b11100000: //7
			(count == 8) ? 8'b11111110: //8
			(count == 9) ? 8'b11100110: 8'b00000000; // 9, error: 0
end

// 최종 output인 seg에 값 할당
assign seg = s; 

endmodule