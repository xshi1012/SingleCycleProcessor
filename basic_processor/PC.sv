module PC(
  input init,
        jump_en,		// jump enabled or not
		    branch_taken,	// whether a branch is taken
		    branch_skip,	// whether a branch should be skipped
		    halt,
		    clk,
        req,
  input logic [9:0] jump_addr,
  output logic read_jump,
  output logic[9:0] PC
);

always @(posedge clk) begin
  if(init) begin
    PC <= 0;
    read_jump <= 0;
  end
  else if(halt && !req) begin
    PC <= PC;
    read_jump <= branch_taken;
  end
  else if(branch_skip) begin
    PC <= PC + 2;
    read_jump <= branch_taken;
  end
  else if(jump_en) begin
    PC <= jump_addr;
    read_jump <= branch_taken;
  end
  else begin
    PC <= PC + 1;
    read_jump <= branch_taken;
  end
end
endmodule
