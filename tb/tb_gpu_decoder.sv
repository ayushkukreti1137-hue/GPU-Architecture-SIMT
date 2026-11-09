module tb_gpu_decoder;

    logic [15:0] instr;

    logic [3:0] opcode;

    logic [2:0] rd;
    logic [2:0] rs1;
    logic [2:0] rs2;

    logic [5:0] imm6;
    logic [8:0] branch_offset;

    logic [2:0] alu_op;

    logic reg_write;
    logic mem_read;
    logic mem_write;
    logic branch;
    logic halt;

    gpu_decoder dut (
        .instr(instr),

        .opcode(opcode),

        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),

        .imm6(imm6),
        .branch_offset(branch_offset),

        .alu_op(alu_op),

        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .halt(halt)
    );

    initial begin

        // ADD R2, R0, R1
        instr = 16'b0001_010_000_001_000;

        #1;

        $display("ADD instruction");
        $display("opcode=%b rd=%d rs1=%d rs2=%d reg_write=%b alu_op=%b",
                 opcode, rd, rs1, rs2, reg_write, alu_op);

        // ADDI R3, R1, 5
        instr = 16'b0101_011_001_000101;

        #1;

        $display("ADDI instruction");
        $display("opcode=%b rd=%d rs1=%d imm=%d reg_write=%b",
                 opcode, rd, rs1, imm6, reg_write);

        // HALT
        instr = 16'b1001_000_000_000_000;

        #1;

        $display("HALT instruction");
        $display("halt=%b", halt);

        $finish;

    end

endmodule
