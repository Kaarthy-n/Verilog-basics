`timescale 1ns/1ps

module mux4_1(
    input [1:0]s,
    input [3:0]i,
    output y
);
assign y = i[s];
endmodule

module mux4_1_tb;
reg [1:0]s;
reg [3:0]i;
wire y;

mux4_1 mux(s,i,y);
initial begin
    $dumpfile("mux4_1.vcd");
    $dumpvars(0,mux4_1_tb);
    $monitor("Select Line - %b: i[3]-%b,i[2]-%b,i[1]-%b,i[0]-%b and output - %b",s,i[3],i[2],i[1],i[0],y);
    i = 0;
    s = 0;

    #64 $finish;
end
always #1 i[0]=~i[0];
always #2 i[1]=~i[1];
always #4 i[2]=~i[2];
always #8 i[3]=~i[3];
always #16 s[0]=~s[0];
always #32 s[1]=~s[1];
endmodule