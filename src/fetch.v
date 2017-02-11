module kamikaze_fetch(clk_i,
		rst_i,
		im_addr_o,
		im_data_i,
		instr_o,
		instr_valid_o,
		is_compressed_instr_o);
	input clk_i;
	input rst_i;
	input [31:0] im_data_i; 
	output reg [31:0] instr_o;
	output [31:0] im_addr_o;
	output reg instr_valid_o;
	output is_compressed_instr_o;
	
	wire [30:0] word_address = im_addr_o[31:2];
	
	reg [31:0] pc;
	reg [31:0] pc_4;
	reg [2:0] pc_add;
	reg [2:0] pc_add_prev;
	
	
	reg [31:0] last_instr; /* 一级缓冲 */
	reg is_compressed_instr;
	reg fetch_start;	
	
	assign is_compressed_instr_o = is_compressed_instr;
	
	localparam CPU_START = 32'h0; /* 启动地址 */
	
	assign im_addr_o = pc_4[1]? (pc_4 + 2'b10): pc_4; /* 舍入 */
	assign stall_requiring = (pc_add_prev == 2) && (pc[1:0] == 2'b00); /* 16位对齐等待，防止冲数据 */
	
	
	always @(posedge clk_i or negedge rst_i)
	begin
		if(!rst_i)
		begin
			pc_4 <= CPU_START;
			pc <= CPU_START;/* PC 比 im_addr_o 滞后1 CLK */
			fetch_start <= 0;
			pc_add_prev <= 4;
			last_instr <= 32'h0;
		end
		else
		begin
			if(fetch_start == 1'b0)
			begin
				fetch_start <= 1'b1; /* 取 0 指令 */
				pc_4 <= pc_4 + 16'h4;
			end
			else
			begin
				pc_4 <= pc_4 + pc_add;
				pc <= pc + pc_add;
				
				if(!stall_requiring)
					last_instr <= im_data_i;
					
				pc_add_prev <= pc_add;
			end
		end
	end
	
	always @*
	begin
		if(pc[1:0] == 2'b00)
		begin
			if(stall_requiring)
			begin
				if(last_instr[1:0] != 2'b11) /* 对齐的压缩指令 */
				begin
					is_compressed_instr <= 1;
					instr_o = last_instr[15:0];
				end
				else
				begin
					is_compressed_instr <= 0;
					instr_o = last_instr[31:0];
				end
			end
			else
			begin
				if(im_data_i[1:0] != 2'b11) /* 对齐的压缩指令 */
				begin
					is_compressed_instr <= 1;
					instr_o = im_data_i[15:0];
				end
				else
				begin
					is_compressed_instr <= 0;
					instr_o = im_data_i[31:0];
				end
			end
		end
		else
		begin //pc[1:0] == 10
			if(last_instr[17:16] != 2'b11) /* 不对齐的压缩指令 */
			begin
				is_compressed_instr <= 1;
				instr_o = last_instr[31:16];
			end
			else			/* 不对齐的非压缩指令 */
			begin
				is_compressed_instr <= 0;
				instr_o = {im_data_i[15:0], last_instr[31:16]};
			end
		end
						
		pc_add = is_compressed_instr? 2: 4;
	end
	
endmodule
