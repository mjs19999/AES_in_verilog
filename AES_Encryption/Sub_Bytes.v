`timescale 1ns / 1ps

module Sub_Bytes(output[127:0] D_out,input [127:0]D_in);

	wire[127:0] S_out;
	
	genvar i;
	for(i=0;i<16;i=i+1) begin: S_boxes
		S_BOX S1(S_out[(8*i+7):8*i],D_in[(8*i+7):8*i]); 	
	end
	
	assign D_out=S_out;
	
endmodule
