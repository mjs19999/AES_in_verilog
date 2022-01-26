`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:49:06 12/11/2021 
// Design Name: 
// Module Name:    Inv_Sub_Bytes 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Inv_Sub_Bytes(output [127:0] D_out, input [127:0] D_in);

	wire [127:0] inv_S_out;
	
	genvar i;
	for(i=0; i<16; i=i+1) begin : Inverse
		inv_S_box inv_S1(inv_S_out[(8*i+7):8*i], D_in[(8*i+7):8*i]); 	
	end
	assign D_out = inv_S_out;

endmodule
