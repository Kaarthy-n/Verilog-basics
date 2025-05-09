`timescale 1ns/1ps

module fa(
    input a,b,cin,
    output sum,cout);
    
   assign sum = a ^ b ^ cin;
   assign cout = (a & b) | (cin & (a ^ b));    
endmodule

module nBitas #(
    parameter SIZE = 8
) (
    input [SIZE-1:0]a,b,
    input ctrl,
    output [SIZE-1:0]s,cout);
    wire [SIZE-1:0] bc;
    genvar g;

    assign bc[0] = b[0] ^ ctrl;

    fa fa0(a[0],b[0],ctrl,s[0],cout[0]);
    generate
        for(g=1; g<SIZE; g=g+1)begin
            assign bc[g]=b[g] ^ ctrl;
            fa fag(a[g],bc[g],cout[g-1],s[g],cout[g]);
        end
    endgenerate 
endmodule

module nBitas_tb;
    parameter SIZE = 8;
    wire [SIZE-1:0]s,cout;
    reg [SIZE-1:0]a,b;
    reg ctrl;

    nBitas nBitas(a,b,ctrl,s,cout);

    initial begin
        $dumpfile("rca.vcd"); 
        $dumpvars(0,nBitas_tb);
        repeat(10) begin
            a = $random & ((1<<SIZE)-1); // Mask to SIZE bits
            b = $random & ((1<<SIZE)-1); // Mask to SIZE bits
            ctrl = $random % 2;
            #2;
            $display("Mode: %s | a=%0d, b=%0d | Result=%0d | Overflow=%b", ctrl ? "SUB" : "ADD",
            $signed(a), $signed(b), $signed(s), cout[SIZE-1]^cout[SIZE-2]);
            #3;
        end
        $finish;
    end
endmodule