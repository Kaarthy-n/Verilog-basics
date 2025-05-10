`timescale 1ns/1ps

module mux2_1(
    input s,
    input [1:0] i,
    output o
);
// assign o = s ? i[1] : i[0];
assign o=i[s];
endmodule

module mux2_1_tb;
    reg s;
    reg [1:0] i;
    wire o;

    mux2_1 mux(s,i,o);
    
    initial begin
        $dumpfile("mux2_1.vcd");
        $dumpvars(0,mux2_1_tb);
        $monitor("Select line - %b: i[1] - %b, i[0] - %b ---> output - %b",s,i[1],i[0],o);
        i = 0;
        s = 0;

        #40 $finish;
    end
    always #5 s=~s;
    always #10 i[0]=~i[0];
    always #20 i[1]=~i[1];
endmodule