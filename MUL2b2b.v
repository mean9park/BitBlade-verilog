`timescale 1ns / 1ps

// [BitBrick]
//  input : x_0 x_1 (2bit) *   y_1 y_0 (2bit)
//  add sign and MUL (signed 3bit * 3bit)
//  output = p_5 p_4 p_3 p_2 p_1 p_0 (6bit)

module MUL2b2b(
    input clk,
    input reset,
    input [1:0] x, 
    input [1:0] y,
    output [3:0] p
    );

    assign p = x*y;

    /* signed_3bit_MUL MUL_3bit(.in_x(in_x), .in_y(in_y), .p(p)); */
        
endmodule

    
