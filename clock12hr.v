
module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    wire [1:0]ena_s, ena_m;
    wire  ena_h;
    wire reset_s, reset_m, reset_h;

    assign ena_s = {ss[3:0]==4'd9, 1'b1};
    assign reset_s = (ss == 8'h59);

    bcdcount s0(clk, reset,           ena_s[0]&ena, ss[3:0]);
    bcdcount s1(clk, (reset_s|reset), ena_s[1]&ena, ss[7:4]);

    bcdcount m0(clk, (reset_m|reset), ena_m[0]&ena, mm[3:0]);
    bcdcount m1(clk, (reset_m|reset), ena_m[1]&ena, mm[7:4]);

    assign ena_m = {(mm[3:0]==4'd9) &&(ss == 8'h59), (ss == 8'h59)};
    assign reset_m = (mm==8'h59)&&(ss==8'h59);
    
    bcdcount12 hr(clk, reset, ena_h&ena, hh);

    assign ena_h = (mm==8'h59) &&(ss == 8'h59);

    always @(posedge clk) begin
        if(reset) pm <= 0;
        else if (ena && hh==8'h11 && mm==8'h59 && ss==8'h59)
            pm <= ~pm;
        else pm <= pm; 
    end

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

module bcdcount12(
    input clk,reset, enable,
    output reg [7:0]q);
    always @(posedge clk) begin
        if(reset) q <= 8'h12;
        else if(enable) begin
            if(q == 8'd9) q <= 8'h10;
            else if(q == 8'h12) q <= 8'd1;
            else q <= q + 8'h1;
        end
        else q <= q;
    end
endmodule