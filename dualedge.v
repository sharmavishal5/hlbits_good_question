module top_module (
    input clk,
    input d,
    output reg q
);
    reg p_q, n_q;
    always @(posedge clk) p_q <= d;
    always @(negedge clk)n_q <= d;
    assign q = (clk&p_q) | (~clk&n_q);
endmodule