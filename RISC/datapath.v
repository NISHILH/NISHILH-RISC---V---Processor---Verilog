module datapath(
input wire clk,
input wire rst,
input wire [4:0] read_reg1,
input wire [4:0] read_reg2,
input wire [4:0] write_reg,
input wire [5:0] alu_control,
input wire beq_control,
input bneq_control,
input wire blt_control,
input wire bgeq_control,
input wire [31:0] imm_val,
input wire [3:0] sh_amt,
input wire lb,
input wire sw,
input wire lui_control,
input wire [31:0] imm_val_lui,
output wire [4:0] read_data_add_dm,
output wire beq,
output wire bneq,
output wire bge,
output wire blt
);

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [4:0] read_data_addr_dm_2;
wire [31:0] write_data_alu;
wire [31:0] data_out;
wire [31:0] data_out_2_dm;

RFU rfu(
.clk(clk),
.rst(rst),
.read_reg1(read_reg1),
.read_reg2(read_reg2),
.write_reg(write_reg),
.write_data_dm(data_out),
.lb(lb),
.lui_control(lui_control),
.lui_imm_val(imm_val_lui),
.read_data1(read_data1),
.read_data2(read_data2),
.read_data_add_dm(read_data_addr_dm_2),
.data_out_2_dm(data_out_2_dm),
.sw(sw)
);

ALU alu(
.r1(read_data1),
.r2(read_data2),
.alu_cnt(alu_control),
.imm_val(imm_val),
.shamt(sh_amt),
.out(write_data_alu)
);

data_memory DMU(
.clk(clk),
.rst(rst),
.wr_add(imm_val[4:0]),
.wr_data(data_out_2_dm),
.sw(sw),
.rd_add(imm_val[4:0]),
.data_out(data_out)
);

assign read_data_add_dm = read_data_addr_dm_2;
assign beq = (write_data_alu == 1 && beq_control == 1) ? 1 : 0;
assign bneq = (write_data_alu == 1 && bneq_control == 1) ? 1 : 0;
assign bge = (write_data_alu == 1 && bgeq_control == 1) ? 1 : 0;
assign blt = (write_data_alu == 1 && blt_control == 1) ? 1 : 0;

endmodule




