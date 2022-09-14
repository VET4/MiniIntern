///////////////////////////////////////
// TSN Lab 미니인턴
// 본과제
// 작성: 노지훈
// 1차 완성일: 20220911
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module tb_7segment_test;

reg clk;
reg rst;
reg [31:0] digit;
wire [7:0] seg;

// 1Hz 클럭 생성
always
	#0.5 clk = ~clk;
reg [7:0] convert;
/*
always @ (clk) begin
	case (digit)
		32b'0 : convert <= "0";//0
		32b'1 : convert <= "1";//1
		32b'2 : convert <= "2";//2
		32b'3 : convert <= "3";//3
		32b'4 : convert <= "4";//4
		32b'5 : convert <= "5";//5
		32b'6 : convert <= "6";//6
		32b'7 : convert <= "7";//7
		32b'8 : convert <= "8";//8
		32b'9 : convert <= "9";
		default: convert = "0";
	endcase
end
*/
always @ (negedge clk) begin
	$display("val: [%d], time: [%d]", digit, $time);
end

initial begin
	$display("---Start---");
	// 초기값 생성
	convert = "0";
	clk = 0;
	rst = 0;
#20
	// 리셋 동작 확인
	rst = 1;
#20
	// 재동작 확인
	rst = 0;
#20
$finish;
end

// dut 파일 연결
dut_7segment_test DUT(
	.clk	(clk),
	.rst	(rst),
	.digit	(digit),
	.seg	(seg)
);

endmodule