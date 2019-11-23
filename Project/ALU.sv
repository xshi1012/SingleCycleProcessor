module ALU(
  input [ 7:0] INPUTA,      	  // data inputs
               INPUTB,
  input [ 2:0] OP,				  // ALU opcode, part of microcode
  input [ 1:0] Function_code,   //function_code          
  output logic [7:0] OUT,	//output reg [7:0] OUT,
  output logic branch_en		//jump enable
    );

//  op_mne op_mnemonic;

  always_comb begin
    {branch_en,OUT} = 0;
// single instruction for both LSW & MSW
  case(OP)
    3'b000: begin
		case(Function_code)
	          2'b00: begin		//MOV
			  OUT = INPUTB;
			  branch_en = 0;
	    		 end
		  2'b01: begin		//SLL
			  OUT = INPUTA	<< 1;
			  branch_en = 0;
	    		 end
		  2'b10: begin		//SRL
			  OUT = INPUTA	>> 1;
			  branch_en = 0; 
	    		 end
		  2'b11: begin		//HALT
			  
	    		 end
		 // default: {jump_en,OUT} = 0;
	        endcase
	    end
    3'b001: begin 		//AND
		OUT = INPUTA & INPUTB;
		branch_en = 0;  
	    end
    3'b010: begin 		//XOR
		OUT = INPUTA ^ INPUTB;
		branch_en = 0;
	    end
    3'b011: begin 		//LD
		branch_en = 0;
	    end
    3'b100: begin 		//SW
		OUT = INPUTA;
		branch_en = 0;
	    end
    3'b101: begin 		//BNE
	       if (0 == (INPUTA ^ INPUTB))
 		  branch_en = 1;
		else
		  branch_en = 0;
	    end
    3'b110: begin 		//ADD
		OUT = INPUTA + INPUTB;
		branch_en = 0;
	    end
    3'b111: begin
		//INC
		OUT = INPUTA + 1;
		branch_en = 0;
	    end
  endcase 
  end
endmodule
