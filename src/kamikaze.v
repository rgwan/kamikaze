module kamikaze(clk_i,
		rst_i,
		im_addr_o,
		im_data_i);
	input clk_i;
	input rst_i;
	output [31:0] im_addr_o;
	input [31:0] im_data_i;
	
	wire [31:0] instruction;
	wire is_compressed_instr;
	wire instr_valid;
	
	wire [31:0] pc_fetch;
	
	kamikaze_fetch fetch(	.clk_i(clk_i), .rst_i(rst_i),
				.im_addr_o(im_addr_o), .im_data_i(im_data_i),
				.instr_o(instruction), .is_compressed_instr_o(is_compressed_instr),
				.instr_valid_o(instr_valid), .pc_o(pc_fetch)
				);
				
	kamikaze_decode decode( .clk_i(clk_i), .rst_i(rst_i),
				.instr_i(instruction), .is_compressed_instr_i(is_compressed_instr),
				.pc_i(pc_fetch), .instr_valid_i(instr_valid)
				);
				
endmodule
