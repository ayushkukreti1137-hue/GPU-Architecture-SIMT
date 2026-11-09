module gpu_alu #(
    parameter DATA_WIDTH = 16
) (
    input  logic [DATA_WIDTH-1:0] a,
    input  logic [DATA_WIDTH-1:0] b,
    input  logic [2:0]            alu_op,
    output logic [DATA_WIDTH-1:0] result,
    output logic                 zero
);

    localparam ALU_ADD = 3'b000;
    localparam ALU_SUB = 3'b001;
    localparam ALU_AND = 3'b010;
    localparam ALU_OR  = 3'b011;

    always_comb begin
        case (alu_op)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR:  result = a | b;

            default: result = '0;
        endcase
    end

    assign zero = (result == '0);

endmodule
