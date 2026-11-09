module tb_gpu_imem;

    logic [7:0]  addr;
    logic [15:0] instr;

    gpu_imem dut (
        .addr(addr),
        .instr(instr)
    );

    initial begin

        addr = 8'd0;
        #1;
        $display("PC=%0d INSTR=%h", addr, instr);

        addr = 8'd1;
        #1;
        $display("PC=%0d INSTR=%h", addr, instr);

        addr = 8'd2;
        #1;
        $display("PC=%0d INSTR=%h", addr, instr);

        addr = 8'd3;
        #1;
        $display("PC=%0d INSTR=%h", addr, instr);

        $finish;

    end

endmodule
