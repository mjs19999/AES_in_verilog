`timescale 1ns / 1ps

module Datapath_Encryption(
	output [127:0] Dout, output count_lt_10,
	input [127:0] key_in, plain_text_in, input init, isRound0, en_round_out, inc_count, en_reg_sub_out, en_reg_row_out, en_reg_col_out, en_Dout, reset, clock
);
	wire [127:0] round_in, sub_out, row_out, col_out, mux_out, Din;
	wire [127:0] plain_text, key, round_out, reg_sub_out, reg_row_out, reg_col_out;
	wire [127:0] key_r_out;
	wire [127:0] key_r [0:10];
	wire [3:0] count;
	
	//Registers
	Register #(128) Reg_key(key, key_in, init, clock, reset);
	Register #(128) Reg_plain_text(plain_text, plain_text_in, init, clock, reset);
	Register #(128) Reg_round_out(round_out, round_in, en_round_out, clock, reset);
	Register #(128) Reg_sub_out(reg_sub_out, sub_out, en_reg_sub_out, clock, reset);
	Register #(128) Reg_row_out(reg_row_out, row_out, en_reg_row_out, clock, reset);
	Register #(128) Reg_col_out(reg_col_out, col_out, en_reg_col_out, clock, reset);
	Register #(128) Reg_Dout(Dout, Din, en_Dout, clock, reset);
	
	//Counter
	Counter #(4) up(count, 4'd0, 1'b0, inc_count, 1'b0, clock, reset);
	assign count_lt_10 = count < 10;
	
	//AES blocks
	Key_expansion ke(key_r[0], key_r[1], key_r[2], key_r[3], key_r[4], key_r[5], key_r[6], key_r[7], key_r[8], key_r[9], key_r[10], key);
	Sub_Bytes sb0(sub_out, round_out);
	shift_rows sr0(row_out, reg_sub_out);
	mix_cols mc(col_out, reg_row_out);
	assign key_r_out = key_r[count];
	assign round_in = ((isRound0) ? plain_text : reg_col_out) ^ key_r_out;
	assign Din = reg_row_out ^ key_r_out;
endmodule
