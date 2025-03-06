module up_down_counter_selector_system 
(
	input  clk,
	input  rst_n,
	input  up_down,
	input  comp,
	input  [1:0] sel,
	output [7:0] yout
);
    
	wire [4:0] counter_out_5bit;
	wire [5:0] counter_out_6bit;
	wire [6:0] counter_out_7bit;
	wire [7:0] counter_out_8bit;
	wire comp_to_counter0, comp_to_counter1; 
	wire comp_to_counter2, comp_to_counter3;
	
	
	assign comp_to_counter0 = (sel == 2'b00) ? comp : 1'b0;
	assign comp_to_counter1 = (sel == 2'b01) ? comp : 1'b0;
	assign comp_to_counter2 = (sel == 2'b10) ? comp : 1'b0;
	assign comp_to_counter3 = (sel == 2'b11) ? comp : 1'b0;
	

	reg [3:0] enable_signals;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			enable_signals <= 4'b0000;
		end
		else begin
			enable_signals <= (4'b0001 << sel); 
		end
	end

	
	up_down_counter #(.N(5)) counter_5bit 
	(
		.clk(clk),
		.rst_n(rst_n),
		.en(enable_signals[0]),
		.up_down(up_down),
		.comp(comp_to_counter0),    
		.y(counter_out_5bit)
	);

	up_down_counter #(.N(6)) counter_6bit 
	(
		.clk(clk),
		.rst_n(rst_n),
		.en(enable_signals[1]),
		.up_down(up_down),
		.comp(comp_to_counter1),    
		.y(counter_out_6bit)
	);

	up_down_counter #(.N(7)) counter_7bit 
	(
		.clk(clk),
		.rst_n(rst_n),
		.en(enable_signals[2]),
		.up_down(up_down),
		.comp(comp_to_counter2),    
		.y(counter_out_7bit)
	);

	up_down_counter #(.N(8)) counter_8bit 
	(
		.clk(clk),
		.rst_n(rst_n),
		.en(enable_signals[3]),
		.up_down(up_down),
		.comp(comp_to_counter3),    
		.y(counter_out_8bit)
	);

	
	reg [7:0] mux_out;
	always @(*) begin
		case (sel)
			2'b00: mux_out = {{3{1'b0}}, counter_out_5bit};
			2'b01: mux_out = {{2{1'b0}}, counter_out_6bit};
			2'b10: mux_out = {1'b0, counter_out_7bit};
			2'b11: mux_out = counter_out_8bit;
			default: mux_out = 8'b0;
		endcase
	end

	assign yout = mux_out;

endmodule