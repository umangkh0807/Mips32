module mips_datapath(
    input clk,
    input reset
);
    reg [31:0] pc;
    wire [31:0] instr;
    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] imm;
    wire [25:0] address;
    wire [31:0] reg_data1, reg_data2, alu_result, mem_data;
    wire [31:0] imm_ext, write_data;
    wire [3:0] alu_ctrl;
    wire [1:0] alu_op;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, jump, zero;

    // Fetch instruction
    reg [31:0] instr_mem[0:255];
    assign instr = instr_mem[pc[9:2]];

    // Decode
    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign funct = instr[5:0];
    assign imm = instr[15:0];
    assign address = instr[25:0];

    // Control Unit
    control CONTROL(opcode, reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, jump, alu_op);
    
    // Register File
    reg_file RF(clk, rs, rt, write_reg, write_data, reg_write, reg_data1, reg_data2);

    // Sign Extend
    assign imm_ext = {{16{imm[15]}}, imm};

    // ALU Control
    alu_control ALUCTRL(alu_op, funct, alu_ctrl);

    // ALU Input Mux
    wire [31:0] alu_in2 = alu_src ? imm_ext : reg_data2;

    // ALU
    alu ALU(reg_data1, alu_in2, alu_ctrl, alu_result, zero);

    // Data Memory
    reg [31:0] data_mem[0:255];
    assign mem_data = mem_read ? data_mem[alu_result[9:2]] : 32'b0;

    always @(posedge clk) begin
        if (mem_write)
            data_mem[alu_result[9:2]] <= reg_data2;
    end

    // Write back Mux
    assign write_data = mem_to_reg ? mem_data : alu_result;

    // Write Register Mux
    wire [4:0] write_reg = reg_dst ? rd : rt;

    // PC Update
    wire [31:0] pc_next = jump ? {pc[31:28], address, 2'b00} :
                         (branch && zero) ? pc + 4 + (imm_ext << 2) :
                         pc + 4;

    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 0;
        else pc <= pc_next;
    end
endmodule
