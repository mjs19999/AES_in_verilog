`timescale 1ns / 1ps

module ControlUnitDatapath_Encryption(output reg done, output reg [127:0] Dout, input [127:0] encrypted_text_in, key_in, input encrypt, clock, reset);
	parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5, S6 = 3'd6, S7 = 3'd7;

	reg [2:0] state;
	reg [3:0] count;
	reg [127:0] round_out, encrypted_text, key, reg_sub_out, reg_row_out, reg_col_out;
	wire [127:0] sub_out, row_out, col_out, mux_out;
	wire [127:0] key_r [0:10];
	
	Key_expansion ke(key_r[0], key_r[1], key_r[2], key_r[3], key_r[4], key_r[5], key_r[6], key_r[7], key_r[8], key_r[9], key_r[10], key);
	
	Sub_Bytes sb0(sub_out, round_out);
	shift_rows sr0(row_out, reg_sub_out);
	mix_cols mc(col_out, reg_row_out);
	
	wire [127:0] key_r_out;
	assign key_r_out = key_r[count];
	
	always @(posedge clock, posedge reset) begin
		if (reset)
			state <= S0;
		else begin
			done <= 0;
			case (state)
				S0: begin
					if (encrypt) begin
						count <= 0;
						state <= S1;
						encrypted_text <= encrypted_text_in;
						key <= key_in;
					end
				end
				S1: begin
					round_out <= encrypted_text ^ key_r_out;
					count <= count + 1;
					state <= S2;
				end
				S2: begin 
					reg_sub_out <= sub_out;
					state <= S3;
				end
				S3: begin
					reg_row_out <= row_out;
					if (count < 10) begin
						state <= S4;
					end
					else begin
						state <= S5;
					end
				end
				S4: begin
					reg_col_out <= col_out;
					state <= S5;
				end
				S5: begin
					if (count < 10) begin
						round_out <= reg_col_out ^ key_r_out;
						count <= count + 1;
						state <= S2;
					end
					else begin
						Dout <= reg_row_out ^ key_r_out;
						done <= 1;
				      state <= S6;
					end
				end
				S6: begin
					done <= 1;
				   if (encrypt) begin
				      count <= 0;
					   state <= S1;
				   end
				end
			endcase
		end
	end
endmodule
