// Create Date:    2018.04.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
  input     start,	   // init/reset, active high
	input     CLK,		   // clock -- posedge used inside design
  output    halt		   // done flag from DUT
);

wire [9:0]  PC;            // program count
wire [8:0]  instruction;   // our 9-bit opcode
wire [7:0]  reg_out1, reg_out2;  // reg_file outputs
wire [7:0]  immediate,	   // Immediate value
            ALU_out,       // ALU resultS
			      data2;

wire [7:0]  regWriteValue, // data in to reg file
            memWriteValue, // data in to data_memory
	   	      mem_out;	   // data out from data_memory

logic [2:0] opcode,         // opcode
			      operand1,       // first operand
			      operand2,       // second operand 
			      reg_write_addr; // the register that the result will be written
logic 		  func;           // function code
logic [8:0] jump_addr;      // jump target
wire		    jump_en,        // jumping
			      branch_skip,    // is a branch skipped
            branch_taken,   // is a branch taken
            read_jump,      // next instruction is an address
			      imm_operand2,   // whether operand2 is immediate
            ALU_write_reg,  // whether writing to register from ALU or MEM
            write_to_reg,   // whether writing to register
            write_mem,      // whether writing to MEM
            read_mem,       // where reading from MEM
            Halt;           // finished
  
  assign regWriteValue = ALU_write_reg ? ALU_out : mem_out;
  assign data2 = imm_operand2 ? immediate : reg_out2;
  assign halt = Halt;

  PC PC1 (
    .init     (start),
    .jump_en,
    .branch_taken,
    .branch_skip,
    .halt     (Halt),
    .CLK,
    .jump_addr,
    .read_jump,
    .PC
  );

  InstROM instruction_rom (
    .InstAddress  (PC),
    .InstOut      (instruction)
  );

  Ctrl ctrl_decoder (
    .instruction,
    .read_jump,
    .opcode,
    .operand1,
    .operand2,
    .reg_write_addr,
    .immediate,
    .func,
    .jump_addr,
    .imm_operand2,
    .ALU_write_reg,
    .write_to_reg,
    .write_mem,
    .read_mem,
    .jump_en,
    .Halt
  );

  reg_file #(.W(8), .D(3)) register_file (
    .CLK,
    .init     (start),
    .write_en (write_to_reg),
    .raddrA   (operand1),
    .raddrB   (operand2),
    .waddr    (reg_write_addr),
    .data_in  (regWriteValue),
    .data_outA(reg_out1),
    .data_outB(reg_out2)
  );

  ALU alu (
    .INPUTA   (reg_out1),
    .INPUTB   (data2),
    .opcode,
    .func,
    .ALU_out,
    .branch_taken,
    .branch_skip
  );

  data_mem data_memory (
    .CLK,
    .reset      (start),
    .DataAddress(reg_out2),
    .ReadMem    (read_mem),
    .WriteMem   (write_mem),
    .DataIn     (reg_out1),
    .DataOut    (mem_out)
  );
endmodule