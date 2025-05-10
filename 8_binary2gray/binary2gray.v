`timescale 1ns/1ps

module binary2gray #(
    parameter N=4
) (
    input [N-1:0] binary,
    output [N-1:0] gray
);
    assign gray = {binary[N-1], binary[N-1:1] ^ binary[N-2:0]};

    //Alternate method
    // assign gray[N-1] = binary[N-1];

    // genvar i;
    // generate
    //     for (i = N-2; i >= 0; i = i - 1) begin : gray_logic
    //         assign gray[i] = binary[i+1] ^ binary[i];
    //     end
    // endgenerate
endmodule

module binary2gray_tb;
    parameter N = 4;
    reg [N-1:0] binary;
    wire [N-1:0] gray;

    binary2gray #(.N(N)) bg (
        .binary(binary),
        .gray(gray)
    );

    initial begin
        $dumpfile("binary2gray.vcd");
        $dumpvars(0, binary2gray_tb);
        $monitor("Time: %0t | Binary: %b | Gray: %b", $time, binary, gray);
        binary = 4'b0000;
        repeat (15) begin
        #10 binary = binary + 1;
        end
        #10 $finish;
    end

endmodule