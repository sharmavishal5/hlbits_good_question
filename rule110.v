module top_module(
    input  clk,
    input  load,
    input  [511:0] data,
    output reg [511:0] q
);
    wire [511:0] a, b, c;
    wire [511:0] next_q;
    assign c = {q[510:0], 1'b0};
    assign b = q;
    assign a = {1'b0, q[511:1]};

    assign next_q = (b^c) | (~a&b);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
