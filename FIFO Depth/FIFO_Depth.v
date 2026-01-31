module FIFO_Depth(
    input wire clk,
    input wire rst,
    input wire wr_enb,
    input wire rd_enb,
    input wire cs, //chip select
    input wire [data_depth-1:0]data_in,
    output reg [data_depth-1:0]data_out,
    output wire f,
    output wire e
);
parameter data_depth = 32;
parameter fifo_depth = 8;
localparam fifo_depth_log = $clog2(fifo_depth); //To calculate the number of bits needed for addressing FIFO depth
reg [data_depth-1:0] fifo [0:fifo_depth-1]; // 8 locations that can store 32 - bit data
reg [fifo_depth_log:0] wr_ptr;
reg [fifo_depth_log:0] rd_ptr;

// write operation
always @(posedge clk or posedge rst)
begin
    if(rst)
        begin
            wr_ptr <= 0;
        end
    else if(cs && wr_enb && !f)
        begin
            fifo[wr_ptr[fifo_depth_log-1:0]] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
        end
end

// read operation
always @(posedge clk or posedge rst)
begin
    if(rst)
        begin
            rd_ptr <= 0;
        end
    else if(cs && rd_enb && !e)
        begin
            data_out <= fifo[rd_ptr[fifo_depth_log-1:0]];
            rd_ptr <= rd_ptr + 1'b1;
        end 
end

// full and empty flag generation

    assign e = (rd_ptr == wr_ptr);
    assign f = (rd_ptr == {~wr_ptr[fifo_depth_log], wr_ptr[fifo_depth_log-1:0] });
endmodule