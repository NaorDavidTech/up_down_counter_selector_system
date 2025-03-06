`timescale 1ns/1ps
module up_down_counter_selector_system_tb;
	reg clk;
	reg rst_n;
	reg up_down;
	reg comp;
	reg [1:0] sel;
	wire [7:0] yout; 

up_down_counter_selector_system DUT 
(
	.clk(clk),
	.rst_n(rst_n),
	.up_down(up_down),
	.comp(comp),
	.sel(sel),
	.yout(yout)
);

// Test specific counter operation
task test_counter;
	input [1:0] counter_sel;
	begin
		$display("Testing counter %d", counter_sel);
		sel = counter_sel;

		// Test counting up
		up_down = 0;
		#30;

		// Test counting down
		up_down = 1;
		#10;
		
		// Perform complement operation
			comp = 1;
			#10;
			comp = 0;
			#10;
	end
endtask


    // Clock generation
    initial begin
        clk = 1;
    end
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        up_down = 0;
        comp = 0;
        sel = 0;
        
        // Test reset operation
        $display("Testing reset");
        rst_n = 0;
        #10;
        rst_n = 1;
        #10;
        
        // Test each counter
        test_counter(2'b00);
        test_counter(2'b01);
        test_counter(2'b10);
        test_counter(2'b11);
        #10;
		  
        $finish;
    end
endmodule