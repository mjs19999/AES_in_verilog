`timescale 1ns / 1ps

module testbench_Decryption();
	reg [127:0] encrypted_text, key;
	reg decrypt, clock, reset;
	wire  [127:0] Data_OUT;
	wire done;
	//ControlUnitDatapath_Decryption A(done, Data_OUT, encrypted_text, key, decrypt, clock, reset);
	ASMD_Decryption A(done, Data_OUT, encrypted_text, key, decrypt, clock, reset);

	
	initial begin
		clock = 0; forever #50 clock = ~clock;
	end
	
	initial begin
	// Resetting the machine
	@(negedge clock) reset = 1;
	@(negedge clock) reset = 0; decrypt = 1; key = 128'h49206c6f76652063686f636f6c617465; encrypted_text=128'hd4d9e235c89a2989fd6bdddc7f19aa94;
	@(negedge clock) decrypt = 0;
	@(negedge clock) ;
	
	
	end

endmodule
