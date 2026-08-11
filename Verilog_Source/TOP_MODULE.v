`timescale 1ns / 1ps

module TOP_MODULE(

    input clk,
    input reset

);

//=====================================================
// Program Counter
//=====================================================

wire [31:0] pc;
wire [31:0] next_pc;

//=====================================================
// Instruction Memory
//=====================================================

wire [31:0] instruction;

//=====================================================
// Control Signals
//=====================================================

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;
wire Jump;
wire [1:0] ALUOp;

//=====================================================
// Register File
//=====================================================

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_back_data;

//=====================================================
// Immediate Generator
//=====================================================

wire [31:0] immediate;

//=====================================================
// ALU Control
//=====================================================

wire [3:0] ALU_Sel;

//=====================================================
// ALU
//=====================================================

wire [31:0] alu_input2;
wire [31:0] alu_result;
wire Zero;

//=====================================================
// Data Memory
//=====================================================

wire [31:0] memory_data;

//=====================================================
// Program Counter
//=====================================================

PC PC0(

    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)

);

//=====================================================
// Instruction Memory
//=====================================================

INSTRUCTION_MEMORY IM0(

    .address(pc),
    .instruction(instruction)

);

//=====================================================
// Control Unit
//=====================================================

CONTROL_UNIT CU0(

    .opcode(instruction[6:0]),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp)

);

//=====================================================
// Register File
//=====================================================

REGISTER_FILE RF0(

    .clk(clk),
    .RegWrite(RegWrite),

    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),

    .write_data(write_back_data),

    .read_data1(read_data1),
    .read_data2(read_data2)

);

//=====================================================
// Immediate Generator
//=====================================================

IMMEDIATE_GENERATOR IG0(

    .instruction(instruction),
    .immediate(immediate)

);

//=====================================================
// ALU Control
//=====================================================

ALU_CONTROL AC0(

    .ALUOp(ALUOp),

    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),

    .ALU_Sel(ALU_Sel)

);

//=====================================================
// ALU Input MUX
//=====================================================

assign alu_input2 = (ALUSrc) ? immediate : read_data2;

//=====================================================
// ALU
//=====================================================

ALU ALU0(

    .A(read_data1),
    .B(alu_input2),

    .ALU_Sel(ALU_Sel),

    .ALU_Result(alu_result),
    .Zero(Zero)

);

//=====================================================
// Data Memory
//=====================================================

DATA_MEMORY DM0(

    .clk(clk),

    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .address(alu_result),
    .write_data(read_data2),

    .read_data(memory_data)

);

//=====================================================
// Write Back MUX
//=====================================================

assign write_back_data =
        (MemtoReg) ? memory_data :
                     alu_result;

//=====================================================
// Next PC Logic
//=====================================================

assign next_pc =
        (Jump) ? (pc + immediate) :
        ((Branch && Zero) ? (pc + immediate) :
                            (pc + 32'd4));

//=====================================================
// End Module
//=====================================================

endmodule
