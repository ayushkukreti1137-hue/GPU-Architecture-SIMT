module tb_gpu_pc;

    logic clk;
    logic rst;

    logic pc_enable;
    logic pc_load;
    logic [7:0] pc_load_value;

    logic [7:0] pc;


    gpu_pc dut (
        .clk(clk),
        .rst(rst),

        .pc_enable(pc_enable),
        .pc_load(pc_load),
        .pc_load_value(pc_load_value),

        .pc(pc)
    );


    always #5 clk = ~clk;


    initial begin

        clk = 0;
        rst = 1;

        pc_enable = 0;
        pc_load = 0;
        pc_load_value = 0;


        // Reset
        #12;

        rst = 0;

        // Count
        pc_enable = 1;

        #10;
        $display("PC = %0d", pc);

        #10;
        $display("PC = %0d", pc);

        #10;
        $display("PC = %0d", pc);


        // Test jump/load
        pc_enable = 0;
        pc_load = 1;
        pc_load_value = 8'd10;

        #10;

        $display("PC after load = %0d", pc);


        $finish;

    end

endmodule
