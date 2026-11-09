module gpu_regfile #(
    parameter DATA_WIDTH = 16,
    parameter NUM_REGS   = 8
) (
    input  logic                   clk,
    input  logic                   rst,

    input  logic                   we,
    input  logic [$clog2(NUM_REGS)-1:0] waddr,
    input  logic [DATA_WIDTH-1:0]  wdata,

    input  logic [$clog2(NUM_REGS)-1:0] raddr1,
    input  logic [$clog2(NUM_REGS)-1:0] raddr2,

    output logic [DATA_WIDTH-1:0]  rdata1,

    output logic [DATA_WIDTH-1:0]  rdata2,
    output logic [DATA_WIDTH-1:0]  debug_r2
);

    logic [DATA_WIDTH-1:0] registers [0:NUM_REGS-1];

    integer i;

    always_ff @(posedge clk) begin

        if (rst) begin

            for (i = 0; i < NUM_REGS; i = i + 1) begin
                registers[i] <= '0;
            end

        end
        else if (we) begin

            registers[waddr] <= wdata;

        end

    end

    assign rdata1 = registers[raddr1];
    assign rdata2 = registers[raddr2];
    assign debug_r2 = registers[2];
endmodule
