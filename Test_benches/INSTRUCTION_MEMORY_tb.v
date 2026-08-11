`timescale 1ns / 1ps

module INSTRUCTION_MEMORY_tb;

reg [31:0] address;

wire [31:0] instruction;

INSTRUCTION_MEMORY uut(

    .address(address),
    .instruction(instruction)

);

initial
begin

    address = 32'h00000000; #10;
    address = 32'h00000004; #10;
    address = 32'h00000008; #10;
    address = 32'h0000000C; #10;
    address = 32'h00000010; #10;
    address = 32'h00000014; #10;
    address = 32'h00000018; #10;
    address = 32'h0000001C; #10;
    address = 32'h00000020; #10;

    $finish;

end

initial
begin

    $display("-----------------------------------------------------");
    $display("Time\tAddress\t\tInstruction");
    $display("-----------------------------------------------------");

    $monitor("%0t\t%h\t%h",

             $time,
             address,
             instruction);

end

endmodule
