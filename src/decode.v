module kamikaze_decode( clk_i,
			rst_i,
			is_compressed_instr_i,
			instr_i,
			instr_valid_i,
			pc_i,
			
			rf_rs1_o,
			rf_rs2_o,
			rf_rd_o,
			
			imm_o,
			valid_o
			);
	
	input clk_i;
	input rst_i;
	
	input is_compressed_instr_i;
	input [31:0]instr_i;
	input instr_valid_i;
	
	input [31:0]pc_i; /*虽然没什么卵用*/
	
	output reg [4:0]rf_rs1_o = 0;
	output reg [4:0]rf_rs2_o = 0;
	output reg [4:0]rf_rd_o  = 0; /* 寄存器 2R 1W地址口, 同步RAM?分布RAM? */
	
	output reg imm_o;
	output reg valid_o; /* 指令是否有效 */
	
	reg [31:0]pc = 0;
	
	reg is_compressed_instr = 0;
	
	localparam OPC_OP_IMM	= 5'b00100;
	localparam OPC_LUI 	= 5'b01101;
	localparam OPC_AUIPC 	= 5'b00101;
	localparam OPC_OP 	= 5'b01100;
	localparam OPC_JAL 	= 5'b11011;
	localparam OPC_JALR 	= 5'b11001;
	localparam OPC_BRANCH 	= 5'b11000;
	localparam OPC_LOAD 	= 5'b00000;
	localparam OPC_STORE 	= 5'b01000;
	localparam OPC_SYSTEM 	= 5'b11100; /* 非压缩指令最后两位是11 */
	
	wire [6:0]opcode = instr_i[6:0];
	
	wire [4:0]rs1_i = instr_i[19:15];
	wire [4:0]rs2_i = instr_i[24:20];
	wire [4:0]rd_i  = instr_i[11:7];
	
	always @(posedge clk_i or negedge rst_i)
	begin
		if(!rst_i)
		begin

		end
		else
		begin
			if(is_compressed_instr_i)
			begin //压缩指令处理
				rf_rs2_o <= instr_i[6:2];
			end
			else
			begin //非压缩指令处理
				
				rf_rs1_o <= rs1_i; /* 可能可以提前 */
				rf_rs2_o <= rs1_i;
				rf_rd_o  <= rs1_i; /* 寄存器解码 */
				
				valid_o <= 1;
				case (opcode[6:2])
					OPC_OP_IMM:
					begin
						
					end
					/*OPC_LUI:
					OPC_AUIPC:
					OPC_OP:
					OPC_JAL:
					OPC_JALR:
					OPC_BRANCH:
					OPC_LOAD:
					OPC_STORE:
					OPC_SYSTEM:*/
					default:
					begin
						valid_o <= 0;
					end
				endcase
				
			end
			
			pc <= pc_i;
			is_compressed_instr <= is_compressed_instr_i;
		end
	end
	
	always @*
	begin
	
	
	end
	
endmodule
