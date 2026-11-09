module gpu_imem #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16
) (
    input  logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] instr
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    logic [DATA_WIDTH-1:0] memory [0:DEPTH-1];

    initial begin
        $readmemh("sim/gpu_program.hex", memory, 0, 3);
    end

    always_comb begin
        instr = memory[addr];
    end

endmodule
