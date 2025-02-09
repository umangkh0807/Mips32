module mux_2(input [31:0] in0,
            input [31:0] in1,
            input cntrl,
            output reg [31:0] out);
    always @(*) begin
        if(cntrl) begin
            out=in1;
        end
        else begin
            out=in2;
        end
    end
endmodule