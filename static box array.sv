module static_box_array ( input Reset,
								  		  Clk,
								  		  frame_clk,
										  Active,
								  input En_New_Static,
								  input [3:0][4:0] New_Static_Row,
								  input [3:0][3:0] New_Static_Column,
								  input [2:0] New_Static_Color,
								  input [9:0] DrawX, DrawY,
								  output [2:0] Color_Static,
								  output [23:0][9:0] Static_Array,
								  output [6:0] Fall_Count,
								  output [5:0] Line_Count, 
								  output [6:0] Score,
								  output Win, Lose
	);
	
	enum logic [2:0] {Halted, Falling, Touchdown}	State, Next_State;

	logic [23:0][9:0][2:0]	Color_Array;
	logic [9:0][9:0]	Box_X_Center;
	logic [23:0][9:0]	Box_Y_Center;
	logic [23:0][5:0] Line_Counter;
	logic [5:0] Line_Count_delayed;
	
//	parameter [9:0]	Box_size = 10'd10;
//	parameter [9:0]	Box_Y_Max = 10'd450;
//	parameter [9:0]	Box_Y_Min = 10'd31;
//	parameter [9:0]	Box_X_Max = 10'd424;
//	parameter [9:0]	Box_X_Min = 10'd215;

	assign Box_X_Center[0] = 10'd225;
	assign Box_X_Center[1] = 10'd246;
	assign Box_X_Center[2] = 10'd267;
	assign Box_X_Center[3] = 10'd288;
	assign Box_X_Center[4] = 10'd309;
	assign Box_X_Center[5] = 10'd330;
	assign Box_X_Center[6] = 10'd351;
	assign Box_X_Center[7] = 10'd372;
	assign Box_X_Center[8] = 10'd393;
	assign Box_X_Center[9] = 10'd414;
	
	assign Box_Y_Center[4] = 10'd41;
	assign Box_Y_Center[5] = 10'd62;
	assign Box_Y_Center[6] = 10'd83;
	assign Box_Y_Center[7] = 10'd104;
	assign Box_Y_Center[8] = 10'd125;
	assign Box_Y_Center[9] = 10'd146;
	assign Box_Y_Center[10] = 10'd167;
	assign Box_Y_Center[11] = 10'd188;
	assign Box_Y_Center[12] = 10'd209;
	assign Box_Y_Center[13] = 10'd230;
	assign Box_Y_Center[14] = 10'd251;
	assign Box_Y_Center[15] = 10'd272;
	assign Box_Y_Center[16] = 10'd293;
	assign Box_Y_Center[17] = 10'd314;
	assign Box_Y_Center[18] = 10'd335;
	assign Box_Y_Center[19] = 10'd356;
	assign Box_Y_Center[20] = 10'd377;
	assign Box_Y_Center[21] = 10'd398;
	assign Box_Y_Center[22] = 10'd419;
	assign Box_Y_Center[23] = 10'd440;
	
	assign Line_Count = Line_Counter[0]+Line_Counter[1]+Line_Counter[2]+Line_Counter[3]+Line_Counter[4]+Line_Counter[5]+Line_Counter[6]+Line_Counter[7]+Line_Counter[8]+Line_Counter[9]+Line_Counter[10]+Line_Counter[11]+Line_Counter[12]+Line_Counter[13]+Line_Counter[14]+Line_Counter[15]+Line_Counter[16]+Line_Counter[17]+Line_Counter[18]+Line_Counter[19]+Line_Counter[20]+Line_Counter[21]+Line_Counter[22]+Line_Counter[23];
	
	logic frame_clk_delayed, frame_clk_rising_edge;
	always_ff @ (posedge Clk)
	begin
		frame_clk_delayed <= frame_clk;
		frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
	end
	
	always_ff @ (posedge Clk)
	begin
		if (Reset)
		begin
			for (int i=0; i<24; i++)
			begin
				Color_Array[i][9] <= 3'b000;
				Color_Array[i][8] <= 3'b000;
				Color_Array[i][7] <= 3'b000;
				Color_Array[i][6] <= 3'b000;
				Color_Array[i][5] <= 3'b000;
				Color_Array[i][4] <= 3'b000;
				Color_Array[i][3] <= 3'b000;
				Color_Array[i][2] <= 3'b000;
				Color_Array[i][1] <= 3'b000;
				Color_Array[i][0] <= 3'b000;
				Static_Array[i] <= 10'b0;
				Line_Counter[i] <= 6'd0;
			end
			Fall_Count <= 7'd0;
			Score <= 7'd0;
		end
		else if (En_New_Static == 1'b1)
		begin
			Color_Array[New_Static_Row[0]][New_Static_Column[0]] <= New_Static_Color;
			Color_Array[New_Static_Row[1]][New_Static_Column[1]] <= New_Static_Color;
			Color_Array[New_Static_Row[2]][New_Static_Column[2]] <= New_Static_Color;
			Color_Array[New_Static_Row[3]][New_Static_Column[3]] <= New_Static_Color;
			Static_Array[New_Static_Row[0]][New_Static_Column[0]] <= 1'b1;
			Static_Array[New_Static_Row[1]][New_Static_Column[1]] <= 1'b1;
			Static_Array[New_Static_Row[2]][New_Static_Column[2]] <= 1'b1;
			Static_Array[New_Static_Row[3]][New_Static_Column[3]] <= 1'b1;
			Fall_Count <= Fall_Count+7'd1;
		end

		for (int k=23; k>0; k--)
		begin
			if ((Static_Array[k]==10'b0) && (Static_Array[k-1]!=10'b0))
			begin
				Static_Array[k] <= Static_Array[k-1];
				Static_Array[k-1] <= 10'b0;
				Color_Array[k][9] <= Color_Array[k-1][9];
				Color_Array[k][8] <= Color_Array[k-1][8];
				Color_Array[k][7] <= Color_Array[k-1][7];
				Color_Array[k][6] <= Color_Array[k-1][6];
				Color_Array[k][5] <= Color_Array[k-1][5];
				Color_Array[k][4] <= Color_Array[k-1][4];
				Color_Array[k][3] <= Color_Array[k-1][3];
				Color_Array[k][2] <= Color_Array[k-1][2];
				Color_Array[k][1] <= Color_Array[k-1][1];
				Color_Array[k][0] <= Color_Array[k-1][0];
				Color_Array[k-1][9] <= 3'b000;
				Color_Array[k-1][8] <= 3'b000;
				Color_Array[k-1][7] <= 3'b000;
				Color_Array[k-1][6] <= 3'b000;
				Color_Array[k-1][5] <= 3'b000;
				Color_Array[k-1][4] <= 3'b000;
				Color_Array[k-1][3] <= 3'b000;
				Color_Array[k-1][2] <= 3'b000;
				Color_Array[k-1][1] <= 3'b000;
				Color_Array[k-1][0] <= 3'b000;
			end
		end
		
		if (frame_clk_rising_edge)
		begin
			Line_Count_delayed <= Line_Count;
			if (Line_Count == Line_Count_delayed+6'd1)
				Score <= Score+7'd1;
			else if (Line_Count == Line_Count_delayed+6'd2)
				Score <= Score+7'd3;
			else if (Line_Count == Line_Count_delayed+6'd3)
				Score <= Score+7'd6;
			else if (Line_Count == Line_Count_delayed+6'd4)
				Score <= Score+7'd10;
				
			for (int i=23; i>3; i--)
			begin
				if ((Static_Array[i]==10'b0) && (Static_Array[i][0]==3'b111))
				begin
					Static_Array[i] <= 10'b0;
					Color_Array[i][9] <= 3'b0;
					Color_Array[i][8] <= 3'b0;
					Color_Array[i][7] <= 3'b0;
					Color_Array[i][6] <= 3'b0;
					Color_Array[i][5] <= 3'b0;
					Color_Array[i][4] <= 3'b0;
					Color_Array[i][3] <= 3'b0;
					Color_Array[i][2] <= 3'b0;
					Color_Array[i][1] <= 3'b0;
					Color_Array[i][0] <= 3'b0;
				end
			
				else if (Color_Array[i][0] == 3'b111 && Static_Array[i]==10'b1111111111)
				begin
					Static_Array[i] <= 10'b0;
					Line_Counter[i] <= Line_Counter[i]+6'd1;
				end
				
				else if (Static_Array[i]==10'b1111111111)
				begin
					Color_Array[i][9] <= 3'b111;
					Color_Array[i][8] <= 3'b111;
					Color_Array[i][7] <= 3'b111;
					Color_Array[i][6] <= 3'b111;
					Color_Array[i][5] <= 3'b111;
					Color_Array[i][4] <= 3'b111;
					Color_Array[i][3] <= 3'b111;
					Color_Array[i][2] <= 3'b111;
					Color_Array[i][1] <= 3'b111;
					Color_Array[i][0] <= 3'b111;
				end
			end
		end
	end

	int Row,Column;
	assign Row = (DrawY-10'd31)/10'd21+10'd4;
	assign Column = (DrawX-10'd215)/10'd21;
	
   int DistX, DistY, Size;
   assign DistX = DrawX - Box_X_Center[Column];
   assign DistY = DrawY - Box_Y_Center[Row];
   assign Size = 10'd9;
   always_comb
	begin
       if ( (DistX*DistX<=Size*Size) && (DistY*DistY<=Size*Size) )
           Color_Static = Color_Array[Row][Column];
		 
       else
           Color_Static = 3'b000;
       /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
          the single line is quite powerful descriptively, it causes the synthesis tool to use up three
          of the 12 available multipliers on the chip! */
			 
		if (Static_Array[3] != 10'b0)
		begin
			Win = 1'b0;
			Lose = 1'b1;
		end
		else if (Line_Count >= 6'd36)
		begin
			Win = 1'b1;
			Lose = 1'b0;
		end
		else
		begin
			Win = 1'b0;
			Lose = 1'b0;
		end
   end
	
//	always_comb
//	begin
//		if (Row>=10'd4 && Row<=10'd23 && Column>=10'd0 && Column<=10'd9)
//			Color_Static = Color_Array[Row][Column];
//		else
//			Color_Static = 3'b000;		
//	end
		
endmodule
