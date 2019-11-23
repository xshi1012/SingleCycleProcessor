module Ctrl (
  input[8:0] Instruction,	 
  output logic [2:0] op_code,
		     R1_address,
		     R2_address,
		     Writen_address,
  output logic [7:0] Imm,
  output logic [1:0] Function_code,
  output logic [4:0] Jump_address,
  output logic ALU_src,
	       Writen_src,
	       Reg_writen,
	       Mem_writen,
	       Mem_read,
	       Jump_en,
	       Halt
);

always_comb begin
  case(Instruction[8:6])
     3'b000: begin
	     	case(Instruction[1:0])
		    2'b00: begin
		           op_code = Instruction[8:6];
		           R1_address = Instruction[5:3];
		           R2_address = Instruction[2:0];
		           Writen_address = Instruction[5:3];
		           Imm = 8'b00000000 + Instruction[2];
		           Function_code = Instruction[1:0];
		           Jump_address = Instruction[5:1];
		           ALU_src = 1;
		           Writen_src = 1;
	                   Reg_writen = 1;
	                   Mem_writen = 0;
	                   Mem_read = 0;
	                   Jump_en = 0;
	                   Halt = 0;
		           end
		    2'b01: begin
		           op_code = Instruction[8:6];
		           R1_address = Instruction[5:3];
		           R2_address = Instruction[2:0];
		           Writen_address = Instruction[5:3];
		           Imm = 8'b00000000 + Instruction[2];
		           Function_code = Instruction[1:0];
		           Jump_address = Instruction[5:1];
		           ALU_src = 1;
		           Writen_src = 1;
	                   Reg_writen = 1;
	                   Mem_writen = 0;
	                   Mem_read = 0;
	                   Jump_en = 0;
	                   Halt = 0;
		           end
		    2'b10: begin
		           op_code = Instruction[8:6];
		           R1_address = Instruction[5:3];
		           R2_address = Instruction[2:0];
		           Writen_address = Instruction[5:3];
		           Imm = 8'b00000000 + Instruction[2];
		           Function_code = Instruction[1:0];
		           Jump_address = Instruction[5:1];
		           ALU_src = 1;
		           Writen_src = 1;
	                   Reg_writen = 1;
	                   Mem_writen = 0;
	                   Mem_read = 0;
	                   Jump_en = 0;
	                   Halt = 0;
		           end
		    2'b11: begin
		           op_code = Instruction[8:6];
		           R1_address = Instruction[5:3];
		           R2_address = Instruction[2:0];
		           Writen_address = Instruction[5:3];
		           Imm = 8'b00000000 + Instruction[2];
		           Function_code = Instruction[1:0];
		           Jump_address = Instruction[5:1];
		           ALU_src = 0;
		           Writen_src = 0;
	                   Reg_writen = 0;
	                   Mem_writen = 0;
	                   Mem_read = 0;
	                   Jump_en = 0;
	                   Halt = 1;
		           end
	     	endcase
	     end
     
     3'b001: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 1;
	     Reg_writen = 1;
	     Mem_writen = 0;
	     Mem_read = 0;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b010: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 1;
	     Reg_writen = 1;
	     Mem_writen = 0;
	     Mem_read = 0;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b011: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 0;
	     Reg_writen = 1;
	     Mem_writen = 0;
	     Mem_read = 1;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b100: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 0;
	     Reg_writen = 0;
	     Mem_writen = 1;
	     Mem_read = 0;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b101: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 0;
	     Reg_writen = 0;
	     Mem_writen = 0;
	     Mem_read = 0;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b110: begin
	     op_code = Instruction[8:6];
	     R1_address = Instruction[5:3];
  	     R2_address = Instruction[2:0];
	     Writen_address = Instruction[5:3];
             Imm = 8'b00000000;
	     Function_code = Instruction[1:0];
             Jump_address = Instruction[5:1];
	     ALU_src = 0;
             Writen_src = 1;
	     Reg_writen = 1;
	     Mem_writen = 0;
	     Mem_read = 0;
	     Jump_en = 0;
	     Halt = 0;
	     end

     3'b111: begin
	     case(Instruction[0])
		1'b0: begin
		      op_code = Instruction[8:6];
		      R1_address = Instruction[5:3];
		      R2_address = Instruction[2:0];
		      Writen_address = Instruction[5:3];
		      Imm = 8'b00000000;
		      Function_code = Instruction[1:0];
		      Jump_address = Instruction[5:1];
		      ALU_src = 0;
		      Writen_src = 0;
	              Reg_writen = 0;
	              Mem_writen = 0;
	              Mem_read = 0;
	              Jump_en = 1;
	              Halt = 0;
		      end
		1'b1: begin
		      op_code = Instruction[8:6];
		      R1_address = Instruction[3:1];
		      R2_address = Instruction[2:0];
		      Writen_address = Instruction[3:1];
		      Imm = 8'b00000000;
		      Function_code = Instruction[1:0];
		      Jump_address = Instruction[5:1];
		      ALU_src = 0;
		      Writen_src = 1;
	              Reg_writen = 1;
	              Mem_writen = 0;
	              Mem_read = 0;
	              Jump_en = 0;
	              Halt = 0;
		      end
	     endcase
	     end

  endcase

  end
endmodule