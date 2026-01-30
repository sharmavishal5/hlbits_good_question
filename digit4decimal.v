module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output reg [15:0] q);
    wire [3:0] en;
    bcdcount d1(clk, reset, en[0], q[3:0]);
    bcdcount d2(clk, reset, en[1], q[7:4]);
    bcdcount d3(clk, reset, en[2], q[11:8]);
    bcdcount d4(clk, reset, en[3], q[15:12]);

    assign en = {(q[3:0]==4'd9)&&(q[7:4]==4'd9)&&(q[11:8]==4'd9),
                 (q[3:0]==4'd9)&&(q[7:4]==4'd9),
                 (q[3:0]==4'd9),
                  1'b1 };
	assign ena = en[3:1];
endmodule

module bcdcount(
    input clk,reset, enable,
    output reg [3:0]q);
    always @(posedge clk) begin
        if(reset) q <= 0;
        else if(enable) begin
            if(q == 4'd9) q <= 0;
            else q <= q + 4'b1;
        end
        else q <= q;
    end
endmodule