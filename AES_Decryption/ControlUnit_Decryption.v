`timescale 1ns / 1ps

module ControlUnit_Decryption(
	output reg done, isRound10, isRound9, init, dec_count, en_round_out, en_reg_inv_row_out, en_reg_inv_sub_out, en_reg_inv_col_out, en_Dout,
	input decrypt, count_gt_0, count_eq_9, clock, reset
	);
	parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5, S6 = 3'd6;
	reg [2:0] current, next; 
	/*
	reg [2:0] state;
	reg [3:0] count;
	reg [127:0] round_out, encrypted_text, key, reg_inv_sub_out, reg_inv_row_out, reg_inv_col_out, reg_mux_out;
	wire [127:0] inv_sub_out, inv_row_out, inv_col_out, mux_out;
	wire [127:0] key_r [0:10];
	
	reg isRound10;
	Key_expansion ke(key_r[0], key_r[1], key_r[2], key_r[3], key_r[4], key_r[5], key_r[6], key_r[7], key_r[8], key_r[9], key_r[10], key);
	
	assign mux_out = (isRound10) ? round_out : reg_inv_col_out;
	Inv_shift_rows sr0(inv_row_out, mux_out);
	Inv_Sub_Bytes sb0(inv_sub_out, reg_inv_row_out);
	Inv_mix_cols mc(inv_col_out, round_out);
	
	wire [127:0] key_r_out;
	assign key_r_out = key_r[count];
	
	*/
	always @(posedge clock, posedge reset) begin
		if (reset)
			current <= S0;
		else
			current <= next;
	end
	
	always @(*) begin
		done = 0;
		isRound10 = 0;
		isRound9 = 0;
		init = 0;
		dec_count = 0;
		en_round_out = 0;
		en_reg_inv_row_out = 0;
		en_reg_inv_sub_out = 0;
		en_Dout = 0;
		case (current)
			S0: begin
				if (decrypt) begin
					init = 1;
					next = S1;
				end
			end
			S1: begin						
				isRound10 = 1;
				//round_out <= encrypted_text ^ key_r_out;
				en_round_out = 1;
				dec_count = 1;
				next = S2;
			end
			S2: begin
				//reg_inv_row_out <= inv_row_out;
				if (count_eq_9) begin
					isRound9 = 1;
				end
				en_reg_inv_row_out = 1;
				next = S3;
			end
			S3: begin
				//reg_inv_sub_out <= inv_sub_out;
				en_reg_inv_sub_out = 1;
				next = S4;
			end
			S4: begin
				//round_out <= inv_sub_out ^ key_r_out;
				en_round_out = 1;
				next = S5;
			end
			S5: begin
				if (count_gt_0) begin
					//reg_inv_col_out <= inv_col_out;
					en_reg_inv_col_out = 1;
					dec_count = 1;
					next = S2;
				end
				else begin
					//Dout <= inv_sub_out ^ key_r_out;
					en_Dout = 1;
					next = S6;
				end
			end
			S6: begin
				done = 1;
				if (decrypt) begin
					init = 1;
					next = S1;
				end
			end
		endcase
	end
endmodule
