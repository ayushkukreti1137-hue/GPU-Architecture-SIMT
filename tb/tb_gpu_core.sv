module tb_gpu_core;

    logic clk;
    logic rst;

    logic halted;
    logic [7:0] pc_out;

    // Instantiate the GPU core
    gpu_core dut (
        .clk(clk),
        .rst(rst),
        .halted(halted),
        .pc_out(pc_out)
    );

    // Generate a clock with a 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Apply reset and observe execution
    initial begin
        rst = 1'b1;

        #12;
        rst = 1'b0;

        $display("Starting GPU program...");

        // Print PC and instruction on each rising edge
        while (!halted) begin
            @(posedge clk);
            #1;

            $display(
                "PC=%0d INSTR=%h HALTED=%b",
                pc_out,
                dut.instr,
                halted
            );
        end

        $display("");
        $display("Thread 0 results:");
        $display("R0 = %0d",
            dut.thread0.regfile.registers[0]);
        $display("R1 = %0d",
            dut.thread0.regfile.registers[1]);
        $display("R2 = %0d",
            dut.thread0.regfile.registers[2]);

        $display("");
        $display("Thread 1 results:");
        $display("R0 = %0d",
            dut.thread1.regfile.registers[0]);
        $display("R1 = %0d",
            dut.thread1.regfile.registers[1]);
        $display("R2 = %0d",
            dut.thread1.regfile.registers[2]);

        $display("");
        $display("GPU halted successfully.");

        $finish;
    end

    // Safety timeout to prevent an infinite simulation
    initial begin
        #500;
        $fatal(1, "Simulation timeout: GPU did not halt.");
    end

endmodule
