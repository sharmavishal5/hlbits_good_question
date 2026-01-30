module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0] h,m,s;
    bcdcount counter0 (clk, reset, c_enable[0], s);
    bcdcount counter1 (clk, reset, c_enable[1], m);
    bcdcount counter2 (clk, reset, c_enable[2], h);

    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (s == 4'd9);
    assign c_enable[2] = (s == 4'd9) && (m == 4'd9);
    assign OneHertz    = (s == 4'd9) && (m == 4'd9) && (h == 4'd9);

endmodule

module bcdcount(
    input clk,reset, enable,
    output reg [3:0]q);
    always @(posedge clk) begin
        if(reset) q <= 0;
        else if(enable) begin
            if(q == 4'd9) q <= 0;
            else q <= q + 1;
        end
        else q <= q;
    end
endmodule
