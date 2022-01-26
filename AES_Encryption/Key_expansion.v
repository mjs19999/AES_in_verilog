`timescale 1ns / 1ps

module Key_expansion(output [127:0] key_r0,key_r1,key_r2,key_r3,key_r4,key_r5,key_r6,key_r7,key_r8,key_r9,key_r10,input [127:0]key);

		wire [31:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30,w31,w32,w33,w34,w35,w36,w37,w38,w39,w40,w41,w42,w43;

		wire [31:0] out_g1,out_g2,out_g3,out_g4,out_g5,out_g6,out_g7,out_g8,out_g9,out_g10;
		
		
		assign 	w0=key[127:96];
		assign	w1=key[95:64];
		assign	w2=key[63:32];
		assign	w3=key[31:0];
		
		function_g G1(w3,4'd1,out_g1);
		
		assign	w4=w0^out_g1;
		assign	w5=w1^w0^out_g1;
		assign	w6=w2^w0^out_g1^w1;
		assign   w7=w3^w0^out_g1^w1^w2;
		
		function_g G2(w7,4'd2,out_g2);
		
		assign	w8=w4^out_g2;
		assign	w9=w4^w5^out_g2;
		assign	w10=w4^w5^w6^out_g2;
		assign	w11=w4^w5^w6^w7^out_g2;
		
		function_g G3(w11,4'd3,out_g3);
		
		assign	w12=w8^out_g3;
		assign	w13=w8^w9^out_g3;
		assign	w14=w8^w9^w10^out_g3;
		assign	w15=w8^w9^w10^w11^out_g3;
		
		function_g G4(w15,4'd4,out_g4);
		
		assign	w16=w12^out_g4;
		assign	w17=w12^w13^out_g4;
		assign	w18=w12^w13^w14^out_g4;
		assign	w19=w12^w13^w14^w15^out_g4;
		
		function_g G5(w19,4'd5,out_g5);
		
		assign	w20=w16^out_g5;
		assign	w21=w16^w17^out_g5;
		assign	w22=w16^w17^w18^out_g5;
		assign	w23=w16^w17^w18^w19^out_g5;
		
		function_g G6(w23,4'd6,out_g6);
		
		assign	w24=w20^out_g6;
		assign	w25=w20^w21^out_g6;
		assign	w26=w20^w21^w22^out_g6;
		assign	w27=w20^w21^w22^w23^out_g6;
		
		function_g G7(w27,4'd7,out_g7);
		
		assign	w28=w24^out_g7;
		assign	w29=w24^w25^out_g7;
		assign	w30=w24^w25^w26^out_g7;
		assign	w31=w24^w25^w26^w27^out_g7;
		
		function_g G8(w31,4'd8,out_g8);
		
		assign	w32=w28^out_g8;
		assign	w33=w28^w29^out_g8;
		assign	w34=w28^w29^w30^out_g8;
		assign	w35=w28^w29^w30^w31^out_g8;
		
		function_g G9(w35,4'd9,out_g9);
		
	assign	w36=w32^out_g9;
	assign	w37=w32^w33^out_g9;
	assign	w38=w32^w33^w34^out_g9;
	assign	w39=w32^w33^w34^w35^out_g9;
		
		function_g G10(w39,4'd10,out_g10);
		
	assign	w40=w36^out_g10;
	assign	w41=w36^w37^out_g10;
	assign	w42=w36^w37^w38^out_g10;
	assign	w43=w36^w37^w38^w39^out_g10;
		
		
		assign key_r0={w0,w1,w2,w3};
		assign key_r1={w4,w5,w6,w7};
		assign key_r2={w8,w9,w10,w11};
		assign key_r3={w12,w13,w14,w15};
		assign key_r4={w16,w17,w18,w19};
		assign key_r5={w20,w21,w22,w23};
		assign key_r6={w24,w25,w26,w27};		
		assign key_r7={w28,w29,w30,w31};
		assign key_r8={w32,w33,w34,w35};
		assign key_r9={w36,w37,w38,w39};
		assign key_r10={w40,w41,w42,w43};


endmodule
