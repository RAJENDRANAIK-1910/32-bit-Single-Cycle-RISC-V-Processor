`timescale 1ns / 1ps

module ALU_CONTROL(

    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg [3:0] ALU_Sel

);

//=====================================================
// ALU Control
//=====================================================

always @(*)
begin

    case(ALUOp)

    //-------------------------------------------------
    // LW / SW
    //-------------------------------------------------

    2'b00:
        ALU_Sel = 4'b0000;      // ADD

    //-------------------------------------------------
    // Branch
    //-------------------------------------------------

    2'b01:
        ALU_Sel = 4'b0001;      // SUB

    //-------------------------------------------------
    // R-Type / I-Type
    //-------------------------------------------------

    2'b10:
    begin

        case(funct3)

        // ADD / SUB / ADDI
        3'b000:
        begin
            if(funct7 == 7'b0100000)
                ALU_Sel = 4'b0001;      // SUB
            else
                ALU_Sel = 4'b0000;      // ADD
        end

        // SLL
        3'b001:
            ALU_Sel = 4'b0101;

        // SLT
        3'b010:
            ALU_Sel = 4'b1000;

        // SLTU
        3'b011:
            ALU_Sel = 4'b1001;

        // XOR
        3'b100:
            ALU_Sel = 4'b0100;

        // SRL / SRA
        3'b101:
        begin
            if(funct7 == 7'b0100000)
                ALU_Sel = 4'b0111;      // SRA
            else
                ALU_Sel = 4'b0110;      // SRL
        end

        // OR
        3'b110:
            ALU_Sel = 4'b0011;

        // AND
        3'b111:
            ALU_Sel = 4'b0010;

        default:
            ALU_Sel = 4'b0000;

        endcase

    end

    //-------------------------------------------------
    // LUI / AUIPC
    //-------------------------------------------------

    2'b11:
        ALU_Sel = 4'b1010;      // PASS B

    default:
        ALU_Sel = 4'b0000;

    endcase

end

endmodule
