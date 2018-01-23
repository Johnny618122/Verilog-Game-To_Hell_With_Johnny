module seg7_decoder(
	dat1_i,
	dat2_i,
	dat3_i,
	seg1_o,
	seg2_o,
	seg3_o); 

	input	[3:0]	dat1_i;				
	input	[3:0]	dat2_i;				
	input	[3:0]	dat3_i;				
	
	output	[6:0]	seg1_o;						
	output	[6:0]	seg2_o;				
	output	[6:0]	seg3_o;				
							
	reg		[6:0]	seg1_o;				
	reg		[6:0]	seg2_o;				
	reg		[6:0]	seg3_o;				
	
	always @(*)begin
		case(dat1_i)		
	
			4'h0:seg1_o=7'b1000000;	
			4'h1:seg1_o=7'b1111001;	
			4'h2:seg1_o=7'b0100100;	
			4'h3:seg1_o=7'b0110000;	
			4'h4:seg1_o=7'b0011001;	
			4'h5:seg1_o=7'b0010010;	
			4'h6:seg1_o=7'b0000010;	
			4'h7:seg1_o=7'b1111000;	
			4'h8:seg1_o=7'b0000000;	
			4'h9:seg1_o=7'b0011000;			
			4'ha:seg1_o=7'b0001000;	
			4'hb:seg1_o=7'b0000011;	
			4'hc:seg1_o=7'b1000110;	
			4'hd:seg1_o=7'b0100001;	
			4'he:seg1_o=7'b0000110;
			4'hf:seg1_o=7'b0001110;	
			default:seg1_o=7'b1111111;
		endcase
	end

	always @(*)begin
		case(dat2_i)				
			4'h0:seg2_o=7'b1000000;	
			4'h1:seg2_o=7'b1111001;	
			4'h2:seg2_o=7'b0100100;	
			4'h3:seg2_o=7'b0110000;	
			4'h4:seg2_o=7'b0011001;	
			4'h5:seg2_o=7'b0010010;	
			4'h6:seg2_o=7'b0000010;	
			4'h7:seg2_o=7'b1111000;
			4'h8:seg2_o=7'b0000000;	
			4'h9:seg2_o=7'b0011000;		
			4'ha:seg2_o=7'b0001000;	
			4'hb:seg2_o=7'b0000011;	
			4'hc:seg2_o=7'b1000110;	
			4'hd:seg2_o=7'b0100001;	
			4'he:seg2_o=7'b0000110;	
			4'hf:seg2_o=7'b0001110;	
			default:seg2_o=7'b1111111;
		endcase
	end

	always @(*)begin
		case(dat3_i)					
			4'h0:seg3_o=7'b1000000;	
			4'h1:seg3_o=7'b1111001;
			4'h2:seg3_o=7'b0100100;	
			4'h3:seg3_o=7'b0110000;	
			4'h4:seg3_o=7'b0011001;	
			4'h5:seg3_o=7'b0010010;
			4'h6:seg3_o=7'b0000010;	
			4'h7:seg3_o=7'b1111000;	
			4'h8:seg3_o=7'b0000000;	
			4'h9:seg3_o=7'b0011000;	
			4'ha:seg3_o=7'b0001000;	
			4'hb:seg3_o=7'b0000011;	
			4'hc:seg3_o=7'b1000110;	
			4'hd:seg3_o=7'b0100001;	
			4'he:seg3_o=7'b0000110;	
			4'hf:seg3_o=7'b0001110;
			default:seg3_o=7'b1111111;
		endcase
	end

	
endmodule
