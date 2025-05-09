`timescale 1ns/1ps

module ha (
    input a,b,
    output s, c
);

    assign s = a ^ b;
    assign c = a & b;

endmodule

// Testbench
module tb_ha;
    reg a, b;
    wire s, c;

    ha uut (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    initial begin
        $dumpfile("ha.vcd"); 
        $dumpvars(0, tb_ha);
        $monitor("a=%b, b=%b, s=%b, c=%b", a, b, s, c);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule