`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:43 01/26/2022 
// Design Name: 
// Module Name:    Register 
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
module Register #(parameter n = 128) (output reg [n-1:0] Q, input [n-1:0] D, input enable, clock, reset);
	always @(posedge clock, posedge reset) begin
		if (reset)
			Q <= 128'd0;
		else if (enable)
			Q <= D;
	end
endmodule
