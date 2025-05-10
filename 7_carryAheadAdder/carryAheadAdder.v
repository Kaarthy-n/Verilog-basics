`timescale 1ns/1ps

module carry_lookahead_adder #(
    parameter N=4
) (
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output [N-1:0] s,
    output cout
);

    wire [N-1:0] g;    
    wire [N-1:0] p;    
    wire [N:0]   c;    
    
    assign g = a & b;        
    assign p = a ^ b;        
    
    assign c[0] = cin;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : carry_logic
            assign c[i+1] = g[i] | (p[i] & c[i]);
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < N; j = j + 1) begin : sum_logic
            assign s[j] = p[j] ^ c[j];
        end
    endgenerate

    assign cout = c[N];
endmodule

module cla_adder_tb;
    parameter N = 4;
    reg [N-1:0] a, b;
    reg cin;
    wire [N-1:0] s;
    wire cout;

    carry_lookahead_adder #(.N(N)) cla (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("carryAheadAdder.vcd");
        $dumpvars(0, cla_adder_tb);
        $monitor("Time: %0t | a: %b, b: %b, cin: %b | s: %b, cout: %b", $time, a, b, cin, s, cout);
        a = 4'b1101; b = 4'b1011; cin = 0; #10; 
        a = 4'b0110; b = 4'b0101; cin = 1; #10; 
        a = 4'b1111; b = 4'b0001; cin = 0; #10; 
        a = 4'b0000; b = 4'b0000; cin = 0; #10; 
        
        $finish;
    end
endmodule