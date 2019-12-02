// CSE141L  Fall 2019
// test bench for programs 1, 2, and 3
module prog123_tb();

logic clk   = 0,                 // clock source -- drives DUT input of same name
      reset = 1,	             // master reset -- drives DUT input of same name
	  req   = 0;	             // req -- start next program -- drives DUT input
wire  ack;		    	         // ack -- from DUT -- done w/ program

// program 1-specific variables
logic[11:1] d1_in[15];           // original messages
logic      p16, p8, p4, p2, p1;  // Hamming block parity bits
logic[15:0] d1_out[15];          // orig messages w/ parity inserted

// program 2-specific variables
logic[11:1] d2_in[15];           // use to generate data
logic[15:0] d2_good[15];         // d2_in w/ parity
logic[ 3:0] flip[15];            // position of first corruption bit
logic[ 5:0] flip2[15];           // position of possible second corruption bit
logic[15:0] d2_bad1[15];         // possibly corrupt message w/ parity
logic[15:0] d2_bad[15];          // possibly corrupt messages w/ parity
logic       s16, s8, s4, s2, s1; // parity generated from data of d_bad
logic[ 3:0] err;                 // bitwise XOR of p* and s* as 4-bit vector        
logic[11:1] d2_corr[15];         // recovered and corrected messages

// program 3-specific variables
logic[  7:0] cto,		       // how many bytes hold the pattern? (32 max)
             cts,		       // how many patterns in the whole string? (253 max)
		     ctb;		       // how many patterns fit inside any byte? (160 max)
logic        ctp;		       // flags occurrence of patern in a given byte
logic[  4:0] pat;              // pattern to search for
logic[255:0] str2; 	           // message string
logic[  7:0] mat_str[32];      // message string parsed into bytes

// your device goes here
// explicitly list ports if your names differ from test bench's
prog DUT(.*);	               // replace "proc" with the name of your top level module

initial begin
// program 1
  for(int i=0;i<15;i++)	begin
    d1_in[i] = $random;        // create 15 messages
// copy 15 original messages into first 30 bytes of memory 
// rename "dm1" and/or "core" if you used different names for these
    DUT.dm1.core[2*i+1]  = {5'b0,d1_in[i][11:9]};
    DUT.dm1.core[2*i]    =       d1_in[i][ 8:1];
  end
  #10ns reset = 1'b0;
  #10ns req   = 1'b1;          // pulse request to DUT
  #10ns req   = 1'b0;
  wait(ack);                   // wait for ack from DUT
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
    $writeb  (DUT.dm1.core[31+2*i]);
    $displayb(DUT.dm1.core[30+2*i]);
    $display();
  end

// program 2
// generate parity from random 11-bit messages 
  for(int i=0; i<15; i++) begin
	d2_in[i] = $random;
    p8 = ^d2_in[i][11:5];
    p4 = (^d2_in[i][11:8])^(^d2_in[i][4:2]); 
    p2 = d2_in[i][11]^d2_in[i][10]^d2_in[i][7]^d2_in[i][6]^d2_in[i][4]^d2_in[i][3]^d2_in[i][1];
    p1 = d2_in[i][11]^d2_in[i][ 9]^d2_in[i][7]^d2_in[i][5]^d2_in[i][4]^d2_in[i][2]^d2_in[i][1];
    p16 = ^d2_in[i]^p8^p4^p2^p1;
    d2_good[i] = {d2_in[i][11:5],p8,d2_in[i][4:2],p4,d2_in[i][1],p2,p1,p16};
// flip one bit
    flip[i] = $random;
    d2_bad1[i] = d2_good[i] ^ (1'b1<<flip[i]);
// flip second bit about 25% of the time (flip2<16)
    flip2[i] = $random;
	d2_bad[i] = d2_bad1[i] ^ (1'b1<<flip2[i]);
	DUT.dm1.core[65+2*i] = {d2_bad[i][15:8]};
    DUT.dm1.core[64+2*i] = {d2_bad[i][ 7:0]};
  end
  #10ns req   = 1;
  #10ns req   = 0;
  wait(ack);
  $display();
  $display("start program 2");
  $display();
  for(int i=0; i<15; i++) begin
    $displayb({5'b0,d2_in[i]});
    $writeb  (DUT.dm1.core[95+2*i]);
    $displayb(DUT.dm1.core[94+2*i]);
    if((flip2[i][5:4]==0)&&(flip2[i][3:0]!=flip[i])) begin
	  $display("double error injected here");
	  if((DUT.dm1.core[95+2*i][7]==1'b0) || (DUT.dm1.core[95+2*i][7]===1'bx))
        $display("missed the double error");
    end
                    
    else if({5'b0,d2_in[i]}=={DUT.dm1.core[95+2*i],DUT.dm1.core[94+2*i]})
	  $display("we have a match!");
	else
      $display("erroneous output");
	$displayb(flip2[i],,flip[i]);
	$displayb({5'b0,d1_in[i]},,{DUT.dm1.core[95+2*i],DUT.dm1.core[94+2*i]});
	$display();
  end

// program 3
// pattern we are looking for; experiment w/ various values
  pat = 5'b0000;//5'b10101;//$random;
  str2 = 0;
  DUT.dm1.core[160][7:3] = pat;
  for(int i=0; i<32; i++) begin
// search field; experiment w/ various vales
    mat_str[i] = 8'b00000000;//8'b01010101;// $random;
	DUT.dm1.core[128+i] = mat_str[i];   
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
       (pat==mat_str[j][6:2]) | (pat==mat_str[j][7:3])) cto ++;
  cts = 0;
  for(int j=0; j<252; j++) begin
    if(pat==str2[255:251]) cts++;
	str2 = str2<<1;
  end        	    
  #10ns req   = 1'b1;      // pulse request to DUT
  #10ns req   = 1'b0;
  wait(ack);               // wait for ack from DUT
  $display();
  $display("start program 3");
  $display();
  $display("number of patterns w/o byte crossing    = %d %d",ctb,DUT.dm1.core[192]);   //160 max
  $display("number of bytes w/ at least one pattern = %d %d",cto,DUT.dm1.core[193]);   // 32 max
  $display("number of patterns w/ byte crossing     = %d %d",cts,DUT.dm1.core[194]);   //253 max
  #10ns $stop;
end

always begin
  #5ns clk = 1;            // tic
  #5ns clk = 0;			   // toc
end										

endmodule
										   