module top(clk_i, rst_i, io_o, trap);
	input clk_i;
	input rst_i;
	output reg [7:0] io_o;
	output trap;
	
	localparam MEM_SIZE = 4096;
	reg [31:0] memory [0:MEM_SIZE-1];
	initial $readmemh("../firmware/firmware.hex", memory);
	
	wire [31:0] im_addr;
	reg [31:0] im_data;
	
	kamikaze cpu(.clk_i(clk_i),
			.rst_i(rst_i),
			.im_addr_o(im_addr),
			.im_data_i(im_data));
	
	always @(posedge clk_i)
	begin
		if(rst_i)
			im_data <= memory[im_addr[31:2]];
		else
			im_data <= 32'h0;
	end
	
endmodule
