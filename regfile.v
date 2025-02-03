module regfile(
    input clk,read,
    input [4:0] radd1,radd2,wadd,
    input [31:0] din,
    output reg [31:0] out1,out2
);
    reg [31:0] data[31:0];
    always @(posedge clk)begin
        if(read)begin
            out1<=data[radd1];
            out2<=data[radd2];
        end
        else begin
            data[wadd]<=din;
        end
        
    end
endmodule