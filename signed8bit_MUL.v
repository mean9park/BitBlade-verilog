`timescale 1ns / 1ps

module signed_8bit_MUL(
    input [7:0] in_x,
    input [7:0] in_y,
    output [15:0] p
);

    assign p = in_x * in_y;

endmodule
