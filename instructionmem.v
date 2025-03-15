module instruction_memory (
    input [31:0] address,  
    output reg [31:0] instruction 
);
    reg [7:0] memory [0:1023]; 
    initial begin
        $readmemh("instructions.hex", memory); 
    end
    always@(*) begin
        instruction = {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]};
    end
    integer i=0;
    initial begin
        $display("Instruction at 0x00: %h", {memory[i], memory[i+1], memory[i+2], memory[i+3]});
        i=i+4;
        $display("Instruction at 0x04: %h", {memory[i], memory[i+1], memory[i+2], memory[i+3]});
        i=i+4;
        $display("Instruction at 0x08: %h", {memory[i], memory[i+1], memory[i+2], memory[i+3]});
        i=i+4;
        $display("Instruction at 0x08: %h", {memory[i], memory[i+1], memory[i+2], memory[i+3]});
    end
endmodule