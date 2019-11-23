
module reg_file_tb();

logic write_en = 0,		
	  CLK=0,
         init = 0;
logic[2:0] raddrA = 0,
           raddrB = 0,
           waddr = 1;
logic [7:0] data_in,
  	data_outA,
  	data_outB;
 
reg_file reg_file1(.*);		 // .init(init),.jump_en(jump_en),...
 
always begin
  #5ns CLK = 1;
  #5ns CLK = 0;
end   


initial begin
  #5ns init = 1;
  #10ns init = 0;
	write_en = 1;
	raddrA = 3'b001;  //r1
  	raddrB = 3'b010;  //r2    
	waddr = 3'b001; 
	data_in = 3;
  #10ns raddrA = 3'b001;  //r1
  	raddrB = 3'b011;  //r3    
	waddr = 3'b001; 
	data_in = 6;
  #10ns write_en = 0;
	raddrA = 3'b001;  //r1
  	raddrB = 3'b011;  //r3    
	waddr = 3'b001; 
	data_in = 10;
  #30ns  $stop; 
end  
  
endmodule