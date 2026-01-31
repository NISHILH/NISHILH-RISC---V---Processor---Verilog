module RFU(
input wire clk,
input wire rst,
input wire [4:0] read_reg1,
input wire [4:0] read_reg2,
input wire [4:0] write_reg,
input wire [31:0] write_data_dm,
input wire lb,
input wire lui_control,
input wire [31:0] lui_imm_val,
output wire [31:0] read_data1,
output wire [31:0] read_data2,
output wire [4:0] read_data_add_dm,
output reg [31:0] data_out_2_dm,
input wire sw
);
 
reg [31:0] reg_mem [31:0];
wire [31:0] write_reg_dm;

assign read_data_addr_dm = write_reg;
assign write_reg_dm = write_reg;

integer i;

always @(posedge clk)
begin
     if(rst)
        begin
        for(i = 0;i < 32;i = i + 1)
           reg_mem[i] <= i;
           data_out_2_dm = 0;
        end
     else
        begin
          if(lb)
               reg_mem[write_reg] <= write_data_dm;
          else if(sw)
               data_out_2_dm <= reg_mem[read_reg1]; 
          else if(lb)
               reg_mem[write_reg] <= lui_imm_val;
        end
end
 
assign read_data1 = reg_mem[read_reg1];
assign read_data2 = reg_mem[read_reg2];

endmodule
