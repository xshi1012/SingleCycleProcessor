module data_mem(
  input              CLK,
  input              reset,
  input [7:0]        DataAddress,
  input              ReadMem,
  input              WriteMem,
  input [7:0]        DataIn,
  output logic[7:0]  DataOut);

  logic [7:0] core[256];
 
  always_comb           // combinational read logic
    if(ReadMem) begin
      DataOut = core[DataAddress];
	  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end else 
      DataOut = 'bZ;

  always_ff @ (posedge CLK)		 // writes are sequential
    if(WriteMem) begin
      core[DataAddress] <= DataIn;
	  $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
