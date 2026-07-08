module tb_single_cycle_RISCV_top (
);

    reg clk=1'b0, rst_n;
    single_cycle_RISCV_top dut(
        .clk(clk),
        .rst_n(rst_n)
    );
    initial
    begin
        $dumpfile("single_cyc.vcd");
        $dumpvars(0);
    end
    always
    begin
        clk=~clk;
        #50;
    end

    initial
    begin
        rst_n=1'b0;
        #150;
        rst_n =1'b1;
        
        #1500;
        $finish;
    end
    
endmodule