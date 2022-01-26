`timescale 1ns / 1ps

module testbench_Encryption();
	reg [127:0] plain_text, key;
	reg encrypt, clock, reset;
	wire  [127:0] Data_OUT;
	wire done;
	//ControlUnitDatapath_Encryption A(done, Data_OUT, plain_text, key, encrypt, clock, reset);
	ASMD_Encryption A(done, Data_OUT, plain_text, key, encrypt, clock, reset);

	
	initial begin
		clock = 0; forever #50 clock = ~clock;
	end
	
	initial begin
	// Resetting the machine
	@(negedge clock) reset = 1;
	@(negedge clock) reset = 0; encrypt = 1; key = 128'h49206c6f76652063686f636f6c617465; plain_text=128'h49206c6f76652063686f636f6c617465;
	@(negedge clock) encrypt = 0;
	@(negedge clock) ;
	
	
	end

endmodule
