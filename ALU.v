module ALU(
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] alucntrl,
    output reg [31:0] dout
);
    always @(*) begin
        case (alucntrl)
            4'b0010: dout = in1 + in2;  // ADD
            4'b0110: dout = in1 - in2;  // SUB
            4'b0000: dout = in1 & in2;  // AND
            4'b0001: dout = in1 | in2;  // OR
            4'b0011: dout = in1 ^ in2;  // XOR
            4'b1100: dout = ~(in1 | in2);  // NOR
            4'b0111: dout = (in1 < in2) ? 32'b1 : 32'b0; // SLT
            4'b1000: dout = in1 << in2[4:0];  // SLL (Logical Left Shift)
            4'b1001: dout = in1 >> in2[4:0];  // SRL (Logical Right Shift)
            4'b1010: dout = in1 >>> in2[4:0]; // SRA (Arithmetic Right Shift)
            default: dout = 32'bx; // Undefined case
        endcase
    end
endmodule
