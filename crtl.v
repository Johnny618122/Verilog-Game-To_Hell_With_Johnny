module crtl(
	clk,
	KEY,
	score,
	man_x,
	man_y,
	board0_x,
	board0_y,
	board1_x,
	board1_y,
	board2_x,
	board2_y,
	board3_x,
	board3_y
);
	 
	input			clk;
	input	[3:0]	KEY;
	output 	[9:0]	score;
	output 	[2:0]	man_x;
	output 	[6:0]	man_y;
	output 	[7:0]	board0_x;
	output 	[6:0]	board0_y;
	output 	[7:0]	board1_x;
	output 	[6:0]	board1_y;
	output 	[7:0]	board2_x;
	output 	[6:0]	board2_y;
	output 	[7:0]	board3_x;
	output 	[6:0]	board3_y;

	reg 	[9:0]	score=0;
	reg 	[7:0]	man_x=80;
	reg 	[6:0]	man_y=59;
	reg 	[7:0]	board0_x=80;
	reg 	[6:0]	board0_y=0;
	reg 	[7:0]	board1_x=80;
	reg 	[6:0]	board1_y=32;
	reg 	[7:0]	board2_x=80;
	reg 	[6:0]	board2_y=64;
	reg 	[7:0]	board3_x=80;
	reg 	[6:0]	board3_y=96;

	reg		[2:0]	board_sel	=2;
	reg		[39:0]	cnt_man_x	=0;
	reg		[39:0]	cnt_man_y	=0;
	reg		[39:0]	cnt_board_y	=0;
	
	reg				board_up	=0;
	
	reg				game_over	=1;
	
	reg 	[7:0]	random_man_x=80;
	
	reg		[3:0]	KEY1=0;
	reg		[3:0]	KEY_pos=0;
	
	reg		[39:0]	cnt_score=0;

	//A ratedivider to slow the CLOCK_50 to be the normal score.
	always@(posedge clk)begin
		if(game_over==1)begin
			cnt_score<=0;
			score<=0;
		end
		else if(game_over==0)begin
			if(cnt_score<50000000)begin
				cnt_score<=cnt_score+1;
			end
			else begin
				cnt_score<=0;
				score<=score+1;
			end
		end
	end
	
	//To judge the game is over or not.
	always@(posedge clk)begin
		if(KEY[2]==0)
			game_over<=0;
		else begin
			if(man_y<=2 || man_y>=117)
				game_over<=1;
		end
	end	
	
	//Get a random x.
	always@(posedge clk)begin
		KEY1<=KEY;
		KEY_pos<= (KEY1 && (~KEY));
	end
	
	always@(posedge clk)begin
		if(KEY_pos!=0)
			random_man_x<=40;
		else begin
			if(random_man_x<130)
				random_man_x<=random_man_x+1;
			else
				random_man_x<=30;
		end
	end
	
	
	always@(posedge clk)begin
		//Game is over, then reset y for Johnny.
		if(game_over==1)begin
			man_y<=59;
		end
		//The situation that Johnny is not on boards.
		else if(game_over==0)begin
			if(board_sel==0)begin
				man_y<=board0_y-5;
			end
			else if(board_sel==1)begin
				man_y<=board1_y-5;
			end
			else if(board_sel==2)begin
				man_y<=board2_y-5;
			end
			else if(board_sel==3)begin
				man_y<=board3_y-5;
			end
			//The situation that Johnny is on boards.(A counter to slow the failing).
			else begin
				if(cnt_man_y<3000000)begin
					cnt_man_y<=cnt_man_y+1;
				end
				else begin
					cnt_man_y<=0;
					man_y<=man_y+1;
				end
			end
		end
	end
	
	always@(posedge clk)begin
	//Game is over, then reset x for Johnny.
		if(game_over==1)begin
			man_x<=80;
		end
		else if(game_over==0)begin
		//Move Johnny to right.(A counter to slow the movement).
			if(KEY[0]==0)begin
				if(cnt_man_x<1000000)begin
					cnt_man_x<=cnt_man_x+1;
				end
				else begin
					cnt_man_x<=0;
					if(man_x<147)
						man_x<=man_x+1;
					else
						man_x<=147;
				end
			end
		//Move Johnny to left.(A counter to slow the movement).
			else if(KEY[1]==0)begin
				if(cnt_man_x<1000000)begin
					cnt_man_x<=cnt_man_x+1;
				end
				else begin
					cnt_man_x<=0;
					if(man_x>13)
						man_x<=man_x-1;
					else
						man_x<=13;
				end
			end
		end
	end
	//Move the board up.
	always@(posedge clk)begin
		if(cnt_board_y<5000000)begin
			cnt_board_y<=cnt_board_y+1;
			board_up<=0;
		end
		else begin
			cnt_board_y<=0;
			board_up<=1;
		end
	end
	
	
	always@(posedge clk)begin
	//Reset the board position.
		if(game_over==1)begin
			board0_y<=0;
			board1_y<=32;
			board2_y<=64;
			board3_y<=96;
		end
		else if(board_up==1 && game_over==0)begin
			board0_y<=board0_y-1;
			board1_y<=board1_y-1;
			board2_y<=board2_y-1;
			board3_y<=board3_y-1;
		end
	end

	always@(posedge clk)begin
	//Reset the board position.
		if(game_over==1)begin
			board0_x<=80;
		end
	//Get the random x as the board0_x when board0 touches the top.
		else if(board0_y==0)begin
			board0_x<=random_man_x;
		end
		else begin
			board0_x<=board0_x;
		end			
	end

	always@(posedge clk)begin
		if(game_over==1)begin
			board1_x<=80;
		end
		else if(board1_y==0)begin
			board1_x<=random_man_x;
		end
		else begin
			board1_x<=board1_x;
		end			
	end

	always@(posedge clk)begin
		if(game_over==1)begin
			board2_x<=80;
		end
		else if(board2_y==0)begin
			board2_x<=random_man_x;
		end
		else begin
			board2_x<=board2_x;
		end			
	end	
	
	always@(posedge clk)begin
		if(game_over==1)begin
			board3_x<=80;
		end
		else if(board3_y==0)begin
			board3_x<=random_man_x;
		end
		else begin
			board3_x<=board3_x;
		end			
	end	
	
	always@(posedge clk)begin
		if(game_over==1)begin
			board_sel<=2;
		end
		else if(game_over==0)begin
			case(board_sel)
			0:begin
				if(man_x<board0_x-23 || man_x>board0_x+23)
					board_sel<=4;
			end
			1:begin
				if(man_x<board1_x-23 || man_x>board1_x+23)
					board_sel<=4;		
			end
			2:begin
				if(man_x<board2_x-23 || man_x>board2_x+23)
					board_sel<=4;		
			end
			3:begin
				if(man_x<board3_x-23 || man_x>board3_x+23)
					board_sel<=4;		
			end
			default:begin
				if((man_x>=board0_x-23 && man_x<=board0_x+23)&& man_y==board0_y-5)
					board_sel<=0;
				else if((man_x>=board1_x-23 && man_x<=board1_x+23)&& man_y==board1_y-5)
					board_sel<=1;
				else if((man_x>=board2_x-23 && man_x<=board2_x+23)&& man_y==board2_y-5)
					board_sel<=2;
				else if((man_x>=board3_x-23 && man_x<=board3_x+23)&& man_y==board3_y-5)
					board_sel<=3;
				else
					board_sel<=4;
			end
			endcase
		end	
	end	
	 
endmodule
