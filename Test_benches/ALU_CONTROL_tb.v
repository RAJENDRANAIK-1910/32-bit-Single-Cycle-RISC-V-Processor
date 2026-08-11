`timescale 1ns / 1ps

module ALU_CONTROL_tb;

reg [1:0] ALUOp;
reg [2:0] funct3;
reg [6:0] funct7;

wire [3:0] ALU_Sel;

//=====================================================
// Instantiate
//=====================================================

ALU_CONTROL uut(

    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),

    .ALU_Sel(ALU_Sel)

);

//=====================================================
// Test Sequence
//=====================================================

initial
begin

    // LW / SW
    ALUOp = 2'b00;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // Branch
    ALUOp = 2'b01;
    #10;

    // ADD
    ALUOp = 2'b10;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // SUB
    funct7 = 7'b0100000;
    #10;

    // SLL
    funct3 = 3'b001;
    funct7 = 7'b0000000;
    #10;

    // SLT
    funct3 = 3'b010;
    #10;

    // SLTU
    funct3 = 3'b011;
    #10;

    // XOR
    funct3 = 3'b100;
    #10;

    // SRL
    funct3 = 3'b101;
    funct7 = 7'b0000000;
    #10;

    // SRA
    funct7 = 7'b0100000;
    #10;

    // OR
    funct3 = 3'b110;
    funct7 = 7'b0000000;
    #10;

    // AND
    funct3 = 3'b111;
    #10;

    // LUI / AUIPC
    ALUOp = 2'b11;
    #10;

    $finish;

end

//=====================================================
// Monitor
//=====================================================

initial
begin

$display("-------------------------------------------------------------");
$display("ALUOp funct3 funct7      ALU_Sel");
$display("-------------------------------------------------------------");

$monitor("%b     %b     %b   %b",

         ALUOp,
         funct3,
         funct7,
         ALU_Sel);

end

endmodule
