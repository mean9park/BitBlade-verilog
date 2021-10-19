`timescale 1ns / 1ps

module ACC_shift(
    input clk,
    input reset,
    
    input [19:0] shifted_PE_sum_1, shifted_PE_sum_2, shifted_PE_sum_3, shifted_PE_sum_4, shifted_PE_sum_5, shifted_PE_sum_6, shifted_PE_sum_7, shifted_PE_sum_8, 
    shifted_PE_sum_9, shifted_PE_sum_10, shifted_PE_sum_11, shifted_PE_sum_12, shifted_PE_sum_13, shifted_PE_sum_14, shifted_PE_sum_15, shifted_PE_sum_16, 
    
    output [19:0] total_PE_sum
);

    wire [19:0] summation_1;
    wire [19:0] summation_2;
    wire [19:0] summation_3;
    wire [19:0] summation_4;

//    assign summation_1 = shifted_PE_sum_1 + shifted_PE_sum_2 + shifted_PE_sum_3 + shifted_PE_sum_4;
//    assign summation_2 = shifted_PE_sum_5 + shifted_PE_sum_6 + shifted_PE_sum_7 + shifted_PE_sum_8;
//    assign summation_3 = shifted_PE_sum_9 + shifted_PE_sum_10 + shifted_PE_sum_11 + shifted_PE_sum_12;
//    assign summation_4 = shifted_PE_sum_13 + shifted_PE_sum_14 + shifted_PE_sum_15 + shifted_PE_sum_16;

//    assign total_PE_sum = summation_1 + summation_2 + summation_3 + summation_4;

    assign total_PE_sum = shifted_PE_sum_1 + shifted_PE_sum_2 + shifted_PE_sum_3 + shifted_PE_sum_4 + 
                            shifted_PE_sum_5 + shifted_PE_sum_6 + shifted_PE_sum_7 + shifted_PE_sum_8 + 
                            shifted_PE_sum_9 + shifted_PE_sum_10 + shifted_PE_sum_11 + shifted_PE_sum_12 + 
                            shifted_PE_sum_13 + shifted_PE_sum_14 + shifted_PE_sum_15 + shifted_PE_sum_16;
endmodule
