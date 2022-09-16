///////////////////////////////////////
// TSN Lab 미니인턴
// 추가 과제 2
// 작성: 노지훈
// 1차 완성일: 
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module dut_7segment_2(
	input clk,
	input rst,
	output [7:0] seg0,
	output [7:0] seg1,
	output [7:0] seg2
);
	integer count = 0;
	reg [7:0] s0;
	reg [7:0] s1;
	reg [7:0] s2;

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
	// assign if에서 case로 변경
	case (count0)
		0 : s0 <= 8'b11111100; //0, d252
		1 : s0 <= 8'b01100000; //1, d96
		2 : s0 <= 8'b11011010; //2, d218
		3 : s0 <= 8'b11110010; //3, d242
		4 : s0 <= 8'b01100110; //4, d102
		5 : s0 <= 8'b10110110; //5, d182
		6 : s0 <= 8'b10111110; //6, d190
		7 : s0 <= 8'b11100000; //7, d224
		8 : s0 <= 8'b11111110; //8, d254
		9 : s0 <= 8'b11100110; //9, d230
		default: s0 <= 8'b00000000; //error
	endcase
	case (count1)
		0 : s1 <= 8'b11111100; //0, d252
		1 : s1 <= 8'b01100000; //1, d96
		2 : s1 <= 8'b11011010; //2, d218
		3 : s1 <= 8'b11110010; //3, d242
		4 : s1 <= 8'b01100110; //4, d102
		5 : s1 <= 8'b10110110; //5, d182
		6 : s1 <= 8'b10111110; //6, d190
		7 : s1 <= 8'b11100000; //7, d224
		8 : s1 <= 8'b11111110; //8, d254
		9 : s1 <= 8'b11100110; //9, d230
		default: s1 <= 8'b00000000; //error
	endcase
	case (count2)
		0 : s2 <= 8'b11111100; //0, d252
		1 : s2 <= 8'b01100000; //1, d96
		2 : s2 <= 8'b11011010; //2, d218
		3 : s2 <= 8'b11110010; //3, d242
		4 : s2 <= 8'b01100110; //4, d102
		5 : s2 <= 8'b10110110; //5, d182
		6 : s2 <= 8'b10111110; //6, d190
		7 : s2 <= 8'b11100000; //7, d224
		8 : s2 <= 8'b11111110; //8, d254
		9 : s2 <= 8'b11100110; //9, d230
		default: s2 <= 8'b00000000; //error
	endcase
end

// 최종 output인 seg에 값 할당
assign seg0 = s0;
assign seg1 = s1; 
assign seg2 = s2; 

endmodule