module InstROM #(parameter A=10, W=9) (
  input       [A-1:0] InstAddress,
  output logic[W-1:0] InstOut);
	 
  logic[W-1:0] inst_rom[2**(A)];
  always_comb InstOut = inst_rom[InstAddress];
 
  initial begin
  	$readmemb("machine_code.txt",inst_rom);
  end 
  
endmodule
