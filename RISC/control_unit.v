module control_unit(
    input wire rst,
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    input wire [6:0] opcode,
    output reg [5:0] alu_cnt,
    output reg lb,
    output reg mem_to_reg,
    output reg bneq_cnt,
    output reg beq_cnt,
    output reg blt_cnt,
    output reg bgeq_cnt,
    output reg sw,
    output reg lui_cnt
);

always @(rst) 
    begin
        if(rst)
            begin
                alu_cnt = 0;
            end
    end
always @(funct7 or funct3 or opcode) 
    begin
        // ------------------ R - type ------------------//
        if(opcode == 7'b0110011)
        begin
            mem_to_reg = 0;
            beq_cnt = 0;
            bneq_cnt = 0;
            bgeq_cnt = 0;
            blt_cnt = 0;
            lui_cnt = 0;

            case(funct3)
                3'b000:
                    begin
                        // ADD
                        if(funct7 == 0)
                            alu_cnt = 6'b000001;
                        // SUB
                        else if(funct7 == 64)
                            alu_cnt = 6'b000010; 
                    end 
                    // SLI
                3'b001:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b000011;
                    end 
                    // Set less than
                3'b010:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b00100;
                    end 
                    // set less than unsigned
                3'b011:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b000101;
                    end 
                    // XOR 
                3'b100:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b000110;
                    end
                    // Shift right logical and arithmatic 
                3'b101:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b000111;
                        else if (funct7 == 64)
                            alu_cnt = 6'b001000;
                    end 
                    // OR
                3'b110:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b001000;
                    end 
                    // AND
                3'b111:
                    begin
                        if(funct7 == 0)
                            alu_cnt = 6'b001001;
                    end
            endcase
        end

        //--------------- I - type instructions ------------------//
        else if(opcode == 7'b0010011)
            begin
                mem_to_reg = 0;
                beq_cnt = 0;
                bneq_cnt = 0;
                lb = 0;
                sw = 0;

                case (funct3)
                    // ADD immidiate
                    3'b000:
                        begin
                            alu_cnt = 6'b001011;
                        end
                    // Shift Left Logical immidiate
                    3'b001:
                        begin
                            alu_cnt = 6'b001100;
                        end
                    // Shift Left immidiate
                    3'b010:
                        begin
                            alu_cnt = 6'b001101;
                        end 
                    // AND immidiate
                    3'b011:
                        begin
                            alu_cnt = 6'b001110;
                        end
                    // XOR immidiate
                    3'b100:
                        begin
                            alu_cnt = 6'b001111;
                        end
                    // Shift Right Logic immidiate
                    3'b101:
                        begin
                            alu_cnt = 6'b010000;
                        end
                    // OR immidiate
                    3'b110:
                        begin
                            alu_cnt = 6'b010001;
                        end
                    // AND Immediate
                    3'b110:
                        begin
                            alu_cnt = 6'b010010;
                        end
                endcase
            end
            //--------------- I - Type Load Instruction ----------//
        else if(opcode == 7'b0000011)
            begin
                case (funct3)
                    // Load Byte
                    3'b000:
                    begin
                        mem_to_reg = 1;
                        beq_cnt = 0;
                        bneq_cnt = 0;
                        lb = 1;
                        alu_cnt = 6'b010011;
                    end 
                    // Load Half
                    3'b001:
                    begin
                        mem_to_reg = 1;
                        beq_cnt = 0;
                        bneq_cnt = 0;
                        alu_cnt = 6'b010100;
                    end 
                    // Load Word
                    3'b010:
                    begin
                        mem_to_reg = 1;
                        beq_cnt = 0;
                        bneq_cnt = 0;
                        alu_cnt = 6'b010101;
                    end 
                    // Load Byte Unsigned
                    3'b000:
                    begin
                        mem_to_reg = 1;
                        beq_cnt = 0;
                        bneq_cnt = 0;
                        alu_cnt = 6'b010110;
                    end 
                    // Load Half Unsigned
                    3'b100:
                    begin
                        mem_to_reg = 1;
                        beq_cnt = 0;
                        bneq_cnt = 0;
                        alu_cnt = 6'b010111;
                    end 
                endcase
            end
        //--------------------------- S - Type Instructions --------------------------//
        else if(opcode == 7'b0100011)
            begin
                case(funct3)
                // Store Byte
                    3'b010:
                        begin
                            mem_to_reg = 1;
                            beq_cnt = 0;
                            bneq_cnt = 0;
                            sw = 1;
                            alu_cnt = 6'b011000;
                        end
                // Store Half Word
                    3'b110:
                        begin
                            mem_to_reg = 1;
                            beq_cnt = 0;
                            bneq_cnt = 0;
                            sw = 1;
                            alu_cnt = 6'b011001;
                        end
                // Store Word
                    3'b111:
                        begin
                            mem_to_reg = 1;
                            beq_cnt = 0;
                            bneq_cnt = 0;
                            sw = 1;
                            alu_cnt = 6'b011010;
                        end
                endcase
            end
        //--------------------------- B - Type Instructions --------------------------//
        else if(opcode == 7'b1100011)
            begin
                case (funct3)
                // Branch Equal Instruction
                    3'b000: 
                        begin
                            beq_cnt = 1;
                            bneq_cnt = 0;
                            blt_cnt = 0;
                            bgeq_cnt = 0;
                            alu_cnt = 6'b011011;
                        end
                // Branch Unequal Instruction
                    3'b001: 
                        begin
                            beq_cnt = 0;
                            bneq_cnt = 1;
                            blt_cnt = 0;
                            bgeq_cnt = 0;
                            alu_cnt = 6'b011100;
                        end
                // Branch Less Than Instruction
                    3'b010: 
                        begin
                            beq_cnt = 0;
                            bneq_cnt = 0;
                            blt_cnt = 1;
                            bgeq_cnt = 0;
                            alu_cnt = 6'b011101;
                        end
                // Branch Greater Than or Equal to Instruction
                    3'b011: 
                        begin
                            beq_cnt = 1;
                            bneq_cnt = 0;
                            blt_cnt = 0;
                            bgeq_cnt = 0;
                            alu_cnt = 6'b011110;
                        end
                endcase
            end
        // ------------------ LUI Instruction ------------------//
        else if(opcode == 7'b0110111)
            begin
                alu_cnt = 6'b011111;
                lui_cnt = 1;
                sw = 0;
                lb = 0;
                beq_cnt = 0;
                bneq_cnt = 0;
                blt_cnt = 0;
                bgeq_cnt = 0;
            end
    end
endmodule