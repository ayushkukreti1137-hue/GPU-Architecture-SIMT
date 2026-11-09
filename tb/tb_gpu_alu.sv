module tb_gpu_alu;

    logic [15:0] a;
    logic [15:0] b;
    logic [2:0]  alu_op;

    logic [15:0] result;
    logic        zero;

    gpu_alu dut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    initial begin

        // ADD
        a = 16'd10;
        b = 16'd20;
        alu_op = 3'b000;

        #1;

        $display("ADD: %0d + %0d = %0d", a, b, result);

        // SUB
        a = 16'd20;
        b = 16'd10;
        alu_op = 3'b001;

        #1;

        $display("SUB: %0d - %0d = %0d", a, b, result);

        // AND
        a = 16'h00FF;
        b = 16'h0F0F;
        alu_op = 3'b010;

        #1;

        $display("AND: %h & %h = %h", a, b, result);

        // OR
        a = 16'h00FF;
        b = 16'h0F00;
        alu_op = 3'b011;

        #1;

        $display("OR : %h | %h = %h", a, b, result);

        // Zero test
        a = 16'd10;
        b = 16'd10;
        alu_op = 3'b001;

        #1;

        $display("ZERO TEST: result=%0d zero=%b",
                 result, zero);

        $finish;

    end

endmodule
