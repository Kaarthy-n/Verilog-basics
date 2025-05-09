`timescale 1ns/1ps

module fa(input a,b,cin,
           output sum,cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

//fa much better than using ha
module ha(input a,b,
           output sum,carry);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module fa_using_ha(input a,b,cin,
           output sum,cout);
    wire s1,c1,c2;
    ha ha1(a,b,s1,c1);
    ha ha2(s1,cin,sum,c2);
    assign cout = c1 | c2;
endmodule

// Testbench
module tb_fa;
    reg a, b, cin;
    wire sum, cout;

    fa uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $dumpfile("fa.vcd"); 
        $dumpvars(0, tb_fa);
        $monitor("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        
       a = 0; b = 0; cin = 0; #10;
       a = 0; b = 1; cin = 0; #10;
       a = 1; b = 0; cin = 0; #10;
       a = 1; b = 1; cin = 0; #10;
       a = 0; b = 0; cin = 1; #10;
       a = 0; b = 1; cin = 1; #10;
       a = 1; b = 0; cin = 1; #10;
       a = 1; b = 1; cin = 1; #10;

        $finish;
    end
endmodule