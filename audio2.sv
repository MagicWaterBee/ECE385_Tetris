module audio ( input logic Clk, Reset, 
				  input logic INIT,
				  input logic data_over,
				  output logic INIT_FINISH,
				  output [15:0] Add
);

logic [3:0] counter;
logic [3:0] inner_counter;
enum logic {WAIT,RUN} current_state, next_state;
logic [15:0] inner_Add;


always_ff @ (posedge Clk)
	begin
		if (Reset)
		begin
			current_state <= WAIT;
			counter <= 4'd0;
			Add <= 16'd0;
		end
		else
		begin
			current_state <= next_state;
			counter <= inner_counter;
			Add <= inner_Add;
		end
	end
		
always_comb
	begin
		unique case(current_state)
			WAIT:
				begin
					if (INIT == 4'd01)
						begin
							next_state = RUN;
							INIT_FINISH = 4'd00;
						end
					else
						begin
							next_state = WAIT;
							INIT_FINISH = 4'd00;
						end
						
					inner_counter = 4'd0;
					inner_Add = 16'd0;
				end
			RUN:
			begin 
				next_state = RUN;
				INIT_FINISH = 4'd01;
				
				if (counter<4'd10 && data_over!=0)
					inner_counter = counter+4'd1;
				else if (inner_counter < 4'd10)
					inner_counter = counter;
				else
					inner_counter = 4'd0;
					
				if (counter==4'd09 && Add<=16'd13435)
					inner_Add = Add+16'd1;
				else if (Add > 16'd13435)
					inner_Add = 16'd0;
				else
					inncer_Add = Add;
			end	
		
		default: ;
		endcase	
	end
		
always_comb 
	begin 
		counter = inner_counter;
		Add = inner_Add;
		
		
		unique case(current_state)

		
		RUN:
			begin 
			if (inner_counter< 4'd10 && data_over != 0)
				inner_counter = counter +4'd1;
				
			else if (inner_counter < 4'd10)
				inner_counter = counter;
			else
				inner_counter = 4'd00;

		

			if (counter == 4'd09 && Add <= 8'd13435)
				inner_Add = Add +4'd01;
				
			else if (Add > 8'd13435)
				inner_Add = 4'd00;
			else 
				inner_Add = Add;
			end
		endcase
	end 
	
	
	

endmodule

