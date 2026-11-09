module gpu_pc #(
    parameter PC_WIDTH = 8
) (
    input  logic              clk,
    input  logic              rst,
    input  logic              pc_enable,
    input  logic              pc_load,
    input  logic [PC_WIDTH-1:0] pc_load_value,

    output logic [PC_WIDTH-1:0] pc
);

    always_ff @(posedge clk) begin

        if (rst) begin
            pc <= '0;
        end

        else if (pc_load) begin
            pc <= pc_load_value;
        end

        else if (pc_enable) begin
            pc <= pc + 1'b1;
        end

    end

endmodule
