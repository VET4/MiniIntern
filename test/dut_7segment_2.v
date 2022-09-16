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
	output [7:0] seg0
	//output [7:0] seg1,
	//output [7:0] seg2
);
	integer count0 = 0;
	reg [7:0] digit = 0;
	reg [7:0] s0;
	reg [7:0] s1 = "1";
	reg [7:0] s2 = "2";
	wire [15:0] s;

	assign s = {s2, s1};

task convert(
	input integer c_count,
	output reg [7:0] c_s
);
begin 
	case (c_count)
		0 : c_s <= 8'b11111100; //0, d252
		1 : c_s <= 8'b01100000; //1, d96
		2 : c_s <= 8'b11011010; //2, d218
		3 : c_s <= 8'b11110010; //3, d242
		4 : c_s <= 8'b01100110; //4, d102
		5 : c_s <= 8'b10110110; //5, d182
		6 : c_s <= 8'b10111110; //6, d190
		7 : c_s <= 8'b11100000; //7, d224
		8 : c_s <= 8'b11111110; //8, d254
		9 : c_s <= 8'b11100110; //9, d230
		default: c_s <= 8'b00000000; //error
	endcase
end
endtask

// 리셋 여부에 대한 내부 count 동작 선언
always @ (posedge clk) begin
	if (rst == 1) begin
		count0 = 0;
	end else begin
		if (count0 == 9) begin
			count0 = 0;
		end else begin
			count0 = count0 + 1;
		end
	end
	case (count0)
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
end

// count 값에 따른 7-segment 선언
always @ (negedge clk) begin
	// assign if에서 case로 변경
	convert(count0, s0);
	$display("[%s]sec test at [%d]", s, $time);
end

// 최종 output인 seg에 값 할당
assign seg0 = s0; 

endmodule