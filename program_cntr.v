module program_counter(input clk,rst,
                       input [31:0] nxt_inst,
                       output reg [31:0] instr);
    always @(posedge clk) begin
        if(rst)begin
            instr<=0;
        end
        else begin
            instr<=nxt_instr;
        end
    end
endmodule
