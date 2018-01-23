module draw_game(
	clk,
	man_x,
	man_y,
	board0_x,
	board0_y,
	board1_x,
	board1_y,
	board2_x,
	board2_y,
	board3_x,
	board3_y,			
	x,
	y,
	out_colour
    );
	 
	input			clk;
	input 	[7:0]	man_x;
	input 	[6:0]	man_y;
	input 	[7:0]	board0_x;
	input 	[6:0]	board0_y;
	input 	[7:0]	board1_x;
	input 	[6:0]	board1_y;
	input 	[7:0]	board2_x;
	input 	[6:0]	board2_y;
	input 	[7:0]	board3_x;
	input 	[6:0]	board3_y;
			
	output	[7:0]	x;
	output	[6:0]	y;
	output	[2:0]	out_colour;

	reg		[7:0]	x=0;
	reg		[6:0]	y=0;
	reg		[2:0]	out_colour=0;
	
	//a counter which is used to get each x and y on the screen.
	always@(posedge clk)begin
		if(x<159)begin
			x<=x+1;
		end
		else begin
			x<=0;
			if(y<119)begin
				y<=y+1;
			end
			else begin
				y<=0;
			end
		end
	end
	
	//give each colour for each x,y on the screen (man, board and background).
	always@(posedge clk)begin
		if(x==10 || x==150)
			out_colour<=3'b111;
		else if(x>=man_x-2 && x<=man_x+2 && y>=man_y-2 && y<=man_y+2)
			out_colour<=3'b111;
		else if(x>=board0_x-20 && x<=board0_x+20 && y>=board0_y-2 && y<=board0_y+2)
			out_colour<=3'b100;
		else if(x>=board1_x-20 && x<=board1_x+20 && y>=board1_y-2 && y<=board1_y+2)
			out_colour<=3'b010;	
		else if(x>=board2_x-20 && x<=board2_x+20 && y>=board2_y-2 && y<=board2_y+2)
			out_colour<=3'b001;	
		else if(x>=board3_x-20 && x<=board3_x+20 && y>=board3_y-2 && y<=board3_y+2)
			out_colour<=3'b110;	
		else
			out_colour<=3'b000;	
	end
	 
endmodule
