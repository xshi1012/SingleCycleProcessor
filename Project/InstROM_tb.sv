module InstROM_tb();

logic [7:0]InstAddress = 8'b0;
logic [8:0] InstOut;
 
InstROM instRom1(.*);		 // .init(init),.jump_en(jump_en),...
 
//always begin
//  #5ns CLK = 1;
//  #5ns CLK = 0;
//end   

initial begin
  #20ns InstAddress = 8'b00000001;
  #20ns InstAddress = 8'b00000011;
  #20ns InstAddress = 8'b00000010;
  #20ns InstAddress = 8'b00000001;
  #20ns InstAddress = 8'b00000101;
  #20ns  $stop; 
end  
  
endmodule
