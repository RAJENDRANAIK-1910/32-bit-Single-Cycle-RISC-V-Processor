`timescale 1ns / 1ps

module PC_tb;

reg clk;
reg reset;
reg [31:0] next_pc;

wire [31:0] pc;

//=====================================================
// Instantiate Program Counter
//=====================================================

PC uut (

    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)

);

//=====================================================
// Clock Generation (10 ns Period)
//=====================================================

always #5 clk = ~clk;

//=====================================================
// Test Sequence
//=====================================================

initial
begin

    clk = 1'b0;
    reset = 1'b1;
    next_pc = 32'h00000000;

    // Hold reset
    #20;

    reset = 1'b0;

    next_pc = 32'h00000004;
    #10;

    next_pc = 32'h00000008;
    #10;

    next_pc = 32'h0000000C;
    #10;

    next_pc = 32'h00000010;
    #10;

    next_pc = 32'h00000014;
    #10;

    next_pc = 32'h00000018;
    #10;

    $finish;

end

//=====================================================
// Monitor
//=====================================================

initial
begin

    $display("-----------------------------------------------");
    $display("Time\tReset\tNext_PC\t\tPC");
    $display("-----------------------------------------------");

    $monitor("%0t\t%b\t%h\t%h",

             $time,
             reset,
             next_pc,
             pc);

end

endmodule
