`timescale 1ns / 1ps

// [Fusion Unit]
//  4 X 4 bitbricks + (4 x 4 shift)
//  17-way adder tree
//  output = p_5 p_4 p_3 p_2 p_1 p_0 (6bit)

module PE(clk, reset, x, y, sign_x, sign_y, PE_sum);
    input wire clk;
    input wire reset;
    input wire [31:0] x; 
    input wire [31:0] y;
    
    // one position -> one sign information
    input wire sign_x;
    input wire sign_y;
    
    // BB : 6bit
    // 16 BBs -> up to 10bit
    // 16 PEs -> up to 14bit
    
    output reg [9:0] PE_sum;
    
    wire [5:0] p [15:0];
    
    bitbrick BB1(.clk(clk), .reset(reset), .x(x[1:0]), .y(y[1:0]), .sign_x(sign_x), .sign_y(sign_y), .p(p[0]));
    bitbrick BB2(.clk(clk), .reset(reset), .x(x[3:2]), .y(y[3:2]), .sign_x(sign_x), .sign_y(sign_y), .p(p[1]));
    bitbrick BB3(.clk(clk), .reset(reset), .x(x[5:4]), .y(y[5:4]), .sign_x(sign_x), .sign_y(sign_y), .p(p[2]));
    bitbrick BB4(.clk(clk), .reset(reset), .x(x[7:6]), .y(y[7:6]), .sign_x(sign_x), .sign_y(sign_y), .p(p[3]));
    bitbrick BB5(.clk(clk), .reset(reset), .x(x[9:8]), .y(y[9:8]), .sign_x(sign_x), .sign_y(sign_y), .p(p[4]));
    bitbrick BB6(.clk(clk), .reset(reset), .x(x[11:10]), .y(y[11:10]), .sign_x(sign_x), .sign_y(sign_y), .p(p[5]));
    bitbrick BB7(.clk(clk), .reset(reset), .x(x[13:12]), .y(y[13:12]), .sign_x(sign_x), .sign_y(sign_y), .p(p[6]));
    bitbrick BB8(.clk(clk), .reset(reset), .x(x[15:14]), .y(y[15:14]), .sign_x(sign_x), .sign_y(sign_y), .p(p[7]));
    
    bitbrick BB9(.clk(clk), .reset(reset), .x(x[17:16]), .y(y[17:16]), .sign_x(sign_x), .sign_y(sign_y), .p(p[8]));
    bitbrick BB10(.clk(clk), .reset(reset), .x(x[19:18]), .y(y[19:18]), .sign_x(sign_x), .sign_y(sign_y), .p(p[9]));
    bitbrick BB11(.clk(clk), .reset(reset), .x(x[21:20]), .y(y[21:20]), .sign_x(sign_x), .sign_y(sign_y), .p(p[10]));
    bitbrick BB12(.clk(clk), .reset(reset), .x(x[23:22]), .y(y[23:22]), .sign_x(sign_x), .sign_y(sign_y), .p(p[11]));
    bitbrick BB13(.clk(clk), .reset(reset), .x(x[25:24]), .y(y[25:24]), .sign_x(sign_x), .sign_y(sign_y), .p(p[12]));
    bitbrick BB14(.clk(clk), .reset(reset), .x(x[27:26]), .y(y[27:26]), .sign_x(sign_x), .sign_y(sign_y), .p(p[13]));
    bitbrick BB15(.clk(clk), .reset(reset), .x(x[29:28]), .y(y[29:28]), .sign_x(sign_x), .sign_y(sign_y), .p(p[14]));
    bitbrick BB16(.clk(clk), .reset(reset), .x(x[31:30]), .y(y[31:30]), .sign_x(sign_x), .sign_y(sign_y), .p(p[15]));
    
    PE_adder ADDER_TREE(
    .p_0(p[0]), 
    .p_1(p[1]), 
    .p_2(p[2]), 
    .p_3(p[3]), 
    .p_4(p[4]), 
    .p_5(p[5]), 
    .p_6(p[6]), 
    .p_7(p[7]), 
    .p_8(p[8]), 
    .p_9(p[9]), 
    .p_10(p[10]), 
    .p_11(p[11]), 
    .p_12(p[12]), 
    .p_13(p[13]), 
    .p_14(p[14]), 
    .p_15(p[15]), 
    
    .PE_sum(PE_sum)
    );
 
endmodule

    
