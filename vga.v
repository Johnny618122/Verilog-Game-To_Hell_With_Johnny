module vga
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        HEX0,
        HEX1,
        HEX2,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [3:0]   KEY;
	output	[6:0]	HEX0;
	output	[6:0]	HEX1;
	output	[6:0]	HEX2;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]

	wire 	[7:0]	man_x;
	wire 	[6:0]	man_y;
	wire 	[7:0]	board0_x;
	wire 	[6:0]	board0_y;
	wire 	[7:0]	board1_x;
	wire 	[6:0]	board1_y;
	wire 	[7:0]	board2_x;
	wire 	[6:0]	board2_y;
	wire 	[7:0]	board3_x;
	wire 	[6:0]	board3_y;
	
	wire			writeEn;
	assign	writeEn = 1'b1;
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire 	[7:0]	x;
	wire 	[6:0]	y;
	wire 	[2:0]	colour;
	
	wire	[9:0]	score;

	crtl crtl(
		.clk(CLOCK_50),
		.KEY(KEY),
		.score(score),
		.man_x(man_x),
		.man_y(man_y),
		.board0_x(board0_x),
		.board0_y(board0_y),
		.board1_x(board1_x),
		.board1_y(board1_y),
		.board2_x(board2_x),
		.board2_y(board2_y),
		.board3_x(board3_x),
		.board3_y(board3_y)
	);
	
	draw_game draw_game(
		.clk(CLOCK_50),
		.man_x(man_x),
		.man_y(man_y),
		.board0_x(board0_x),
		.board0_y(board0_y),
		.board1_x(board1_x),
		.board1_y(board1_y),
		.board2_x(board2_x),
		.board2_y(board2_y),
		.board3_x(board3_x),
		.board3_y(board3_y),			
		.x(x),
		.y(y),
		.out_colour(colour)
    );

	seg7_decoder seg7_decoder(
		.dat1_i(score%10),
		.dat2_i((score%100)/10),
		.dat3_i(score/100),
		.seg1_o(HEX0),
		.seg2_o(HEX1),
		.seg3_o(HEX2));

	vga_adapter VGA(
		.resetn(1),
		.clock(CLOCK_50),
		.colour(colour),
		.x(x),
		.y(y),
		.plot(writeEn),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK(VGA_BLANK_N),
		.VGA_SYNC(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK));
		
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1; 	

endmodule
