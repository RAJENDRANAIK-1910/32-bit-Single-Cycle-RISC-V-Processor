`timescale 1ns / 1ps

module ALU_tb;

reg [31:0] A;
reg [31:0] B;
reg [3:0] ALU_Sel;

wire [31:0] ALU_Result;
wire Zero;

//=====================================================
// Instantiate ALU
//=====================================================

ALU uut(

    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),

    .ALU_Result(ALU_Result),
    .Zero(Zero)

);

//=====================================================
// Test Sequence
//=====================================================

initial
begin

    // ADD
    A = 20;
    B = 10;
    ALU_Sel = 4'b0000;
    #10;

    // SUB
    ALU_Sel = 4'b0001;
    #10;

    // AND
    ALU_Sel = 4'b0010;
    #10;

    // OR
    ALU_Sel = 4'b0011;
    #10;

    // XOR
    ALU_Sel = 4'b0100;
    #10;

    // SLL
    A = 8;
    B = 2;
    ALU_Sel = 4'b0101;
    #10;

    // SRL
    A = 32;
    B = 2;
    ALU_Sel = 4'b0110;
    #10;

    // SRA
    A = -32;
    B = 2;
    ALU_Sel = 4'b0111;
    #10;

    // SLT
    A = 5;
    B = 10;
    ALU_Sel = 4'b1000;
    #10;

    // SLTU
    A = 5;
    B = 10;
    ALU_Sel = 4'b1001;
    #10;

    // PASS B
    A = 123;
    B = 456;
    ALU_Sel = 4'b1010;
    #10;

    // ZERO FLAG
    A = 50;
    B = 50;
    ALU_Sel = 4'b0001;
    #10;

    $finish;

end

//=====================================================
// Monitor
//=====================================================

initial
begin

$display("-----------------------------------------------------------------------");
$display("A\tB\tALU_Sel\tALU_Result\tZero");
$display("-----------------------------------------------------------------------");

$monitor("%d\t%d\t%h\t%d\t%b",

         A,
         B,
         ALU_Sel,
         ALU_Result,
         Zero);

end

endmodule
