module tb_gpu_thread;

    logic        clk;
    logic        rst;

    logic [15:0] instr;

    logic        halted;


    gpu_thread dut (
        .clk(clk),
        .rst(rst),

        .instr(instr),

        .halted(halted)
    );


    always #5 clk = ~clk;


    initial begin

        clk = 0;
        rst = 1;

        instr = 16'h0000;

        // Reset
        #12;

        rst = 0;


        // ------------------------------------------------
        // ADDI R0, R0, 10
        // opcode = 0101
        // rd     = 000
        // rs1    = 000
        // imm    = 001010
        // ------------------------------------------------

        instr = 16'b0101_000_000_001010;

        #10;


        // ------------------------------------------------
        // ADDI R1, R0, 20
        // R1 = R0 + 20 = 30
        // ------------------------------------------------

        instr = 16'b0101_001_000_010100;

        #10;


        // ------------------------------------------------
        // ADD R2, R0, R1
        // R2 = 10 + 30 = 40
        // ------------------------------------------------

        instr = 16'b0001_010_000_001_000;

        #10;


        // ------------------------------------------------
        // HALT
        // ------------------------------------------------

        instr = 16'b1001_000_000_000_000;

        #1;

        $display("R0 = %0d", dut.regfile.registers[0]);
	$display("R1 = %0d", dut.regfile.registers[1]);
	$display("R2 = %0d", dut.regfile.registers[2]);

        $display("HALTED = %b", halted);

        $finish;

    end

endmodule
