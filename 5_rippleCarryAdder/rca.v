`timescale 1ns/1ps

module fa(
    input a,b,cin,
    output sum,cout);
    
   assign sum = a ^ b ^ cin;
   assign cout = (a & b) | (cin & (a ^ b));    
endmodule

module rca #(
    parameter SIZE = 8
) (
    input [SIZE-1:0] a,b,
    input cin,
    output [SIZE-1:0] s,cout
);
    genvar g;

    fa fa0(a[0],b[0],cin,s[0],cout[0]);
    generate
        for(g=1;g<SIZE;g=g+1)begin
            fa fag(a[g], b[g], cout[g-1], s[g], cout[g]);
        end
    endgenerate
endmodule

module rca_tb;
    parameter SIZE = 8;
    
    wire [SIZE-1:0]s,cout;
    reg [SIZE-1:0]a,b;
    reg cin;
    wire [SIZE:0]add;

    rca rca(a,b,cin,s,cout);
    assign add = {cout[SIZE-1],s};

    initial begin
        $dumpfile("rca.vcd"); 
        $dumpvars(0,rca_tb);
        $monitor("a = %b: b = %b, cin = %b ---> s = %b, cout[%0d] = %b, add = %b",
                 a, b, cin, s, SIZE-1, cout[SIZE-1], add);
                 
        repeat(5) begin
        a = $random;
        b = $random;
        cin = $random % 2;
        #5;
        end
        $finish;
    end
endmodule