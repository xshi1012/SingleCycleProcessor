module PgmCtr(
  input init,
  input jump_en,		
  input branch_en,
  input halt,	 
  input CLK,
  input logic [9:0] target,
  output logic[9:0] PC
    );

always @(posedge CLK)
  if(init) begin
    PC <= 0;  //execute initial line
  end
  else if(halt) begin
    PC <= PC;
  end
  else if(branch_en) begin
    PC <= PC + 2;  //execute 2 lines away from current line
  end
  else if(jump_en) begin
    PC <= target; //execute the target line
  end
  else begin
    PC <= PC + 1; //execute next line
  end
endmodule