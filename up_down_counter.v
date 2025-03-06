module up_down_counter #(parameter N = 8)
(
	input  clk,
	input  rst_n,
	input  en,
	input  up_down,
	input  comp,
	output reg [N-1:0] y
);

	function [N-1:0] mvine;
		input [N-1:0] x;
		reg [N-1:0] sum;
		reg c;
		integer i;
		begin
			c = 0;

			for (i = 0; i < N; i = i + 1) begin
				 sum[i] = x[i] ^ c;    
				 c = x[i] | c;         
			end
			mvine = sum; 
		end
	endfunction

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			y <= {N{1'b0}};
		end 
		else begin
			if (comp) begin
				y <= mvine(y);
			end
			else if (en) begin
				if (!up_down) begin
				  y <= y + 1'b1;
				end
				else begin
				  y <= y - 1'b1;
				end
			end
		end
	end
endmodule