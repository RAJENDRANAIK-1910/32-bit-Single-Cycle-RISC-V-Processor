`timescale 1ns / 1ps

module INSTRUCTION_MEMORY(

    input  [31:0] address,
    output [31:0] instruction

);

reg [31:0] memory [0:255];

integer i;

initial
begin

    // =====================================================
    // RV32I Demo Program
    // =====================================================

    // addi x1, x0, 5
    memory[0] = 32'h00500093;

    // addi x2, x0, 10
    memory[1] = 32'h00A00113;

    // add x3, x1, x2
    memory[2] = 32'h002081B3;

    // sub x4, x2, x1
    memory[3] = 32'h40110233;

    // sw x3, 0(x0)
    memory[4] = 32'h00302023;

    // lw x5, 0(x0)
    memory[5] = 32'h00002283;

    // beq x5, x3, +8
    memory[6] = 32'h00328463;

    // addi x6, x0, 100
    memory[7] = 32'h06400313;

    // nop
    memory[8] = 32'h00000013;

    // Fill remaining memory with NOPs

    for(i = 9; i < 256; i = i + 1)
        memory[i] = 32'h00000013;

end

assign instruction = memory[address[31:2]];

endmodule
