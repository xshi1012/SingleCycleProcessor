module reg_file #(parameter W=8, D=3)(
  input      CLK,
	init,
                  write_en,
  input  [ D-1:0] raddrA,
                  raddrB,
                  waddr,
  input   [ W-1:0] data_in,
  output logic [ W-1:0] data_outA,
  output logic [W-1:0] data_outB
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0

assign  data_outA = registers[raddrA];
assign  data_outB = registers[raddrB];

// sequential (clocked) writes	(likewise, can't write to addr 0)
always_ff @ (posedge CLK) 
  if(init) begin
    registers[0] <= 8'b00000000; 
    registers[1] <= 8'b00000000; 
    registers[2] <= 8'b00000000; 
    registers[3] <= 8'b00000000; 
    registers[4] <= 8'b00000000; 
    registers[5] <= 8'b00000000; 
    registers[6] <= 8'b00000000; 
    registers[7] <= 8'b00000000; 
  end
  else if (write_en) begin	// protected constant
    registers[waddr] <= data_in;
    //$display( "data_in", data_in, "registers", waddr, " now: ", registers[waddr]);
  end
endmodule

