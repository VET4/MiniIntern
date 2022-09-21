///////////////////////////////////////
// TSN Lab 미니인턴
// 추가 과제 2
// 작성: 노지훈
// 1차 완성일: 20220917
// 2차 완성일: 20220918
// 3차 완성일: 20220921
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module dut_7segment_3(
	input clk,
	input rst,
	// 3자릿수 Segment 인풋
	output [7:0] seg0,
	output [7:0] seg1,
	output [7:0] seg2
);
	// 000 ~ 599까지 세는 카운터용 변수 선언
	integer total_count = 0;
	// 자릿수 별 값 할당을 위한 변수 선언
	integer count0 = 0;
	integer count1 = 0;
	integer count2 = 0;
	// 분과 초 표기를 위한용
	reg [7:0] digit0 = "0";
	reg [7:0] digit1 = "0";
	reg [7:0] digit2 = "0";
	reg [7:0] s0;
	reg [7:0] s1;
	reg [7:0] s2;

// 분과 초 표기용 반복작업 task로 정의
task digit_converter(
	input [31:0] count,
	output [7:0] digit
);
	case (count)
		0	: digit = "0";
		1	: digit = "1";
		2	: digit = "2";
		3	: digit = "3";
		4	: digit = "4";
		5	: digit = "5";
		6	: digit = "6";
		7	: digit = "7";
		8	: digit = "8";
		9	: digit = "9";
		default : digit = "0";
	endcase
endtask

// 리셋 여부에 대한 내부 count 동작 선언
always @ (posedge clk) begin
	// 리셋 초기화 조건
	if (rst == 1) begin
		total_count = 0;
	end else begin
		// 599 넘을 경우 초기화 조건
		if (total_count == 599) begin
			total_count = 0;
			count0 = 0;
			count1 = 0;
			count2 = 0;
		// 전체 카운터에서 각 자릿수로 할당하기 위해 숫자 분리
		end else begin
			total_count = total_count + 1;
			count2 = total_count / 60;
			count1 = (total_count % 60) / 10;
			count0 = (total_count % 60) % 10;
		end
	end

	// display를 위해 task 사용
	digit_converter(count2, digit2);
	digit_converter(count1, digit1);
	digit_converter(count0, digit0);

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

// count 값에 따른 7-segment 선언
always @ (negedge clk) begin
	// 자릿수 별 값 할당
	if (rst == 1) begin
		total_count = 0;
		count0 = 0;
		count1 = 0;
		count2 = 0;
		s0 <= 8'b11111100;
		s1 <= 8'b11111100;
		s2 <= 8'b11111100;
	end else begin
		convert(count0, s0);
		convert(count1, s1);
		convert(count2, s2);
	end
	// 분과 초 표기, 비바도에서 한글 인식 안돼서 영어로 표기
	$display("count: [%d] : [%s]min [%s]sec : time: [%d]", total_count, digit2, {digit1,digit0}, $time);
end
// 최종 output인 seg에 값 할당
assign seg0 = s0;
assign seg1 = s1; 
assign seg2 = s2; 
endmodule