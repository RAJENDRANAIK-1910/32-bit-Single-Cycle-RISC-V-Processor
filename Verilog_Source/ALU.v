`timescale 1ns / 1ps

module ALU(

    input  [31:0] A,
    input  [31:0] B,
    input  [3:0] ALU_Sel,

    output reg [31:0] ALU_Result,
    output Zero

);

//=====================================================
// ALU Operations
//=====================================================

always @(*)
begin

    case(ALU_Sel)

        // ADD
        4'b0000:
            ALU_Result = A + B;

        // SUB
        4'b0001:
            ALU_Result = A - B;

        // AND
        4'b0010:
            ALU_Result = A & B;

        // OR
        4'b0011:
            ALU_Result = A | B;

        // XOR
        4'b0100:
            ALU_Result = A ^ B;

        // SLL
        4'b0101:
            ALU_Result = A << B[4:0];

        // SRL
        4'b0110:
            ALU_Result = A >> B[4:0];

        // SRA
        4'b0111:
            ALU_Result = $signed(A) >>> B[4:0];

        // SLT
        4'b1000:
            ALU_Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;

        // SLTU
        4'b1001:
            ALU_Result = (A < B) ? 32'd1 : 32'd0;

        // PASS B (LUI)
        4'b1010:
            ALU_Result = B;

        default:
            ALU_Result = 32'd0;

    endcase

end

//=====================================================
// Zero Flag
//=====================================================

assign Zero = (ALU_Result == 32'd0);

endmodule
