`timescale 1ns / 1ps

module Datapath_Decryption(
	output [127:0] Dout, output count_gt_0, count_eq_9,
	input [127:0] encrypted_text_in, key_in, input isRound10, isRound9, init, dec_count, en_round_out, en_reg_inv_row_out, en_reg_inv_sub_out, en_reg_inv_col_out, en_Dout, clock, reset
	);
	
	wire [127:0] round_in, inv_sub_out, inv_row_out, inv_col_out, mux_out, Din;
	wire [127:0] encrypted_text, key, round_out, reg_inv_sub_out, reg_inv_row_out, reg_inv_col_out;
	wire [127:0] key_r_out;
	wire [127:0] key_r [0:10];
	wire [3:0] count;
	
	//Registers
	Register #(128) Reg_key(key, key_in, init, clock, reset);
	Register #(128) Reg_encrypted_text(encrypted_text, encrypted_text_in, init, clock, reset);
	Register #(128) Reg_round_out(round_out, round_in, en_round_out, clock, reset);
	Register #(128) Reg_inv_sub_out(reg_inv_sub_out, inv_sub_out, en_reg_inv_sub_out, clock, reset);
	Register #(128) Reg_inv_row_out(reg_inv_row_out, inv_row_out, en_reg_inv_row_out, clock, reset);
	Register #(128) Reg_inv_col_out(reg_inv_col_out, inv_col_out, en_reg_inv_col_out, clock, reset);
	Register #(128) Reg_Dout(Dout, Din, en_Dout, clock, reset);
	
	//counter
	Counter #(4) down(count, 4'd10, init, 1'b0, dec_count, clock, reset);
	assign count_gt_0 = count > 0;
	assign count_eq_9 = count == 9;
	//AES Blocks
	Key_expansion ke(key_r[0], key_r[1], key_r[2], key_r[3], key_r[4], key_r[5], key_r[6], key_r[7], key_r[8], key_r[9], key_r[10], key);
	
	assign mux_out = (isRound9) ? round_out : reg_inv_col_out;
	Inv_shift_rows sr0(inv_row_out, mux_out);
	Inv_Sub_Bytes sb0(inv_sub_out, reg_inv_row_out);
	Inv_mix_cols mc(inv_col_out, round_out);
	

	assign key_r_out = key_r[count];
	assign round_in = ((isRound10) ? encrypted_text : reg_inv_sub_out) ^ key_r_out;
	assign Din = reg_inv_sub_out ^ key_r_out;
	

endmodule
