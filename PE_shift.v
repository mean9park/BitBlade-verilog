`timescale 1ns / 1ps

module PE_shift(
    input clk,
    input reset,
    input [9:0] PE_sum_in,
    input [3:0] signal,
    
    output [19:0] shifted_PE_sum
);

//    PE_sum_in is 10bit(3bit X 3bit) and the maximum shift value is 12bit
//    But, in this architecture, output only needs 4 the LSB bit(2 MSB bit is just sign extension)
//    So, I can reduce here.
//    ex ) Not MSB part, input = 000, 001, 010, 011 -> possible output = 0 ~ +9 : 4bit is enough
//         MSB Part, input = 000, 001, 110, 111 -> possible output = -2 ~ +4 : 4bit is enough
//    Therefore, here, the number of bit of product is just 16bit which is 12bit(shift) + 4bit(output bit)

    //sign extension and shift it
    assign shifted_PE_sum = { {10{PE_sum_in[9]}}, PE_sum_in } << (signal);
    
endmodule
