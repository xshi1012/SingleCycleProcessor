module reg_file #(parameter W=8, D=3)(		 // W = data path width; D = pointer width
  input          clk,
                 init,
                 write_en,
  input  [D-1:0] raddrA,
                 raddrB,
                 waddr,
  input  [W-1:0] data_in,
  output logic [W-1:0] data_outA,
  output logic [W-1:0] data_outB
    );

logic [W-1:0] registers[2**D];

// read, combinational
assign      data_outA = registers[raddrA];
assign      data_outB = registers[raddrB];

// write on positive edge of clock
always_ff @ (posedge clk)
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
  else if(write_en) begin
    registers[waddr] <= data_in;
  end
endmodule
