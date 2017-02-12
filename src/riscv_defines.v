

`define OPC_OP_IMM 5'b00100
`define OPC_LUI 5'b01101
`define OPC_AUIPC 5'b00101
`define OPC_OP 5'b01100
`define OPC_JAL 5'b11011
`define OPC_JALR 5'b11001
`define OPC_BRANCH 5'b11000
`define OPC_LOAD 5'b00000
`define OPC_STORE 5'b01000
`define OPC_SYSTEM 5'b11100
`define OPC_MULDIV 5'b

`define BRA_EQ 3'b000
`define BRA_NEQ  3'b001
`define BRA_LT 3'b100
`define BRA_GE 3'b101
`define BRA_LTU 3'b110
`define BRA_GEU 3'b111

`define LDST_B 3'b000
`define LDST_H 3'b001
`define LDST_L 3'b010
`define	LDST_BU 3'b100
`define LDST_HU 3'b101

`define FUNC_ADD 3'b000
`define FUNC_SLT 3'b010
`define FUNC_SLTU 3'b011
`define FUNC_XOR 3'b100
`define FUNC_OR 3'b110
`define FUNC_AND 3'b111
`define FUNC_SL 3'b001
`define FUNC_SR 3'b101

`define FUNC_MUL 3'b000
`define FUNC_MULH 3'b001
`define FUNC_MULHSU 3'b010
`define FUNC_MULHU 3'b011

`define FUNC_DIV 3'b100
`define FUNC_DIVU 3'b101
`define FUNC_REM 3'b110
`define FUNC_REMU 3'b111

