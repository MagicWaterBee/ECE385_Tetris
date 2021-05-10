module total_dynamic (	input [2:0] Color_O_Block,
								input	En_O,
								input [2:0] State_O,
								input [3:0][4:0] New_Static_Row_O,
								input [3:0][3:0] New_Static_Column_O,
								
								input [2:0] Color_T_Block,
								input	En_T, 
								input [2:0] State_T,
								input [3:0][4:0] New_Static_Row_T,
								input [3:0][3:0] New_Static_Column_T,
								
								
								input [2:0] Color_I_Block,
								input	En_I,
								input [2:0] State_I,
								input [3:0][4:0] New_Static_Row_I,
								input [3:0][3:0] New_Static_Column_I,

								
								input [2:0] Color_RF_Block,
								input	En_RF,
								input [2:0] State_RF,
								input [3:0][4:0] New_Static_Row_RF,
								input [3:0][3:0] New_Static_Column_RF,

																
								input [2:0] Color_RL_Block,
								input	En_RL,
								input [2:0] State_RL,
								input [3:0][4:0] New_Static_Row_RL,
								input [3:0][3:0] New_Static_Column_RL,

								
								input [2:0] Color_LF_Block,
								input	En_LF,
								input [2:0] State_LF,
								input [3:0][4:0] New_Static_Row_LF,
								input [3:0][3:0] New_Static_Column_LF,
								
								
								input [2:0] Color_LL_Block,
								input	En_LL,
								input [2:0] State_LL,
								input [3:0][4:0] New_Static_Row_LL,
								input [3:0][3:0] New_Static_Column_LL,
								
								output En_New_Static,
								output [2:0] Game_State,
								output [2:0] Color_Dynamic,
								output [3:0][4:0] New_Static_Row,
								output [3:0][3:0] New_Static_Column,
								output [2:0] New_Static_Color
	);
	
	
	assign En_New_Static = En_O | En_T | En_I | En_RF | En_RL | En_LF | En_LL;
	
	assign Game_State[2] = State_O[2] | State_T[2] | State_RL[2] | State_RF[2] | State_LL[2] | State_LF[2] | State_I[2];
	assign Game_State[1] = State_O[1] | State_T[1] | State_RL[1] | State_RF[1] | State_LL[1] | State_LF[1] | State_I[1];
	assign Game_State[0] = (~Game_State[2]) && (~Game_State[1]);
	
	always_comb
	begin
		if (En_O)
		begin 
			Color_Dynamic = Color_O_Block;
			New_Static_Color = 3'b001;
			New_Static_Row[0] = New_Static_Row_O[0];
			New_Static_Row[1] = New_Static_Row_O[1];
			New_Static_Row[2] = New_Static_Row_O[2];
			New_Static_Row[3] = New_Static_Row_O[3];
			New_Static_Column[0] = New_Static_Column_O[0];
			New_Static_Column[1] = New_Static_Column_O[1];
			New_Static_Column[2] = New_Static_Column_O[2];
			New_Static_Column[3] = New_Static_Column_O[3];
		end
		
		else if (En_T)
		begin
			Color_Dynamic = Color_T_Block;
			New_Static_Color = 3'b010;
			New_Static_Row[0] = New_Static_Row_T[0];
			New_Static_Row[1] = New_Static_Row_T[1];
			New_Static_Row[2] = New_Static_Row_T[2];
			New_Static_Row[3] = New_Static_Row_T[3];
			New_Static_Column[0] = New_Static_Column_T[0];
			New_Static_Column[1] = New_Static_Column_T[1];
			New_Static_Column[2] = New_Static_Column_T[2];
			New_Static_Column[3] = New_Static_Column_T[3];
		end
		
		else if (En_I)
		begin
			Color_Dynamic = Color_I_Block;
			New_Static_Color = 3'b011;
			New_Static_Row[0] = New_Static_Row_I[0];
			New_Static_Row[1] = New_Static_Row_I[1];
			New_Static_Row[2] = New_Static_Row_I[2];
			New_Static_Row[3] = New_Static_Row_I[3];
			New_Static_Column[0] = New_Static_Column_I[0];
			New_Static_Column[1] = New_Static_Column_I[1];
			New_Static_Column[2] = New_Static_Column_I[2];
			New_Static_Column[3] = New_Static_Column_I[3];
		end
		
		else if (En_LL)
		begin
			Color_Dynamic = Color_LL_Block;
			New_Static_Color = 3'b101;
			New_Static_Row[0] = New_Static_Row_LL[0];
			New_Static_Row[1] = New_Static_Row_LL[1];
			New_Static_Row[2] = New_Static_Row_LL[2];
			New_Static_Row[3] = New_Static_Row_LL[3];
			New_Static_Column[0] = New_Static_Column_LL[0];
			New_Static_Column[1] = New_Static_Column_LL[1];
			New_Static_Column[2] = New_Static_Column_LL[2];
			New_Static_Column[3] = New_Static_Column_LL[3];
		end
		
		else if (En_RL)
		begin
			Color_Dynamic = Color_T_Block;
			New_Static_Color = 3'b101;
			New_Static_Row[0] = New_Static_Row_RL[0];
			New_Static_Row[1] = New_Static_Row_RL[1];
			New_Static_Row[2] = New_Static_Row_RL[2];
			New_Static_Row[3] = New_Static_Row_RL[3];
			New_Static_Column[0] = New_Static_Column_RL[0];
			New_Static_Column[1] = New_Static_Column_RL[1];
			New_Static_Column[2] = New_Static_Column_RL[2];
			New_Static_Column[3] = New_Static_Column_RL[3];
		end
		
		else if (En_LF)
		begin
			Color_Dynamic = Color_T_Block;
			New_Static_Color = 3'b110;
			New_Static_Row[0] = New_Static_Row_LF[0];
			New_Static_Row[1] = New_Static_Row_LF[1];
			New_Static_Row[2] = New_Static_Row_LF[2];
			New_Static_Row[3] = New_Static_Row_LF[3];
			New_Static_Column[0] = New_Static_Column_LF[0];
			New_Static_Column[1] = New_Static_Column_LF[1];
			New_Static_Column[2] = New_Static_Column_LF[2];
			New_Static_Column[3] = New_Static_Column_LF[3];
		end
		
		else if (En_RF)
		begin
			Color_Dynamic = Color_T_Block;
			New_Static_Color = 3'b110;
			New_Static_Row[0] = New_Static_Row_RF[0];
			New_Static_Row[1] = New_Static_Row_RF[1];
			New_Static_Row[2] = New_Static_Row_RF[2];
			New_Static_Row[3] = New_Static_Row_RF[3];
			New_Static_Column[0] = New_Static_Column_RF[0];
			New_Static_Column[1] = New_Static_Column_RF[1];
			New_Static_Column[2] = New_Static_Column_RF[2];
			New_Static_Column[3] = New_Static_Column_RF[3];
		end
		
		else
		begin
			Color_Dynamic = Color_O_Block+Color_T_Block+Color_I_Block+Color_LL_Block+Color_RL_Block+Color_LF_Block+Color_RF_Block;
			New_Static_Color = 3'b000;
			New_Static_Row[0] = 5'd0;
			New_Static_Row[1] = 5'd0;
			New_Static_Row[2] = 5'd0;
			New_Static_Row[3] = 5'd0;
			New_Static_Column[0] = 4'd0;
			New_Static_Column[1] = 4'd0;
			New_Static_Column[2] = 4'd0;
			New_Static_Column[3] = 4'd0;
		end
	end
	
endmodule
