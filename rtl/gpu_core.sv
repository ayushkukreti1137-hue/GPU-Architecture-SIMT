module gpu_core (
    input  logic       clk,
    input  logic       rst,
    output logic       halted,
    output logic [7:0] pc_out,
    output logic [15:0] thread0_debug_r2,
    output logic [15:0] thread1_debug_r2
);

    // Shared instruction and program counter
    logic [15:0] instr;
    logic [7:0]  pc;

    // Individual thread status
    logic thread0_halted;
    logic thread1_halted;

    // --------------------------------
    // 1. Program Counter
    // --------------------------------
    gpu_pc #(
        .PC_WIDTH(8)
    ) program_counter (
        .clk(clk),
        .rst(rst),
        .pc_enable(~halted),
        .pc_load(1'b0),
        .pc_load_value(8'b0),
        .pc(pc)
    );

    // --------------------------------
    // 2. Instruction Memory
    // --------------------------------
    gpu_imem #(
        .ADDR_WIDTH(8),
        .DATA_WIDTH(16)
    ) instruction_memory (
        .addr(pc),
        .instr(instr)
    );

    // --------------------------------
    // 3. Thread 0
    // --------------------------------
    gpu_thread #(
        .DATA_WIDTH(16)
    ) thread0 (
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .halted(thread0_halted),
        .debug_r2(thread0_debug_r2)
    );

    // --------------------------------
    // 4. Thread 1
    // --------------------------------
    gpu_thread #(
        .DATA_WIDTH(16)
    ) thread1 (
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .halted(thread1_halted),
        .debug_r2(thread1_debug_r2)
    );

    // Both threads receive the same instruction.
    // They should reach HALT together in this version.
    assign halted = thread0_halted & thread1_halted;

    // Expose PC for debugging.
    assign pc_out = pc;

endmodule
