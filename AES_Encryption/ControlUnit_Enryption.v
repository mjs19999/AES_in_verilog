`timescale 1ns / 1ps

module ControlUnit_Enryption(
	output reg done, init, isRound0, en_round_out, inc_count, en_reg_sub_out, en_reg_row_out, en_reg_col_out, en_Dout, 
	input count_lt_10, encrypt, clock, reset
);
	parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5, S6 = 3'd6;
	reg [2:0] current, next;
	
	always @(posedge clock, posedge reset) begin
		if (reset)
			current <= S0;
		else
			current <= next;
	end
	always @(*) begin
		done = 0;
		init = 0;
		en_round_out = 0;
		inc_count = 0;
		en_reg_sub_out = 0;
		en_reg_row_out = 0;
		en_reg_col_out = 0;
		en_Dout = 0;
		isRound0 = 0;
		case (current)
			S0: begin
				if (encrypt) begin
					init = 1;
					next = S1;
				end
			end
			S1: begin
				isRound0 = 1;
				en_round_out = 1;
				inc_count = 1;
				next = S2;
			end
			S2: begin 
				en_reg_sub_out = 1;
				next = S3;
			end
			S3: begin
				en_reg_row_out = 1;
				if (count_lt_10) begin
					next = S4;
				end
				else begin
					next = S5;
				end
			end
			S4: begin
				en_reg_col_out = 1;
				next = S5;
			end
			S5: begin
				if (count_lt_10) begin
					en_round_out = 1;
					inc_count = 1;
					next = S2;
				end
				else begin
					en_Dout = 1;
			      next = S6;
				end
			end
			S6: begin
				done = 1;
			   if (encrypt) begin
			      init = 1;
				   next = S1;
			   end
			end
		endcase
	end
endmodule
