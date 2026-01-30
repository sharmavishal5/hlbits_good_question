module top_module (
    input  clk,
    input  reset,
    input  [31:0] in,
    output reg [31:0] out
);
    reg [31:0] inr;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            inr <= in;
        end else begin
            out <= out | (inr & ~in);
            inr <= in;
        end
    end
endmodule
