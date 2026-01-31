`timescale 1ns/1ps
module FIFO_Depth_tb;
reg clk;
reg rst;
reg wr_enb;
reg rd_enb;
reg cs;
reg [data_depth-1:0] data_in;
wire [data_depth-1:0] data_out;
wire f;
wire e;

parameter data_depth = 32;
parameter fifo_depth = 8;
integer i;

FIFO_Depth 
    #(.data_depth(data_depth), .fifo_depth(fifo_depth)) 
        dut (
            .clk(clk),
            .rst(rst),
            .wr_enb(wr_enb),
            .rd_enb(rd_enb),
            .cs(cs),
            .data_in(data_in),
            .data_out(data_out),
            .f(f),
            .e(e)
);
initial begin
    $dumpfile("c.vcd");
    $dumpvars(0, FIFO_Depth_tb);
end
always #5 clk = ~clk;

task write_data(input [data_depth-1:0] data);
    begin
        @(posedge clk);
        cs = 1; wr_enb = 1;
        data_in = data;
        $display($time, "write_data data = %0d", data);
        @(posedge clk);
        cs = 1; wr_enb = 0;
    end
endtask

task read_data();
    begin
        @(posedge clk);
        cs = 1; rd_enb = 1;
        @(posedge clk);
        $display($time, "read_data data_out = %0d", data_out);
        cs = 1; rd_enb = 0;
    end
endtask

initial begin
        rst = 1; clk = 0; rd_enb =0; wr_enb = 0; cs = 0;
        @(posedge clk);
        rst = 0;
        $display($time, "\n SCENERIO 1");
        write_data(1);
        write_data(10);
        write_data(100);

        read_data();
        read_data();
        read_data();
        
        $display($time, "\n SCENERIO 2");
        for(i=0; i<fifo_depth; i++)
            begin
                write_data(2**i);
                read_data();
            end
        for(i=0; i<fifo_depth; i++)
            begin
                write_data(3**i);
            end
        for(i=0; i<fifo_depth; i++)
            begin
                read_data();
            end
    #100;
            $finish;
end
endmodule