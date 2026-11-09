module gpu_thread #(
    parameter DATA_WIDTH = 16
) (
    input  logic        clk,
    input  logic        rst,

    input  logic [15:0] instr,

    output logic        halted,
    output logic [DATA_WIDTH-1:0] debug_r2
);
    // ------------------------------------------------------------
    // Decoder signals
    // ------------------------------------------------------------

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


    // ------------------------------------------------------------
    // Register file signals
    // ------------------------------------------------------------

    logic [DATA_WIDTH-1:0] reg_data1;
    logic [DATA_WIDTH-1:0] reg_data2;

    logic [DATA_WIDTH-1:0] write_data;

    // Debug output: expose register R2 outside this thread.
    
    // ------------------------------------------------------------
    // ALU signals
    // ------------------------------------------------------------

    logic [DATA_WIDTH-1:0] alu_b;
    logic [DATA_WIDTH-1:0] alu_result;
    logic                  alu_zero;


    // ------------------------------------------------------------
    // Decoder
    // ------------------------------------------------------------

    gpu_decoder decoder (
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


    // ------------------------------------------------------------
    // Register file
    // ------------------------------------------------------------

    gpu_regfile #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUM_REGS(8)
    ) regfile (
        .clk(clk),
        .rst(rst),

        .we(reg_write),
        .waddr(rd),
        .wdata(write_data),

        .raddr1(rs1),
        .raddr2(rs2),

        .rdata1(reg_data1),
        .rdata2(reg_data2),
        .debug_r2(debug_r2)
    );


    // ------------------------------------------------------------
    // ALU input selection
    // ------------------------------------------------------------

    always_comb begin

        if (opcode == 4'b0101) begin
            // ADDI
            alu_b = {{(DATA_WIDTH-6){1'b0}}, imm6};
        end
        else begin
            // R-type instruction
            alu_b = reg_data2;
        end

    end


    // ------------------------------------------------------------
    // ALU
    // ------------------------------------------------------------

    gpu_alu #(
        .DATA_WIDTH(DATA_WIDTH)
    ) alu (
        .a(reg_data1),
        .b(alu_b),
        .alu_op(alu_op),

        .result(alu_result),
        .zero(alu_zero)
    );


    // ------------------------------------------------------------
    // Writeback
    // ------------------------------------------------------------

    assign write_data = alu_result;


    // ------------------------------------------------------------
    // Halt
    // ------------------------------------------------------------

    assign halted = halt;
   
endmodule
