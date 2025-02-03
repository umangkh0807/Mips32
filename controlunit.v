module ControlUnit (
    input [5:0] opcode, funct,
    output reg regWrite, ALUSrc, memRead, memWrite, branch, jump,
    output reg [3:0] ALUControl
);
    always @(*) begin
        case (opcode)
            6'b000000: begin // R-Type
                regWrite = 1; ALUSrc = 0; memRead = 0; memWrite = 0; branch = 0; jump = 0;
                case (funct)
                    6'b100000: ALUControl = 4'b0000; // ADD
                    6'b100010: ALUControl = 4'b0001; // SUB
                    6'b100100: ALUControl = 4'b0010; // AND
                    6'b100101: ALUControl = 4'b0011; // OR
                    6'b101010: ALUControl = 4'b0100; // SLT
                    default: ALUControl = 4'b1111; // Invalid
                endcase
            end
            6'b001000: begin // ADDI
                regWrite = 1; ALUSrc = 1; ALUControl = 4'b0000;
            end
            6'b001100: begin // ANDI
                regWrite = 1; ALUSrc = 1; ALUControl = 4'b0010;
            end
            6'b100011: begin // LW
                regWrite = 1; ALUSrc = 1; memRead = 1; memWrite = 0;
            end
            6'b101011: begin // SW
                regWrite = 0; ALUSrc = 1; memRead = 0; memWrite = 1;
            end
            6'b000100: begin // BEQ
                regWrite = 0; branch = 1; ALUControl = 4'b0001;
            end
            6'b000101: begin // BNE
                regWrite = 0; branch = 1; ALUControl = 4'b0001;
            end
            6'b000010: begin // JUMP
                regWrite = 0; jump = 1;
            end
            default: begin
                regWrite = 0; ALUSrc = 0; memRead = 0; memWrite = 0; branch = 0; jump = 0;
            end
        endcase
    end
endmodule
