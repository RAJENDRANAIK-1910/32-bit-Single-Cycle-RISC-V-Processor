`timescale 1ns / 1ps

module DATA_MEMORY(

    input clk,

    input MemRead,
    input MemWrite,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data

);

//=====================================================
// Data Memory
//=====================================================

reg [31:0] memory [0:255];

integer i;

//=====================================================
// Initialize Memory
//=====================================================

initial
begin

    for(i = 0; i < 256; i = i + 1)
        memory[i] = 32'd0;

end

//=====================================================
// Write Memory
//=====================================================

always @(posedge clk)
begin

    if(MemWrite)
        memory[address[31:2]] <= write_data;

end

//=====================================================
// Read Memory
//=====================================================

always @(*)
begin

    if(MemRead)
        read_data = memory[address[31:2]];
    else
        read_data = 32'd0;

end

endmodule
