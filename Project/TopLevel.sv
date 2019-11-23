module TopLevel(
    input     start,	   // init/reset, active high
    input     dm_reset,
    input     CLK,		   // clock -- posedge used inside design
    output logic   halt		   // done flag from DUT
    );	

wire [ 9:0] PC;            // program count
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] ReadA, ReadB;  // reg_file outputs
wire [ 7:0] InA, InB, 	   // ALU operand inputs
            Imm,         // immediate feed to ALU
            ALU_out,       // ALU result
		data_outB,
		data2,
		data_outA;
wire [ 7:0] regWriteValue, // data in to reg file
            memWriteValue, // data in to data_memory
	    Mem_Out;	   // data out from data_memory

logic [9:0] target, Target;
logic [2:0] OP,
	op_code,
	R1_address,
	R2_address,
	waddr,
	Writen_address;
logic [1:0] Function_code;
logic [4:0]addr,
	Jump_address;
wire 	jump_en,	  
        branch_en,	  
        data_mem_reset,
	init,
	ALU_src,
	Writen_src,
	Reg_writen,
	Mem_writen,
	Mem_read,
	Jump_en,
	Halt;


//mux
assign regWriteValue = Writen_src? ALU_out:Mem_Out; //write back to register from alu or mem
assign halt = Halt;

  PgmCtr PC1 (
// inputs:
	.init       (start), 
	.jump_en    (Jump_en),  // jump enable
	.branch_en	   ,  // branch enable
	.halt       (Halt),  // SystemVerilg shorthand for .halt(halt), 
	.CLK        (CLK)  ,  // (CLK) is required in Verilog, optional in SystemVerilog
	.target	(Target),
// outputs:
	.PC         (PC)   	  // program count = index to instruction memory
	);					 

// instruction ROM
  InstROM instr_ROM1(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);

// Control decoder
  Ctrl Ctrl1 (
//input:
	.Instruction,    // from instr_ROM
//output: 
  	.op_code,
	.R1_address ,
	.R2_address,
	.Writen_address,
  	.Imm,
	.Function_code,
 	.Jump_address,
	.ALU_src,
	.Writen_src,
	.Reg_writen,
	.Mem_writen,
	.Mem_read,
	.Jump_en,
	.Halt (Halt)
	
  );

  LUT lut(
	.addr	(Jump_address),
    	.Target
	);
// reg file
	reg_file #(.W(8),.D(3)) reg_file1 (
		.CLK,
		.init      (start),
		.write_en  (Reg_writen), 
		.raddrA    (R1_address), 
		.raddrB    (R2_address),
		.waddr     (Writen_address), 	 
		.data_in   (regWriteValue), 
		.data_outA (ReadA ), 
		.data_outB (ReadB )
	);

//mux
assign data2 = ALU_src? Imm: ReadB;

//ALU
    ALU ALU1  (
	  .INPUTA  (ReadA),
	  .INPUTB  (data2), 
	  .OP      (op_code),
	  .Function_code ,
	  .OUT     (ALU_out),//regWriteValue),
	  .branch_en 
	  );
  
    data_mem dm1(					// everyone will need this 
		.DataAddress  (ReadB), 
		.ReadMem      (Mem_read),          //(MEM_READ) ,   always enabled 
		.WriteMem     (Mem_writen), 
		.DataIn       (ALU_out), 
		.DataOut      (Mem_Out)  , 
		.CLK   	   ,
		.reset		  (dm_reset)
	);

	
//always_ff @(posedge CLK)
//  if (start == 1)	   // if(start)
//  	cycle_ct <= 0;
//  else if(halt == 0)   // if(!halt)
//  	cycle_ct <= cycle_ct+16'b1;


endmodule

