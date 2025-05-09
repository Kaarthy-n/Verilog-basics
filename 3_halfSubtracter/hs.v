`timescale 1ns/1ps

module hs(
    input a,b,
    output s,d
    );

   assign s = a ^ b;
   assign d = a & ~b;

endmodule

// Testbench
module tb_hs;
    reg a, b;
    wire s, d;

    hs uut (
        .a(a),
        .b(b),
        .s(s),
        .d(d)
    );

    initial begin
        $dumpfile("hs.vcd"); 
        $dumpvars(0, tb_hs);
        $monitor("a=%b, b=%b, s=%b, d=%b", a, b, s, d);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule