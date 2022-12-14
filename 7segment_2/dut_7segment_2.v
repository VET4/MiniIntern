///////////////////////////////////////
// TSN Lab 미니인턴
// 추가 과제 1
// 작성: 노지훈
// 1차 완성일: 20220917
// 2차 완성일: 20220921
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module dut_7segment_2(
	input clk,
	input rst,
	// 3자릿수 Segment 인풋
	output [7:0] seg0,
	output [7:0] seg1,
	output [7:0] seg2
);
	// 000 ~ 999까지 세는 카운터용 변수 선언
	integer total_count = 0;
	// 자릿수 별 값 할당을 위한 변수 선언
	integer count0 = 0;
	integer count1 = 0;
	integer count2 = 0;
	reg [7:0] s0;
	reg [7:0] s1;
	reg [7:0] s2;

// 리셋 여부에 대한 내부 count 동작 선언
always @ (posedge clk) begin
	// 리셋 초기화 조건
	if (rst == 1) begin
		total_count = 0;
	end else begin
		// 999 넘을 경우 초기화 조건
		if (total_count == 999) begin
			total_count = 0;
			count0 = 0;
			count1 = 0;
			count2 = 0;
		// 전체 카운터에서 각 자릿수로 할당하기 위해 숫자 분리
		end else begin
			total_count = total_count + 1;
			count0 = total_count % 10;
			count1 = ((total_count) / 10) % 10;
			count2 = ((total_count) / 100) % 10;
		end
	end
end

// 7 segment 할당 반복작업 task로 정의
task convert(
	input [31:0] count,
	output reg [7:0] s
);
	case (count)
		0 : s = 8'b11111100; //0, d252
		1 : s = 8'b01100000; //1, d96
		2 : s = 8'b11011010; //2, d218
		3 : s = 8'b11110010; //3, d242
		4 : s = 8'b01100110; //4, d102
		5 : s = 8'b10110110; //5, d182
		6 : s = 8'b10111110; //6, d190
		7 : s = 8'b11100000; //7, d224
		8 : s = 8'b11111110; //8, d254
		9 : s = 8'b11100110; //9, d230
		default: s = 8'b00000000; //error
	endcase
endtask

// 각 count 값에 따른 7-segment 선언
always @ (negedge clk) begin
	if (rst == 1) begin
		// 리셋 초기화
		total_count = 0;
		count0 = 0;
		count1 = 0;
		count2 = 0;
		s0 <= 8'b11111100;
		s1 <= 8'b11111100;
		s2 <= 8'b11111100;
	end else begin
		// 자릿수 별 값 할당
		convert(count0, s0);
		convert(count1, s1);
		convert(count2, s2);
	end
end

// 최종 output인 seg에 값 할당
assign seg0 = s0;
assign seg1 = s1; 
assign seg2 = s2;

endmodule