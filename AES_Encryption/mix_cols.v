

module mix_cols(output [127:0] Dout, input [127:0] Din);


	wire [7:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15;
	reg [7:0] C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;

	assign b0 = Din[7:0];
	assign b1 = Din[15:8];
	assign b2 = Din[23:16];
	assign b3 = Din[31:24];
	assign b4 = Din[39:32];
	assign b5 = Din[47:40];
	assign b6 = Din[55:48];
	assign b7 = Din[63:56];
	assign b8 = Din[71:64];
	assign b9 = Din[79:72];
	assign b10 = Din[87:80];
	assign b11 = Din[95:88];
	assign b12 = Din[103:96];
	assign b13 = Din[111:104];
	assign b14 = Din[119:112];
	assign b15 = Din[127:120];
	
	assign Dout[7:0] = C0;
	assign Dout[15:8] = C1;
	assign Dout[23:16] = C2;
	assign Dout[31:24] = C3;
	assign Dout[39:32] = C4;
	assign Dout[47:40] = C5;
	assign Dout[55:48] = C6;
	assign Dout[63:56] = C7;
	assign Dout[71:64] = C8;
	assign Dout[79:72] = C9;
	assign Dout[87:80] = C10;
	assign Dout[95:88] = C11;
	assign Dout[103:96] = C12;
	assign Dout[111:104] = C13;
	assign Dout[119:112] = C14;
	assign Dout[127:120] = C15;
	
	
	always @(*) begin
		C15 = multiply(b15, 2) ^ multiply(b14, 3) ^ multiply(b13, 1) ^ multiply(b12, 1);
		C14 = multiply(b15, 1) ^ multiply(b14, 2) ^ multiply(b13, 3) ^ multiply(b12, 1);
		C13 = multiply(b15, 1) ^ multiply(b14, 1) ^ multiply(b13, 2) ^ multiply(b12, 3);
		C12 = multiply(b15, 3) ^ multiply(b14, 1) ^ multiply(b13, 1) ^ multiply(b12, 2);		

		C11 = multiply(b11, 2) ^ multiply(b10, 3) ^ multiply(b9, 1) ^ multiply(b8, 1);
		C10 = multiply(b11, 1) ^ multiply(b10, 2) ^ multiply(b9, 3) ^ multiply(b8, 1);
		C9 = multiply(b11, 1) ^ multiply(b10, 1) ^ multiply(b9, 2) ^ multiply(b8, 3);
		C8 = multiply(b11, 3) ^ multiply(b10, 1) ^ multiply(b9, 1) ^ multiply(b8, 2);

		C7 = multiply(b7, 2) ^ multiply(b6, 3) ^ multiply(b5, 1) ^ multiply(b4, 1);
		C6 = multiply(b7, 1) ^ multiply(b6, 2) ^ multiply(b5, 3) ^ multiply(b4, 1);
		C5 = multiply(b7, 1) ^ multiply(b6, 1) ^ multiply(b5, 2) ^ multiply(b4, 3);
		C4 = multiply(b7, 3) ^ multiply(b6, 1) ^ multiply(b5, 1) ^ multiply(b4, 2);

		C3 = multiply(b3, 2) ^ multiply(b2, 3) ^ multiply(b1, 1) ^ multiply(b0, 1);
		C2 = multiply(b3, 1) ^ multiply(b2, 2) ^ multiply(b1, 3) ^ multiply(b0, 1);
		C1 = multiply(b3, 1) ^ multiply(b2, 1) ^ multiply(b1, 2) ^ multiply(b0, 3);
		C0 = multiply(b3, 3) ^ multiply(b2, 1) ^ multiply(b1, 1) ^ multiply(b0, 2);
	end
	
	function integer multiply (input integer a, input integer b);
			if (b == 1) begin
				multiply = a;
			end
			else if (b == 2) begin
				multiply = (a < 8'h80) ? a << 1 : (a << 1) & 8'hFF ^ 8'h1B;
			end
			else if (b == 3)
				multiply = (a < 8'h80) ? a << 1 ^ a : ((a << 1) & 8'hFF) ^ 8'h1B ^ a;
	endfunction
endmodule
