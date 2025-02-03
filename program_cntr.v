module program_counter(input clk,rst,branch,jump,
                       input [31:0] nxt_inst,
                       output reg [31:0] instr);
    always @(posedge clk) begin
        if(rst)begin
            instr<=0;
        end
        else begin
            if(branch||jump)begin
                instr<=nxt_inst;
            end
            else begin
                instr<=instr+4;
            end
        end
    end
endmodule