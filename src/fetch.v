module kamikaze_fetch(clk_i,
		rst_i,
		im_addr_o,
		im_data_i,
		instr_o,
		instr_valid_o);
	input clk_i;
	input rst_i;
	output reg [31:0] im_addr_o;
	input [31:0] im_data_i;
	reg [31:0] pc;
	reg [2:0] pc_add;
	output reg [31:0] instr_o;
	reg [31:0] last_instr;
	reg is_compressed_instr;
	reg fetch_start;
	output reg instr_valid_o;
	
	wire [30:0] word_address = im_addr_o[31:2];
	reg [31:0] new_pc;
	
	localparam CPU_START = 32'h0;
	
	always @(posedge clk_i or negedge rst_i)
	begin
		if(!rst_i)
		begin
			im_addr_o <= CPU_START;
			pc <= CPU_START;/* PC比im_addr_o滞后1 CLK */
			fetch_start <= 0;
		end
		else
		begin
			if(fetch_start == 1'b0)
			begin
				fetch_start <= 1'b1;
				im_addr_o <= im_addr_o + 16'h4;
			end
			else
			begin
				//im_addr_o <= im_addr_o + pc_add;
				/*if(im_addr_o > new_pc)
					im_addr_o <= new_pc;*/
				im_addr_o <= new_pc + (is_compressed_instr? 4: 6);
				if(new_pc > pc)
					pc <= new_pc;
				last_instr <= im_data_i;
			end
		end
	end
	
	always @*
	begin
		if(pc[1:0] == 2'b00) /* |COMP|COMP| */
			if(last_instr[1:0] == 2'h3)
				is_compressed_instr <= 0;
			else
				is_compressed_instr <= 1;
		else
		begin
			if(last_instr[17:16] == 2'h3)
				is_compressed_instr <= 0;
			else
				is_compressed_instr <= 1; 
		end

		/*if(pc[1:0] == 2'b00)
			if(is_compressed_instr)
				instr_o <= im_data_i[15:0];
			else
				instr_o <= im_data_i[31:0];
		else
			if(is_compressed_instr)
				instr_o <= last_instr[31:16];
			else
				instr_o <= {im_data_i[15:0], last_instr[31:16]};*/
		

		pc_add = is_compressed_instr? 2: 4;
		new_pc <= pc + pc_add;	
	end
	
	
endmodule
