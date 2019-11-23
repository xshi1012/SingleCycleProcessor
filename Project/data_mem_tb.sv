module data_mem_tb();

 logic              CLK = 0,
                reset = 0;	// optional; permits initialization
  logic [7:0]        DataAddress;	// pointer for both read and write
  logic              ReadMem = 0,		// optional read enable
              WriteMem = 0;	// required write (store) enable
  logic [7:0]        DataIn;
  logic[7:0]  DataOut;
 
data_mem data_mem1(.*);		 // .init(init),.jump_en(jump_en),...


always begin
  #5ns CLK = 1;
  #5ns CLK = 0;
end   


initial begin
  #5ns reset = 1;
  #10ns reset = 0;
	WriteMem = 1;
	DataAddress = 8'b00001111;  //15
  	DataIn = 8'b00000011;  //3
  #10ns WriteMem = 0;
  #10ns WriteMem = 1;
	DataAddress = 8'b00100000;  //32
  	DataIn = 8'b00000111;  //7
  #10ns WriteMem = 0;
  #10ns ReadMem = 1;
	DataAddress = 8'b00100000;  //32
  	DataIn = 8'b00000111;  //7
  #10ns ReadMem = 0;
  #10ns ReadMem = 1;
	DataAddress = 8'b00000000;  //32
  	DataIn = 8'b00000111;  //7
  #10ns ReadMem = 0;
  #30ns  $stop; 
end  
  
endmodule