`timescale 1ns/1ps

module top_tb;

    reg clk;
    reg rst;

        top_RISC uut (
        .clk(clk),
        .rst(rst)
    );
initial begin
$dumpfile("c.vcd");
$dumpvars(0, top_tb);
end

    
    always #5 clk = ~clk;

        initial begin
        clk = 0;
        rst = 1;
        #20 rst = 0;
        #200 $finish;
    end

endmodule
