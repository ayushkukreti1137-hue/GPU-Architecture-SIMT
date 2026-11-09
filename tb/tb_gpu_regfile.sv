module tb_gpu_regfile;

    logic clk;
    logic rst;

    logic       we;
    logic [2:0] waddr;
    logic [15:0] wdata;

    logic [2:0] raddr1;
    logic [2:0] raddr2;

    logic [15:0] rdata1;
    logic [15:0] rdata2;

    gpu_regfile dut (
        .clk(clk),
        .rst(rst),

        .we(we),
        .waddr(waddr),
        .wdata(wdata),

        .raddr1(raddr1),
        .raddr2(raddr2),

        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        we = 0;
        waddr = 0;
        wdata = 0;

        raddr1 = 0;
        raddr2 = 0;

        #12;

        rst = 0;

        // Write R0 = 10
        we = 1;
        waddr = 3'd0;
        wdata = 16'd10;

        #10;

        // Write R1 = 20
        waddr = 3'd1;
        wdata = 16'd20;

        #10;

        we = 0;

        // Read R0 and R1
        raddr1 = 3'd0;
        raddr2 = 3'd1;

        #1;

        $display("R0 = %0d", rdata1);
        $display("R1 = %0d", rdata2);

        // Write R2 = 30
        we = 1;
        waddr = 3'd2;
        wdata = 16'd30;

        #10;

        we = 0;

        // Read R2
        raddr1 = 3'd2;

        #1;

        $display("R2 = %0d", rdata1);

        $finish;

    end

endmodule
