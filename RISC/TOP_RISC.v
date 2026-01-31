module top_RISC(
    input wire clk,
    input wire rst
);
wire [31:0] imm_val_top;
wire [31:0] pc;
wire [31:0] instr;
wire [5:0] alu_cnt;
wire mem_to_reg;
wire beq_cnt;
wire BEQ;
wire bneq_cnt;
wire BNEQ;
wire bgeq_cnt;
wire BGT;
wire blt_cnt;
wire BLT;
wire lb;
wire sw;
wire [31:0] imm_val_bt;
wire [4:0] read_data_addr_dm;
wire lui_cnt;
wire [31:0] imm_val_lui;
wire [31:0] cur_PC;
wire [31:0] imm_val_s;
wire[31:0] base_addr;

//------------------- Instruction Fetch Unit ------------------//
IFU ifu(
    .clk(clk),
    .rst(rst),
    .imm_add(imm_val_top),
    .BEQ(BEQ),
    .BNEQ(BNEQ),
    .BGT(BGT),
    .BLT(BLT),
    .pc(pc),
    .cur_PC(cur_PC)
);

//------------------- Instruction Memory ------------------//
inst_memo IMU(
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .inst(instr)
);

//------------------- Control Unit ------------------//
control_unit CU(
    .rst(rst),
    .funct7(instr[31:25]),
    .funct3(instr[14:12]),
    .opcode(instr[6:0]),
    .alu_cnt(alu_cnt),
    .lb(lb),
    .mem_to_reg(mem_to_reg),
    .bneq_cnt(bneq_cnt),
    .beq_cnt(beq_cnt),
    .blt_cnt(blt_cnt),
    .bgeq_cnt(bgeq_cnt),
    .sw(sw),
    .lui_cnt(lui_cnt)
);

//------------------- Datapath ------------------//
datapath DP(
    .clk(clk),
    .rst(rst),
    .read_reg1(instr[19:15]),
    .read_reg2(instr[24:20]),
    .write_reg(instr[11:7]),
    .alu_control(alu_cnt),
    .beq_control(beq_cnt),
    .bneq_control(bneq_cnt),
    .blt_control(blt_cnt),
    .bgeq_control(bgeq_cnt),
    .lui_control(lui_cnt),
    .imm_val(imm_val_bt), 
    .beq(BEQ),
    .bneq(BNEQ),
    .bge(BGT), 
    .blt(BLT),
    .imm_val_lui(imm_val_lui),
    .sw(sw),
    .lb(lb),
    .read_data_add_dm(read_data_addr_dm)
);

assign imm_val_top = {{20{instr[31]}}, instr[31:21]};
assign imm_val_bt = {{20{instr[31]}}, instr[30:25], instr[11:8], instr[7]};
assign imm_val_lui = {10'b0, instr[31:12]};
assign imm_val = imm_val_top;
endmodule