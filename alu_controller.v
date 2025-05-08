module ALUControl (
    input  [1:0] ALUOp,         // From Main Control Unit
    input  [5:0] funct,         // From instruction[5:0]
    output reg [3:0] ALUCtrl    // To ALU
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUCtrl = 4'b0010; // lw, sw (add)
            2'b01: ALUCtrl = 4'b0110; // beq (sub)
            2'b10: begin              // R-type
                case (funct)
                    6'b100000: ALUCtrl = 4'b0010; // add
                    6'b100010: ALUCtrl = 4'b0110; // sub
                    6'b100100: ALUCtrl = 4'b0000; // and
                    6'b100101: ALUCtrl = 4'b0001; // or
                    6'b101010: ALUCtrl = 4'b0111; // slt
                    6'b000000: ALUCtrl = 4'b1000; // sll
                    6'b000010: ALUCtrl = 4'b1001; // srl
                    default:   ALUCtrl = 4'b1111; // invalid
                endcase
            end
            default: ALUCtrl = 4'b1111; // invalid
        endcase
    end

endmodule