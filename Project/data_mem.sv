module data_mem(
  input              CLK,
  input              reset,			// optional; permits initialization
  input [7:0]        DataAddress,	// pointer for both read and write
  input              ReadMem,		// optional read enable
  input              WriteMem,		// required write (store) enable
  input [7:0]        DataIn,
  output logic[7:0]  DataOut);

  logic [7:0] core [256];      // memory core itself  256 byte-wide words

//  initial 
//    $readmemh("dataram_init.list", my_memory);
  always_comb                     // reads are combinational
    if(ReadMem) begin			  // tie ReadMem high in most cases
      DataOut = core[DataAddress];
// optional diagnostic print
	  //$display("core read M[%d] = %d",DataAddress,DataOut);
    end else 
      DataOut = 'bZ;           // tristate, undriven

  always_ff @ (posedge CLK)		 // writes are sequential
    if(reset) begin
// you may initialize your memory w/ constants, if you wish
      for(int i=0;i<256;i++)
	    core[i] <= 0;
	end
    else if(WriteMem) begin
      core[DataAddress] <= DataIn;
// optional diagnostic print statement
	  //$display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule