module kamikaze_regfile(clk_i,
			
			waddr_i,
			wdata_i,
			we_i,
			
			raddr1_i,
			rdata1_o,
			
			raddr2_i,
			rdata2_o);
	input clk_i;
	
	/* 可能可以加倍时钟速度换取非双口的RAM实现，2R 1W */
	
	input [4:0]waddr_i;
	input [31:0]wdata_i;
	input we_i;
	
	input [4:0]raddr1_i;
	input [4:0]raddr2_i;
	
	output reg [31:0]rdata1_o;
	output reg [31:0]rdata2_o;
			
	reg [31:0]memory[0:31];
	
	always @(posedge clk_i)
	begin
		if(we_i)
			memory[waddr_i] <= wdata_i;
	end
	
	assign rdata_1_o = raddr1_i? memory[raddr1_i]: 0;
	assign rdata_2_o = raddr2_i? memory[raddr2_i]: 0;
endmodule
