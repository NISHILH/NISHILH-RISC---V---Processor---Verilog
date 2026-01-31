module inst_memo(
    input wire clk,
    input wire rst,
    input wire [31:0] pc,
    output wire [31:0] inst
);
reg [7:0] memory [108:0];
assign inst = {memory[pc+3], memory[pc+2], memory[pc+1], memory[pc]};
always @(posedge clk)
begin
   if (rst)
   begin
    // add
    memory[3] = 8'h00;
    memory[2] = 8'h94;
    memory[1] = 8'h03;
    memory[0] = 8'h33;
    // sub
    memory[7] = 8'h80;
    memory[6] = 8'h01;
    memory[5] = 8'h00;
    memory[4] = 8'hb3;
    // sll
    memory[11] = 8'h00;
    memory[10] = 8'h20;
    memory[9] = 8'h91;
    memory[8] = 8'h33;
    // XOR
    memory[15] = 8'h00;
    memory[14] = 8'hc5;
    memory[13] = 8'h4A;
    memory[12] = 8'hb3;
    // srl
    memory[19] = 8'h00;
    memory[18] = 8'hc5;
    memory[17] = 8'h5a;
    memory[16] = 8'hb3;
    // OR
    memory[23] = 8'h00;
    memory[22] = 8'hd6;
    memory[21] = 8'h7f;
    memory[20] = 8'hb3;
    // and
    memory[27] = 8'h00;
    memory[26] = 8'hf7;
    memory[25] = 8'h68;
    memory[24] = 8'hb3;
    // I type
    // addI
    memory[31] = 8'h00;
    memory[30] = 8'ha0;
    memory[29] = 8'h85;
    memory[28] = 8'h13;
    // sllI
    memory[35] = 8'h00;
    memory[34] = 8'h41;
    memory[33] = 8'h93;
    memory[32] = 8'h13;
    // XORI
    memory[39] = 8'h03;
    memory[38] = 8'hf2;
    memory[37] = 8'hc7;
    memory[36] = 8'h26;
    // SLTI
    memory[43] = 8'h00;
    memory[42] = 8'ha1;
    memory[41] = 8'h20;
    memory[40] = 8'h93;
    // SRLI
    memory[47] = 8'h00;
    memory[46] = 8'h31;
    memory[45] = 8'h50;
    memory[44] = 8'h93;
    // OR_I
    memory[51] = 8'h00;
    memory[50] = 8'hf1;
    memory[49] = 8'h60;
    memory[48] = 8'h93;
    // AND_I
    memory[55] = 8'h00;
    memory[54] = 8'hf1;
    memory[53] = 8'h70;
    memory[52] = 8'h93;
    // LWI
    memory[59] = 8'h00;
    memory[58] = 8'h43;
    memory[57] = 8'h02;
    memory[56] = 8'h83;
    // SWI
    memory[63] = 8'h00;
    memory[62] = 8'h73;
    memory[61] = 8'h28;
    memory[60] = 8'h23;
    // BE
    memory[67] = 8'h00;
    memory[66] = 8'h41;
    memory[65] = 8'h00;
    memory[64] = 8'h63;
    // BNE
    memory[71] = 8'h00;
    memory[70] = 8'h20;
    memory[69] = 8'h94;
    memory[68] = 8'h63;
    // BGE
    memory[75] = 8'h00;
    memory[74] = 8'h41;
    memory[73] = 8'ha4;
    memory[72] = 8'h63;
    // BL
    memory[79] = 8'h00;
    memory[78] = 8'h20;
    memory[77] = 8'hc1;
    memory[76] = 8'h63;
    // LUI
    memory[83] = 8'h12;
    memory[82] = 8'h34;
    memory[81] = 8'h52;
    memory[80] = 8'hb7;
   end 
end
endmodule