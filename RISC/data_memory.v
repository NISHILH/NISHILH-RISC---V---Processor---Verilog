module data_memory(
input clk,
input rst,
input [4:0] wr_add,
input [31:0] wr_data,
input sw,
input [4:0] rd_add,
output [31:0] data_out
);

reg [7:0] data_mem [31:0];
integer i;
  
always @(posedge clk)
begin
    if(rst)
       begin
         for(i = 0;i < 32;i = i + 1)
           data_mem[i] <= i;
       end
    else if(sw)
       begin
         data_mem[i] <= i;
       end
    else
       if(sw)
       begin
          data_mem[wr_add] <= wr_data;
       end
end

assign data_out = data_mem[rd_add];

endmodule