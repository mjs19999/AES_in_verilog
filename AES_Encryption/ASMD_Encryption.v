`timescale 1ns / 1ps

module ASMD_Encryption (output done, output [127:0] Dout, input [127:0] plain_text_in, key_in, input encrypt, clock, reset);
	wire init, isRound0, en_round_out, inc_count, en_reg_sub_out, en_reg_row_out, en_reg_col_out, en_Dout, count_lt_10, encrypt;
	
	ControlUnit_Enryption cu_enc(done, init, isRound0, en_round_out, inc_count, en_reg_sub_out, en_reg_row_out, en_reg_col_out, en_Dout, count_lt_10, encrypt, clock, reset);
	Datapath_Encryption dp_enc(Dout, count_lt_10, key_in, plain_text_in, init, isRound0, en_round_out, inc_count, en_reg_sub_out, en_reg_row_out, en_reg_col_out, en_Dout, reset, clock);
endmodule
