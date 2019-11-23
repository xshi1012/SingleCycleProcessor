module LUT3(
    input[4:0] addr,
    output logic[9:0] Target
	);

always_comb 
  case(addr)		   
	5'b00000:   Target =  10'b0000001011; //lut[0] = 11
	5'b00001:   Target =  10'b0000010010; //lut[1] = 18
	5'b00010:   Target =  10'b0010010111; //lut[2] = 151
	5'b00011:   Target =  10'b0010011010; //lut[3] = 154
	5'b00100:   Target =  10'b0010100011; //lut[4] = 163
	5'b00101:   Target =  10'b0010100110; //lut[5] = 166
	5'b00110:   Target =  10'd26; //lut[6] = 26
	5'b00111:   Target =  10'd31; //lut[7] = 31
	5'b01000:   Target =  10'd37; //lut[8] = 37
	5'b01001:   Target =  10'd44; //lut[9] = 44
	5'b01010:   Target =  10'd52; //lut[10] = 52
	5'b01011:   Target =  10'd61; //lut[11] = 61
	5'b01100:   Target =  10'd91; //lut[12] = 91
	5'b01101:   Target =  10'd97; //lut[13] = 97
	5'b01110:   Target =  10'd104; //lut[14] = 104
	5'b01111:   Target =  10'd112; //lut[15] = 112
	5'b10000:   Target =  10'd121; //lut[16] = 121
	5'b10001:   Target =  10'd131; //lut[17] = 131
	5'b10010:   Target =  10'd131; //lut[18] = 131
	5'b10011:   Target =  10'd167; //lut[19] = 167
	5'b10100:   Target =  10'd184; //lut[20] = 184
	5'b10101:   Target =  10'd195; //lut[21] = 195
	5'b10110:   Target =  10'd205; //lut[22] = 205
	default: Target = 10'b0000000000;
  endcase
endmodule
