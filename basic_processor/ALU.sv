module ALU(
  input [ 7:0] INPUTA,      	  // data inputs
               INPUTB,
  input [ 2:0] opcode,				  // ALU opcodecode, part of microcode
  input func,
  output logic [7:0] ALU_out,		  // or:  output reg [7:0] ALU_out,
  output logic branch_taken,
  output logic branch_skip
    );
	 
  always_comb begin
    {branch_skip, branch_taken, ALU_out} = 0;       // default -- reset ALU_out and not branching
// single instruction for both LSW & MSW
    case(opcode)
      3'b000: begin
        ALU_out = INPUTA + INPUTB;
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b001: begin
        ALU_out = INPUTB;
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b010: begin
        branch_skip = 0;
        branch_taken = 0;
        if(INPUTB) begin              // halt otherwise
          case(func)
            1'b0: begin                // left shift
              case(INPUTB[1:0])
                2'b01: begin
                  ALU_out = {INPUTA[6:0], INPUTA[7]};
                end
                2'b10: begin
                  ALU_out = {INPUTA[5:0], INPUTA[7:6]};
                end
                2'b11: begin
                  ALU_out = {INPUTA[4:0], INPUTA[7:5]};
                end
              endcase
            end
            1'b1: begin                // right shift
              case(INPUTB[1:0])
                2'b01: begin
                  ALU_out = {INPUTA[0], INPUTA[7:1]};
                end
                2'b10: begin
                  ALU_out = {INPUTA[1:0], INPUTA[7:2]};
                end
                2'b11: begin
                  ALU_out = {INPUTA[2:0], INPUTA[7:3]};
                end
              endcase
            end
          endcase
        end
      end
      3'b011: begin                   // LW
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b100: begin                   // SW
        ALU_out = INPUTA;
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b101: begin                   // XOR
        ALU_out = INPUTA ^ INPUTB;
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b110: begin                   // AND
        ALU_out = INPUTA & INPUTB;
        branch_skip = 0;
        branch_taken = 0;
      end
      3'b111: begin                   // BNE
        if (INPUTA == INPUTB) begin
          branch_skip = 1;
          branch_taken = 0;
        end
        else begin
          branch_skip = 0;
          branch_taken = 1;
        end
      end
    endcase
  end
endmodule



	   /*
			Left shift

            
			  input a = 10110011   sc_in = 1

              output = 01100111
			  sc_out =	1

							   */