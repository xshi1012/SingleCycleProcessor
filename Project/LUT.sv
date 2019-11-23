module LUT(
    input[4:0] addr,
    output logic[9:0] Target
	);

always_comb 
  case(addr)		   
	5'b00000:   Target =  10'd11; //lut[0] = 11

	5'b00001:   Target =  10'd179; //lut[1] = 179
	5'b00010:   Target =  10'd314;
	5'b00011:   Target =  10'd318; 
	5'b00100:   Target =  10'd341; 
	5'b00101:   Target =  10'd337;
 
	5'b00110:   Target =  10'd403; //lut[6] = 392
	5'b00111:   Target =  10'd408; //lut[7] = 397
	5'b01000:   Target =  10'd414; //lut[8] = 403
	5'b01001:   Target =  10'd421; //lut[9] = 410
	5'b01010:   Target =  10'd429; //lut[10] = 418
	5'b01011:   Target =  10'd438; //lut[11] = 427
	5'b01100:   Target =  10'd468; //lut[12] = 457
	5'b01101:   Target =  10'd474; //lut[13] = 463
	5'b01110:   Target =  10'd481; //lut[14] = 470
	5'b01111:   Target =  10'd498; //lut[15] = 478
	5'b10000:   Target =  10'd508; //lut[16] = 487
	5'b10001:   Target =  10'd508; //lut[17] = 497
	5'b10010:   Target =  10'd508; //lut[18] = 497
	5'b10011:   Target =  10'd544; //lut[19] = 520
	5'b10100:   Target =  10'd561; //lut[20] = 524
	5'b10101:   Target =  10'd572; //lut[21] = 529
	5'b10110:   Target =  10'd582; //lut[22] = 534


	5'b11110:   Target =  10'd322; 
	5'b11111:   Target =  10'd345;

	default: Target = 10'b0000000000;
  endcase
endmodule
