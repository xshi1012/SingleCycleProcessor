module PC(
  input init,
        jump_en,		// jump enabled or not
		    branch_taken,	// whether a branch is taken
		    branch_skip,	// whether a branch should be skipped
		    halt,
		    clk,
  input logic [8:0] jump_addr,
  output logic read_jump,
  output logic[ 9:0] PC,
  output logic ack
);

always @(posedge clk) begin
  if(init) begin
    PC <= 0;
    read_jump <= 0;
  end
  else if(halt) begin
    PC <= PC;
    read_jump <= branch_taken;
  end
  else if(branch_skip) begin
    PC <= PC + 2;
    read_jump <= branch_taken;
  end
  else if(jump_en) begin
    PC <= {1'b0,jump_addr};
    read_jump <= branch_taken;
  end
  else begin
    PC <= PC + 1;
    read_jump <= branch_taken;
  end

  if (PC == 169 | PC == 365) begin
    ack <= 1;
  end
  else begin
    ack <= halt;
  end
end
endmodule
