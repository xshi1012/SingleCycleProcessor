module PC_tb();

logic init = 0,
      jump_en = 0,		
      branch_en = 0,
      halt = 0,		
      CLK=0;
logic[9:0] target = 10'b000000000;
wire[9:0] PC;
 
PC pc1(.*);		 // .init(init),.jump_en(jump_en),...
 
always begin
   #5ns CLK = 1;
   #5ns CLK = 0;
end   

initial begin
  #5ns init = 1;
  #10ns init = 0;
  #20ns branch_en = 1;
  #10ns branch_en = 0;
  #50ns jump_en = 1; 
	target = 10'b0000000100;
  #10ns jump_en = 0;
  #50ns jump_en = 1; 
	target = 10'b0000000011;
  #10ns jump_en = 0;
  #50ns branch_en = 1;
  #20ns branch_en = 0;
  #50ns halt = 1;
  #50ns  $stop; 
end  
  
endmodule