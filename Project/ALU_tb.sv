module ALU_tb();
logic [ 7:0] INPUTA;      	  // data inputs
  logic [ 7:0]     INPUTB;
  logic [ 2:0] OP;			  // ALU opcode, part of microcode
  logic [ 1:0] Function_code;   //function_code          
  logic [7:0] OUT;	//output reg [7:0] OUT,
  logic branch_en;
 
ALU alu1(.*);		 // .init(init),.jump_en(jump_en),...   

initial begin
  #10ns 
    OP =  3'b000;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b000;
    Function_code = 2'b01;
    INPUTA = 8'b00000101;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b000;
    Function_code = 2'b10;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00010011;
#10ns 
    OP =  3'b000;
    Function_code = 2'b11;
    INPUTA = 8'b000010001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b001;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00010011;
#10ns 
    OP =  3'b001;
    Function_code = 2'b10;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b010;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b010;
    Function_code = 2'b10;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b011;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b100;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b101;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b101;
    Function_code = 2'b00;
    INPUTA = 8'b00000011;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b110;
    Function_code = 2'b00;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b111;
    Function_code = 2'b00;
    INPUTA = 8'b00001001;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b111;
    Function_code = 2'b01;
    INPUTA = 8'b00000001;
    INPUTB = 8'b00000111;
#10ns 
    OP =  3'b111;
    Function_code = 2'b10;
    INPUTA = 8'b00000011;
    INPUTB = 8'b00000011;
#10ns 
    OP =  3'b111;
    Function_code = 2'b11;
    INPUTA = 8'b00000101;
    INPUTB = 8'b00000011;
  #20ns  $stop; 
end  
  
endmodule