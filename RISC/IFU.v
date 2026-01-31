module IFU(
    input wire clk,
    input wire rst,
    input wire [31:0]imm_add,
    input wire BEQ,
    input wire BNEQ,
    input wire BGT,
    input wire BLT,
    output reg [31:0] pc,
    output reg [31:0] cur_PC
);
always @ (posedge clk)
begin
    if(rst)
        begin
            pc <= 0;
        end 
    else if (BEQ == 0 && BGT == 0 && BNEQ == 0 && BLT == 0) 
    begin
        pc <= pc + 4;    
    end
    else if(BEQ == 1 || BNEQ == 1 || BLT == 1 || BGT == 1)
    begin
        pc <= pc + imm_add;
    end
end
always @(posedge clk)
    begin
        if (rst)
        begin
            cur_PC <= 0;
        end
        else if(!rst)
        begin
            cur_PC <= pc + 4; 
        end
        else
        begin
            cur_PC <= cur_PC;
        end
    end
endmodule