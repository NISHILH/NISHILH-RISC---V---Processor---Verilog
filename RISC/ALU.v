module ALU(
    input wire [31:0] r1,
    input wire [31:0] r2,
    input wire [5:0] alu_cnt,
    input wire [31:0] imm_val,
    input wire [3:0] shamt,
    output reg [31:0] out    
);
always @(*)
    begin
        case (alu_cnt)
            //----------- R - Type instructions --------
            6'b000001: out = r1 + r2;                // ADD  
            6'b000010: out = r1 - r2;                // SUB  
            6'b000011: out = r1 << r2;               // SLI
            6'b000100: out = (r1 < r2)? 1 : 0;       // SLT
            6'b000110: out = r1 ^ r2;                // XOR
            // ----------- I - Type instructions --------
            6'b000111: out = r1 >>> r2;              // SRI
            6'b001000: out = r1 | r2;                // OR
            6'b001001: out = r1 & r2;                // AND
            6'b001011: out = r1 + imm_val;           // ADDI
            6'b001100: out = imm_val << shamt;       // SLII
            6'b001101: out = (imm_val < r1)? 1 : 0;   // SLTI
            6'b001110: out = r1 & imm_val;           // ANDI
            6'b001111: out = imm_val ^ r1;           // XORI
            6'b010000: out = imm_val >>> shamt;      // SRII
            6'b010001: out = r1 | imm_val;           // ORI
            //----------- Branch instructions --------
            6'b011011: out = (r1 == r2)? 1 : 0;       // BEQ
            6'b011100: out = (r1 != r2)? 1 : 0;       // BNE
            6'b011101: out = (r1 < r2)? 1 : 0;       // BLT
            6'b011110: out = (r1 >= r2)? 1 : 0;      // BGE
            //----------- Load/Store instructions --------
        endcase
    end
endmodule