`timescale 1ns/1ps

module gray2binary #(
    parameter N=4
)(
    input [N-1:0] gray,
    output [N-1:0] binary
);
    assign binary[N-1] = gray[N-1];
    
    // genvar i;
    // generate
    //     for (i = N-2; i >= 0; i = i - 1) begin : binary_logic
    //         assign binary[i] = binary[i+1] ^ gray[i];
    //     end
    // endgenerate 
    assign binary = gray ^ {1'b0, gray[N-1:1]};
endmodule

module gray2binary_tb;
    parameter N = 4;
    reg [N-1:0] gray;
    wire [N-1:0] binary;

    gray2binary #(.N(N)) gb (
        .gray(gray),
        .binary(binary)
    );

    initial begin
        $dumpfile("gray2binary.vcd");
        $dumpvars(0, gray2binary_tb);
        $monitor("Time: %0t | Gray: %b | Binary: %b", $time, gray, binary);
        gray = 4'b0000;
        repeat (15) begin
            #10 gray = gray + 1;
        end
        #10 $finish;
    end
endmodule