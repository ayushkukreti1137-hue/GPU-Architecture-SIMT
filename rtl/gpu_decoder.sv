module gpu_decoder (
    input  logic [15:0] instr,

    output logic [3:0]  opcode,

    output logic [2:0]  rd,
    output logic [2:0]  rs1,
    output logic [2:0]  rs2,

    output logic [5:0]  imm6,
    output logic [8:0]  branch_offset,

    output logic [2:0]  alu_op,

    output logic        reg_write,
    output logic        mem_read,
    output logic        mem_write,
    output logic        branch,
    output logic        halt
);

    // Opcodes
    localparam OP_NOP  = 4'b0000;
    localparam OP_ADD  = 4'b0001;
    localparam OP_SUB  = 4'b0010;
    localparam OP_AND  = 4'b0011;
    localparam OP_OR   = 4'b0100;
    localparam OP_ADDI = 4'b0101;
    localparam OP_LD   = 4'b0110;
    localparam OP_ST   = 4'b0111;
    localparam OP_BEQZ = 4'b1000;
    localparam OP_HALT = 4'b1001;

    // ALU operations
    localparam ALU_ADD = 3'b000;
    localparam ALU_SUB = 3'b001;
    localparam ALU_AND = 3'b010;
    localparam ALU_OR  = 3'b011;

    always_comb begin

        // Extract instruction fields
        opcode       = instr[15:12];

        rd           = instr[11:9];
        rs1          = instr[8:6];
        rs2          = instr[5:3];

        imm6         = instr[5:0];
        branch_offset = instr[8:0];

        // Default control signals
        alu_op    = ALU_ADD;

        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        branch    = 1'b0;
        halt      = 1'b0;

        case (opcode)

            OP_NOP: begin
            end

            OP_ADD: begin
                alu_op    = ALU_ADD;
                reg_write = 1'b1;
            end

            OP_SUB: begin
                alu_op    = ALU_SUB;
                reg_write = 1'b1;
            end

            OP_AND: begin
                alu_op    = ALU_AND;
                reg_write = 1'b1;
            end

            OP_OR: begin
                alu_op    = ALU_OR;
                reg_write = 1'b1;
            end

            OP_ADDI: begin
                alu_op    = ALU_ADD;
                reg_write = 1'b1;
            end

            OP_LD: begin
                alu_op    = ALU_ADD;
                mem_read  = 1'b1;
                reg_write = 1'b1;
            end

            OP_ST: begin
                alu_op    = ALU_ADD;
                mem_write = 1'b1;
            end

            OP_BEQZ: begin
                branch = 1'b1;
            end

            OP_HALT: begin
                halt = 1'b1;
            end

            default: begin
            end

        endcase

    end

endmodule
