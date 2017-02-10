module kamikaze(clk_i,
		rst_i,
		im_addr_o,
		im_data_i);
	input clk_i;
	input rst_i;
	output [31:0] im_addr_o;
	input [31:0] im_data_i;
	kamikaze_fetch fetch(.clk_i(clk_i), .rst_i(rst_i),
				.im_addr_o(im_addr_o), .im_data_i(im_data_i));
endmodule
