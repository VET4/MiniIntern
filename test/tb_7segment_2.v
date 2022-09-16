///////////////////////////////////////
// TSN Lab 미니인턴
// 추가 과제 2
// 작성: 노지훈
// 1차 완성일: 
///////////////////////////////////////

// 현실시간과 매칭을 위해 1초 단위로 설정
`timescale 1s/1ms

module tb_7segment_2;
reg clk;
reg rst;
wire [7:0] seg0;
//wire [7:0] seg1;
//wire [7:0] seg2;

// 1Hz 클럭 생성
always
	#0.5 clk = ~clk;
initial begin
	clk = 0;
	rst = 1;
#10
	// 초기값 생성
	
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
dut_7segment_2 DUT(
	.clk	(clk),
	.rst	(rst),
	.seg0	(seg0)
);
endmodule