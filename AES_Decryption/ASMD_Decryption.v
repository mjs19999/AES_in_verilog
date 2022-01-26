`timescale 1ns / 1ps

module ASMD_Decryption(output done, output [127:0] Dout, input [127:0] encrypted_text_in, key_in, input decrypt, clock, reset);
	wire isRound10, isRound9, init, dec_count, en_round_out, en_reg_inv_row_out, en_reg_inv_sub_out, en_reg_inv_col_out, en_Dout, decrypt, count_gt_0, count_eq_9;
	
	ControlUnit_Decryption cu_dec(done, isRound10, isRound9, init, dec_count, en_round_out, en_reg_inv_row_out, en_reg_inv_sub_out, en_reg_inv_col_out, en_Dout, decrypt, count_gt_0, count_eq_9, clock, reset);
	Datapath_Decryption dp_dec(Dout, count_gt_0, count_eq_9, encrypted_text_in, key_in, isRound10, isRound9, init, dec_count, en_round_out, en_reg_inv_row_out, en_reg_inv_sub_out, en_reg_inv_col_out, en_Dout, clock, reset);
	
	
endmodule
