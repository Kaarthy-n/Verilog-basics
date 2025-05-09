`timescale 1ns/1ps

module fs(
    input a,b,bin,
    output d,bout);

    assign d = a^b^bin;
    assign bout = (~a&b) | (~(a&b)&bin);
endmodule

// Testbench
module tb_fs;
    reg a,b,bin;
    wire d,bout;

    fs uut(
    .a(a),
    .b(b),
    .bin(bin),
    .d(d),
    .bout(bout));
    
    initial begin
        a = 0;
        b = 0;
        bin = 0;

        $dumpfile("fs.vcd");
        $dumpvars(0,tb_fs);
        $monitor("a=%b, b=%b, bin=%b, d=%b, bout=%b", a, b, bin, d, bout);

        #80 $finish;
    end
    
    always #10 bin=~bin;
    always #20 b=~b;
    always #40 a=~a;
endmodule