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
    // Generate and propagate signals
    wire [N-1:0] g;    // Generate
    wire [N-1:0] p;    // Propagate
    wire [N:0]   c;    // Carry chain
    
    // Calculate generate and propagate for each bit position
    assign g = a & b;        // Generate: carry is generated when both bits are 1
    assign p = a ^ b;        // Propagate: carry is propagated when exactly one bit is 1
    
    // Set initial carry-in
    assign c[0] = cin;
    
    // Calculate carries using generate and propagate logic
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : carry_logic
            assign c[i+1] = g[i] | (p[i] & c[i]);
        end
    endgenerate
    
    // Calculate sum bits
    assign s = p ^ c[N-1:0];
    assign cout = c[N];
endmodule

