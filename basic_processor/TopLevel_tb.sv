module TopLevel_tb;	     // Lab 17

// To DUT Inputs
  bit start;
  bit CLK;
  bit dm_reset;
// From DUT Outputs
  wire halt;		   // done flag


// program 1-specific variables
logic[11:1] d1_in[15];       // original messages
logic       p16, p8, p4, p2, p1;  // Hamming block parity bits
logic[15:1] d1_out[15];      //	orig messages w/ parity inserted

// program 2-specific variables
logic[11:1] d2_in[15];           // use to generate ddata
logic[15:1] d2_good[15];         // d2_in w/ parity
logic[ 3:0] flip[15];        // position of corruption bit
logic[ 5:0] flip2[15];
logic[15:0] d2_bad1[15];
logic[15:1] d2_bad[15];      // possibly corrupt messages w/ parity
logic       s16, s8, s4, s2, s1;  // parity generated from data of d_bad
logic[ 3:0] err;             // bitwise XOR of p* and s* as 4-bit vector        
logic[11:1] d2_corr[15];     // recovered and corrected messages

// program 3-specific variables
logic[7:0] ctb,		       // how many bytes hold the pattern?
           cts,		       // how many pattern in the whole string?
	   cto;		       // how many pattern fit inside each byte?
logic      ctp;		       // flags occurrence of patern in a given byte
logic[4:0] pat;            // pattern to search for
logic[255:0] str2; 	       // message string
logic[  7:0] mat_str[32];  // message string parsed into bytes

// Instantiate the Device Under Test (DUT)
  TopLevel DUT (
	.start           , 
	.CLK             , 
	.halt             
	);

//initial begin
 
//  #170ns force DUT.branch_en=1'b1;
//  #10ns  release DUT.branch_en;

//end

initial begin
// program 1
  for(int i=0;i<15;i++)	begin
    d1_in[i] = $random;        // create 15 messages
// copy 15 original messages into first 30 bytes of memory 
// rename "data_memory" and/or "core" if you used different names for these
    DUT.data_memory.core[2*i+1]  = {5'b0,d1_in[i][11:9]};
    DUT.data_memory.core[2*i]    =       d1_in[i][ 8:1];
  end

  // program 3
  pat = $random;
  str2 = 0;
  DUT.data_memory.core[160][7:3] = pat;
  for(int i=0; i<32; i++) begin
    mat_str[i] = $random;
	DUT.data_memory.core[128+i] = mat_str[i];   
	str2 = (str2<<8)+mat_str[i];
  end
  ctb = 0;
  for(int j=0; j<32; j++) begin
    if(pat==mat_str[j][4:0]) ctb++;
    if(pat==mat_str[j][5:1]) ctb++;
    if(pat==mat_str[j][6:2]) ctb++;
    if(pat==mat_str[j][7:3]) ctb++;
  end
  cto = 0;
  for(int j=0; j<32; j++) 
    if((pat==mat_str[j][4:0]) | (pat==mat_str[j][5:1]) |
       (pat==mat_str[j][6:2]) | (pat==mat_str[j][7:3]))  cto ++;
  cts = 0;
  for(int j=0; j<252; j++) begin
    if(pat==str2[255:251]) cts++;
	str2 = str2<<1;
  end

// Initialize DUT's data memory
  #10ns start = 1;
  #10ns start = 0;

  wait(halt);


  // generate parity for each message; display result and that of DUT
  $display("start program 1");
  $display();
  for(int i=0;i<15;i++) begin
    p8 = ^d1_in[i][11:5];
    p4 = (^d1_in[i][11:8])^(^d1_in[i][4:2]); 
    p2 = d1_in[i][11]^d1_in[i][10]^d1_in[i][7]^d1_in[i][6]^d1_in[i][4]^d1_in[i][3]^d1_in[i][1];
    p1 = d1_in[i][11]^d1_in[i][ 9]^d1_in[i][7]^d1_in[i][5]^d1_in[i][4]^d1_in[i][2]^d1_in[i][1];
    p16 = ^d1_in[i]^p8^p4^p2^p1;  // overall parity (16th bit)
    // assemble output (data with parity embedded)
    $displayb ({d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p16});
    $writeb  (DUT.data_memory.core[31+2*i]);
    $displayb(DUT.data_memory.core[30+2*i]);
    if ({d1_in[i][11:5],p8,d1_in[i][4:2],p4,d1_in[i][1],p2,p1,p16} != {DUT.data_memory.core[31+2*i],DUT.data_memory.core[30+2*i]}) begin
        $display("?");    
    end
    $display();
  end


/* Program3 check
  $display();
  $display("start program 3");
  $display();
  $display("ctb = %d %d",ctb,DUT.data_memory.core[192]);
  if(ctb!=DUT.data_memory.core[192]) $display("**** oops!****");
  $display("cto = %d %d",cto,DUT.data_memory.core[193]);
  if(cto!=DUT.data_memory.core[193]) $display("**** oops!****");
  $display("cts = %d %d",cts,DUT.data_memory.core[194]);
  if(cts!=DUT.data_memory.core[194]) $display("**** oops!****");
*/
  #30ns $stop;			   
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end
      
endmodule

