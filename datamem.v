module data_memory (
    input clk,
    input MemRead, MemWrite,            
    input [31:0] raddr, waddr, wdata,  
    output reg [31:0] rdata           
);
    reg [31:0] mem [0:255]; 
    always @(posedge clk) begin
        if (MemWrite) 
            mem[waddr[7:0]] <= wdata;  
    end
    always @(*) begin
        if (MemRead) 
            rdata = mem[raddr[7:0]];   
        else 
            rdata = 32'bz;             
    end
endmodule

