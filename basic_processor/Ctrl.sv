module Ctrl (
  input[8:0] instruction,	   // machine code
  input logic read_jump,
  output logic [2:0] opcode,
                     operand1,
                     operand2,
                     reg_write_addr,
  output logic [7:0] immediate,
  output logic func,
  output logic [5:0] lut_index,
  output logic imm_operand2,
               ALU_write_reg,
               write_to_reg,
               write_mem,
               read_mem,
               jump_en,
               Halt
  );
always_comb begin
  if (read_jump) begin                   // JR
    opcode = 3'b000;
    operand1 = instruction[5:3];
    operand2 = instruction[2:0];
    reg_write_addr = instruction[5:3];
    immediate = 8'b00000000;
    func = instruction[2];
    lut_index = instruction[5:0];
    imm_operand2 = 0;
    ALU_write_reg = 0;
    write_to_reg = 0;
    write_mem = 0;
    read_mem = 0;
    jump_en = 1;
    Halt = 0;
  end
  else begin
    case(instruction[8:6])
      3'b000: begin                         // ADD
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 1;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
      3'b001: begin                         // MOV
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000 + instruction[2:0];
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 1;
        ALU_write_reg = 1;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
      3'b010: begin                         // shift
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000 + instruction[1:0];
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 1;
        ALU_write_reg = 1;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        if(instruction[5:0] == 6'b000000) begin
          Halt = 1;
        end
        else begin
          Halt = 0;
        end
      end
      3'b011: begin                         // LW
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 0;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 1;
        jump_en = 0;
        Halt = 0;
      end
      3'b100: begin                         // SW
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 0;
        write_to_reg = 0;
        write_mem = 1;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
      3'b101: begin                         // XOR
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 1;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
      3'b110: begin                         // AND
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 1;
        write_to_reg = 1;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
      3'b111: begin                         // BNE
        opcode = instruction[8:6];
        operand1 = instruction[5:3];
        operand2 = instruction[2:0];
        reg_write_addr = instruction[5:3];
        immediate = 8'b00000000;
        func = instruction[2];
        lut_index = instruction[5:0];
        imm_operand2 = 0;
        ALU_write_reg = 0;
        write_to_reg = 0;
        write_mem = 0;
        read_mem = 0;
        jump_en = 0;
        Halt = 0;
      end
    endcase
  end
end

endmodule