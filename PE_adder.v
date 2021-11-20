`timescale 1ns / 1ps

module PE_adder(p_0, p_1, p_2, p_3, p_4, p_5, p_6, p_7, p_8, p_9, p_10, p_11, p_12, p_13, p_14, p_15, PE_sum); 
    input [5:0] p_0;
    input [5:0] p_1;
    input [5:0] p_2;
    input [5:0] p_3;
    input [5:0] p_4;
    input [5:0] p_5;
    input [5:0] p_6;
    input [5:0] p_7;
    input [5:0] p_8;
    input [5:0] p_9;
    input [5:0] p_10;
    input [5:0] p_11;
    input [5:0] p_12;
    input [5:0] p_13;
    input [5:0] p_14;
    input [5:0] p_15;
    
    output [9:0] PE_sum;

    // !!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!
    // p_0 ~ p_15 : 6bit(signed 3bit X 3bit)
    // But it doesn't actually require 6bit, only 4 bit is needed.
    // So here, I'm jusing extending 2 bits instead of 4 bit 
    // that's enough and It's prolly what the paper say in the table? about the bit. 
    wire [9:0] p_extend [15:0]; 
    
    assign p_extend[0] = { {4{p_0[5]}}, p_0 };
    assign p_extend[1] = { {4{p_1[5]}}, p_1 };
    assign p_extend[2] = { {4{p_2[5]}}, p_2 };
    assign p_extend[3] = { {4{p_3[5]}}, p_3 };
    assign p_extend[4] = { {4{p_4[5]}}, p_4 };
    assign p_extend[5] = { {4{p_5[5]}}, p_5 };
    assign p_extend[6] = { {4{p_6[5]}}, p_6 };
    assign p_extend[7] = { {4{p_7[5]}}, p_7 };
    assign p_extend[8] = { {4{p_8[5]}}, p_8 };
    assign p_extend[9] = { {4{p_9[5]}}, p_9 };
    assign p_extend[10] = { {4{p_10[5]}}, p_10 };
    assign p_extend[11] = { {4{p_11[5]}}, p_11 };
    assign p_extend[12] = { {4{p_12[5]}}, p_12 };
    assign p_extend[13] = { {4{p_13[5]}}, p_13 };
    assign p_extend[14] = { {4{p_14[5]}}, p_14 };
    assign p_extend[15] = { {4{p_15[5]}}, p_15 };
    
    wire [9:0] adder_1; 
    wire [9:0] adder_2;
    wire [9:0] adder_3;
    wire [9:0] adder_4;
    
    assign adder_1 = p_extend[0] + p_extend[1] + p_extend[2] + p_extend[3]; 
    assign adder_2 = p_extend[4] + p_extend[5] + p_extend[6] + p_extend[7]; 
    assign adder_3 = p_extend[8] + p_extend[9] + p_extend[10] + p_extend[11]; 
    assign adder_4 = p_extend[12] + p_extend[13] + p_extend[14] + p_extend[15]; 
    
    assign PE_sum =  adder_1 + adder_2 + adder_3 + adder_4;
    
endmodule
