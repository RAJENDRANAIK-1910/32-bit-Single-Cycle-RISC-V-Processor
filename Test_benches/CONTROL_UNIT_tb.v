`timescale 1ns / 1ps

module CONTROL_UNIT_tb;

reg [6:0] opcode;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;
wire Jump;
wire [1:0] ALUOp;

CONTROL_UNIT uut(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp)

);

initial
begin

    opcode = 7'b0110011; #10; // R-Type
    opcode = 7'b0010011; #10; // I-Type
    opcode = 7'b0000011; #10; // LW
    opcode = 7'b0100011; #10; // SW
    opcode = 7'b1100011; #10; // Branch
    opcode = 7'b0110111; #10; // LUI
    opcode = 7'b0010111; #10; // AUIPC
    opcode = 7'b1101111; #10; // JAL
    opcode = 7'b1100111; #10; // JALR
    opcode = 7'b1111111; #10; // Invalid

    $finish;

end

initial
begin

$display("----------------------------------------------------------------------------");
$display("Opcode   RegWrite ALUSrc MemRead MemWrite MemtoReg Branch Jump ALUOp");
$display("----------------------------------------------------------------------------");

$monitor("%b      %b        %b       %b       %b        %b        %b      %b    %b",

opcode,
RegWrite,
ALUSrc,
MemRead,
MemWrite,
MemtoReg,
Branch,
Jump,
ALUOp);

end

endmodule
