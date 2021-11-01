`timescale 1ns / 1ps

module BitBlade_column(
    input clk,
    input reset,
    
    // Input data comes from the BUFFER outside the total architecture
    // Output comes from the BUFFER which is near the PE!!!
    input [31:0] packed_input_1, packed_input_2, packed_input_3, packed_input_4, packed_input_5, packed_input_6, packed_input_7, packed_input_8, 
    packed_input_9, packed_input_10, packed_input_11, packed_input_12, packed_input_13, packed_input_14, packed_input_15, packed_input_16,  
     
    input [31:0] WBUF_data_in_1, WBUF_data_in_2, WBUF_data_in_3, WBUF_data_in_4, WBUF_data_in_5, WBUF_data_in_6, WBUF_data_in_7, WBUF_data_in_8, 
    WBUF_data_in_9, WBUF_data_in_10, WBUF_data_in_11, WBUF_data_in_12, WBUF_data_in_13, WBUF_data_in_14, WBUF_data_in_15, WBUF_data_in_16,
    
    /// Really Global      
    input [3:0] sign_x,
    input [3:0] sign_y,
    input [47:0] signal,
    input [1:0] input_bitwidth,
    
    output [27:0] total_output
);

    wire [9:0] PE_sum_1, PE_sum_2, PE_sum_3, PE_sum_4, PE_sum_5, PE_sum_6, PE_sum_7, PE_sum_8, 
    PE_sum_9, PE_sum_10, PE_sum_11, PE_sum_12, PE_sum_13, PE_sum_14, PE_sum_15, PE_sum_16;
    
    wire [9:0] PE_sum_out_1, PE_sum_out_2, PE_sum_out_3, PE_sum_out_4, PE_sum_out_5, PE_sum_out_6, PE_sum_out_7, PE_sum_out_8, 
    PE_sum_out_9, PE_sum_out_10, PE_sum_out_11, PE_sum_out_12, PE_sum_out_13, PE_sum_out_14, PE_sum_out_15, PE_sum_out_16;  
    
    wire [19:0] shifted_PE_sum_1, shifted_PE_sum_2, shifted_PE_sum_3, shifted_PE_sum_4, shifted_PE_sum_5, shifted_PE_sum_6, shifted_PE_sum_7, shifted_PE_sum_8, 
    shifted_PE_sum_9, shifted_PE_sum_10, shifted_PE_sum_11, shifted_PE_sum_12, shifted_PE_sum_13, shifted_PE_sum_14, shifted_PE_sum_15, shifted_PE_sum_16;
    
    wire [31:0] WBUF_data_out_1, WBUF_data_out_2, WBUF_data_out_3, WBUF_data_out_4, WBUF_data_out_5, WBUF_data_out_6, WBUF_data_out_7, WBUF_data_out_8, 
    WBUF_data_out_9, WBUF_data_out_10, WBUF_data_out_11, WBUF_data_out_12, WBUF_data_out_13, WBUF_data_out_14, WBUF_data_out_15, WBUF_data_out_16;
    
    wire [31:0] sorted_weight_1, sorted_weight_2, sorted_weight_3, sorted_weight_4, sorted_weight_5, sorted_weight_6, sorted_weight_7, sorted_weight_8, 
    sorted_weight_9, sorted_weight_10, sorted_weight_11, sorted_weight_12, sorted_weight_13, sorted_weight_14, sorted_weight_15, sorted_weight_16;
    
    wire [31:0] packed_weight_1, packed_weight_2, packed_weight_3, packed_weight_4, packed_weight_5, packed_weight_6, packed_weight_7, packed_weight_8, 
    packed_weight_9, packed_weight_10, packed_weight_11, packed_weight_12, packed_weight_13, packed_weight_14, packed_weight_15, packed_weight_16;

    // In Bit Blade, Bitwise packaing happens bitween MUX_REG & PE
    // But since there's only one wire_packing module here, 
    // It's written the top.   
    // !!!!!!!!!!!!!Wire Packing!!!!
    Weight_Wire_packing Weight_Wire_packing_all( .clk(clk), .reset(reset), 
    .sorted_weight_1(sorted_weight_1), .sorted_weight_2(sorted_weight_2), .sorted_weight_3(sorted_weight_3), .sorted_weight_4(sorted_weight_4), 
    .sorted_weight_5(sorted_weight_5), .sorted_weight_6(sorted_weight_6), .sorted_weight_7(sorted_weight_7), .sorted_weight_8(sorted_weight_8), 
    .sorted_weight_9(sorted_weight_9), .sorted_weight_10(sorted_weight_10), .sorted_weight_11(sorted_weight_11), .sorted_weight_12(sorted_weight_12), 
    .sorted_weight_13(sorted_weight_13), .sorted_weight_14(sorted_weight_14), .sorted_weight_15(sorted_weight_15), .sorted_weight_16(sorted_weight_16), 

    .packed_weight_1(packed_weight_1), .packed_weight_2(packed_weight_2), .packed_weight_3(packed_weight_3), .packed_weight_4(packed_weight_4),
    .packed_weight_5(packed_weight_5), .packed_weight_6(packed_weight_6), .packed_weight_7(packed_weight_7), .packed_weight_8(packed_weight_8), 
    .packed_weight_9(packed_weight_9), .packed_weight_10(packed_weight_10), .packed_weight_11(packed_weight_11), .packed_weight_12(packed_weight_12), 
    .packed_weight_13(packed_weight_13), .packed_weight_14(packed_weight_14), .packed_weight_15(packed_weight_15), .packed_weight_16(packed_weight_16)
);

    // Weight --> BUF_32bit --> MUX_REG --> PE --> PE_REG
    BUF_32bit WBUF_1(.clk(clk), .reset(reset), .data_in(WBUF_data_in_1), .data_out(WBUF_data_out_1));
    Weight_MUX_REG Weight_MUX_REG_1(.clk(clk), .reset(reset), .buffer(WBUF_data_out_1), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_1));
    PE PE_1(.clk(clk), .reset(reset), .x(packed_input_1), .y(packed_weight_1), .sign_x(sign_x[0]), .sign_y(sign_y[0]), .PE_sum(PE_sum_1) );
    PE_register PE_reg_1(.clk(clk), .reset(reset), .PE_sum(PE_sum_1), .PE_sum_out(PE_sum_out_1) );
    PE_shift PE_shift_1( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_1), .signal(signal[2:0]), .shifted_PE_sum(shifted_PE_sum_1) );
    
    BUF_32bit WBUF_2(.clk(clk), .reset(reset), .data_in(WBUF_data_in_2), .data_out(WBUF_data_out_2));
    Weight_MUX_REG Weight_MUX_REG_2(.clk(clk), .reset(reset), .buffer(WBUF_data_out_2), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_2));
    PE PE_2(.clk(clk), .reset(reset), .x(packed_input_2), .y(packed_weight_2), .sign_x(sign_x[0]), .sign_y(sign_y[1]), .PE_sum(PE_sum_2) );
    PE_register PE_reg_2(.clk(clk), .reset(reset), .PE_sum(PE_sum_2), .PE_sum_out(PE_sum_out_2) );
    PE_shift PE_shift_2( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_2), .signal(signal[5:3]), .shifted_PE_sum(shifted_PE_sum_2) );
    
    BUF_32bit WBUF_3(.clk(clk), .reset(reset), .data_in(WBUF_data_in_3), .data_out(WBUF_data_out_3));
    Weight_MUX_REG Weight_MUX_REG_3(.clk(clk), .reset(reset), .buffer(WBUF_data_out_3), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_3));
    PE PE_3(.clk(clk), .reset(reset), .x(packed_input_3), .y(packed_weight_3), .sign_x(sign_x[0]), .sign_y(sign_y[2]), .PE_sum(PE_sum_3) );
    PE_register PE_reg_3(.clk(clk), .reset(reset), .PE_sum(PE_sum_3), .PE_sum_out(PE_sum_out_3) );
    PE_shift PE_shift_3( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_3), .signal(signal[8:6]), .shifted_PE_sum(shifted_PE_sum_3) );
    
    BUF_32bit WBUF_4(.clk(clk), .reset(reset), .data_in(WBUF_data_in_4), .data_out(WBUF_data_out_4));
    Weight_MUX_REG Weight_MUX_REG_4(.clk(clk), .reset(reset), .buffer(WBUF_data_out_4), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_4));
    PE PE_4(.clk(clk), .reset(reset), .x(packed_input_4), .y(packed_weight_4), .sign_x(sign_x[0]), .sign_y(sign_y[3]), .PE_sum(PE_sum_4) );
    PE_register PE_reg_4(.clk(clk), .reset(reset), .PE_sum(PE_sum_4), .PE_sum_out(PE_sum_out_4) );
    PE_shift PE_shift_4( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_4), .signal(signal[11:9]), .shifted_PE_sum(shifted_PE_sum_4) );
    
    BUF_32bit WBUF_5(.clk(clk), .reset(reset), .data_in(WBUF_data_in_5), .data_out(WBUF_data_out_5));
    Weight_MUX_REG Weight_MUX_REG_5(.clk(clk), .reset(reset), .buffer(WBUF_data_out_5), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_5));
    PE PE_5(.clk(clk), .reset(reset), .x(packed_input_5), .y(packed_weight_5), .sign_x(sign_x[1]), .sign_y(sign_y[0]), .PE_sum(PE_sum_5) );
    PE_register PE_reg_5(.clk(clk), .reset(reset), .PE_sum(PE_sum_5), .PE_sum_out(PE_sum_out_5) );
    PE_shift PE_shift_5( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_5), .signal(signal[14:12]), .shifted_PE_sum(shifted_PE_sum_5) );
    
    BUF_32bit WBUF_6(.clk(clk), .reset(reset), .data_in(WBUF_data_in_6), .data_out(WBUF_data_out_6));
    Weight_MUX_REG Weight_MUX_REG_6(.clk(clk), .reset(reset), .buffer(WBUF_data_out_6), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_6));
    PE PE_6(.clk(clk), .reset(reset), .x(packed_input_6), .y(packed_weight_6), .sign_x(sign_x[1]), .sign_y(sign_y[1]), .PE_sum(PE_sum_6) );
    PE_register PE_reg_6(.clk(clk), .reset(reset), .PE_sum(PE_sum_6), .PE_sum_out(PE_sum_out_6) );
    PE_shift PE_shift_6( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_6), .signal(signal[17:15]), .shifted_PE_sum(shifted_PE_sum_6) );
    
    BUF_32bit WBUF_7(.clk(clk), .reset(reset), .data_in(WBUF_data_in_7), .data_out(WBUF_data_out_7));
    Weight_MUX_REG Weight_MUX_REG_7(.clk(clk), .reset(reset), .buffer(WBUF_data_out_7), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_7));
    PE PE_7(.clk(clk), .reset(reset), .x(packed_input_7), .y(packed_weight_7), .sign_x(sign_x[1]), .sign_y(sign_y[2]), .PE_sum(PE_sum_7) );
    PE_register PE_reg_7(.clk(clk), .reset(reset), .PE_sum(PE_sum_7), .PE_sum_out(PE_sum_out_7) );
    PE_shift PE_shift_7( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_7), .signal(signal[20:18]), .shifted_PE_sum(shifted_PE_sum_7) );
    
    BUF_32bit WBUF_8(.clk(clk), .reset(reset), .data_in(WBUF_data_in_8), .data_out(WBUF_data_out_8));
    Weight_MUX_REG Weight_MUX_REG_8(.clk(clk), .reset(reset), .buffer(WBUF_data_out_8), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_8));
    PE PE_8(.clk(clk), .reset(reset), .x(packed_input_8), .y(packed_weight_8), .sign_x(sign_x[1]), .sign_y(sign_y[3]), .PE_sum(PE_sum_8) );
    PE_register PE_reg_8(.clk(clk), .reset(reset), .PE_sum(PE_sum_8), .PE_sum_out(PE_sum_out_8) );
    PE_shift PE_shift_8( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_8), .signal(signal[23:21]), .shifted_PE_sum(shifted_PE_sum_8) );
    
    BUF_32bit WBUF_9(.clk(clk), .reset(reset), .data_in(WBUF_data_in_9), .data_out(WBUF_data_out_9));
    Weight_MUX_REG Weight_MUX_REG_9(.clk(clk), .reset(reset), .buffer(WBUF_data_out_9), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_9));
    PE PE_9(.clk(clk), .reset(reset), .x(packed_input_9), .y(packed_weight_9), .sign_x(sign_x[2]), .sign_y(sign_y[0]), .PE_sum(PE_sum_9) );
    PE_register PE_reg_9(.clk(clk), .reset(reset), .PE_sum(PE_sum_9), .PE_sum_out(PE_sum_out_9) );
    PE_shift PE_shift_9( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_9), .signal(signal[26:24]), .shifted_PE_sum(shifted_PE_sum_9) );
    
    BUF_32bit WBUF_10(.clk(clk), .reset(reset), .data_in(WBUF_data_in_10), .data_out(WBUF_data_out_10));
    Weight_MUX_REG Weight_MUX_REG_10(.clk(clk), .reset(reset), .buffer(WBUF_data_out_10), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_10));
    PE PE_10(.clk(clk), .reset(reset), .x(packed_input_10), .y(packed_weight_10), .sign_x(sign_x[2]), .sign_y(sign_y[1]), .PE_sum(PE_sum_10) );
    PE_register PE_reg_10(.clk(clk), .reset(reset), .PE_sum(PE_sum_10), .PE_sum_out(PE_sum_out_10) );
    PE_shift PE_shift_10( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_10), .signal(signal[29:27]), .shifted_PE_sum(shifted_PE_sum_10) );
    
    BUF_32bit WBUF_11(.clk(clk), .reset(reset), .data_in(WBUF_data_in_11), .data_out(WBUF_data_out_11));
    Weight_MUX_REG Weight_MUX_REG_11(.clk(clk), .reset(reset), .buffer(WBUF_data_out_11), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_11));
    PE PE_11(.clk(clk), .reset(reset), .x(packed_input_11), .y(packed_weight_11), .sign_x(sign_x[2]), .sign_y(sign_y[2]), .PE_sum(PE_sum_11) );
    PE_register PE_reg_11(.clk(clk), .reset(reset), .PE_sum(PE_sum_11), .PE_sum_out(PE_sum_out_11) );
    PE_shift PE_shift_11( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_11), .signal(signal[32:30]), .shifted_PE_sum(shifted_PE_sum_11) );
    
    BUF_32bit WBUF_12(.clk(clk), .reset(reset), .data_in(WBUF_data_in_12), .data_out(WBUF_data_out_12));
    Weight_MUX_REG Weight_MUX_REG_12(.clk(clk), .reset(reset), .buffer(WBUF_data_out_12), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_12));
    PE PE_12(.clk(clk), .reset(reset), .x(packed_input_12), .y(packed_weight_12), .sign_x(sign_x[2]), .sign_y(sign_y[3]), .PE_sum(PE_sum_12) );
    PE_register PE_reg_12(.clk(clk), .reset(reset), .PE_sum(PE_sum_12), .PE_sum_out(PE_sum_out_12) );
    PE_shift PE_shift_12( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_12), .signal(signal[35:33]), .shifted_PE_sum(shifted_PE_sum_12) );
    
    BUF_32bit WBUF_13(.clk(clk), .reset(reset), .data_in(WBUF_data_in_13), .data_out(WBUF_data_out_13));
    Weight_MUX_REG Weight_MUX_REG_13(.clk(clk), .reset(reset), .buffer(WBUF_data_out_13), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_13));
    PE PE_13(.clk(clk), .reset(reset), .x(packed_input_13), .y(packed_weight_13), .sign_x(sign_x[3]), .sign_y(sign_y[0]), .PE_sum(PE_sum_13) );
    PE_register PE_reg_13(.clk(clk), .reset(reset), .PE_sum(PE_sum_13), .PE_sum_out(PE_sum_out_13) );
    PE_shift PE_shift_13( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_13), .signal(signal[38:36]), .shifted_PE_sum(shifted_PE_sum_13) );
    
    BUF_32bit WBUF_14(.clk(clk), .reset(reset), .data_in(WBUF_data_in_14), .data_out(WBUF_data_out_14));
    Weight_MUX_REG Weight_MUX_REG_14(.clk(clk), .reset(reset), .buffer(WBUF_data_out_14), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_14));
    PE PE_14(.clk(clk), .reset(reset), .x(packed_input_14), .y(packed_weight_14), .sign_x(sign_x[3]), .sign_y(sign_y[1]), .PE_sum(PE_sum_14) );
    PE_register PE_reg_14(.clk(clk), .reset(reset), .PE_sum(PE_sum_14), .PE_sum_out(PE_sum_out_14) );
    PE_shift PE_shift_14( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_14), .signal(signal[41:39]), .shifted_PE_sum(shifted_PE_sum_14) );
    
    BUF_32bit WBUF_15(.clk(clk), .reset(reset), .data_in(WBUF_data_in_15), .data_out(WBUF_data_out_15));
    Weight_MUX_REG Weight_MUX_REG_15(.clk(clk), .reset(reset), .buffer(WBUF_data_out_15), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_15));
    PE PE_15(.clk(clk), .reset(reset), .x(packed_input_15), .y(packed_weight_15), .sign_x(sign_x[3]), .sign_y(sign_y[2]), .PE_sum(PE_sum_15) );
    PE_register PE_reg_15(.clk(clk), .reset(reset), .PE_sum(PE_sum_15), .PE_sum_out(PE_sum_out_15) );
    PE_shift PE_shift_15( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_15), .signal(signal[44:42]), .shifted_PE_sum(shifted_PE_sum_15) );
    
    BUF_32bit WBUF_16(.clk(clk), .reset(reset), .data_in(WBUF_data_in_16), .data_out(WBUF_data_out_16));
    Weight_MUX_REG Weight_MUX_REG_16(.clk(clk), .reset(reset), .buffer(WBUF_data_out_16), .input_bitwidth(input_bitwidth), .sorted_data(sorted_weight_16));
    PE PE_16(.clk(clk), .reset(reset), .x(packed_input_16), .y(packed_weight_16), .sign_x(sign_x[3]), .sign_y(sign_y[3]), .PE_sum(PE_sum_16) );
    PE_register PE_reg_16(.clk(clk), .reset(reset), .PE_sum(PE_sum_16), .PE_sum_out(PE_sum_out_16) );
    PE_shift PE_shift_16( .clk(clk), .reset(reset), .PE_sum_in(PE_sum_out_16), .signal(signal[47:45]), .shifted_PE_sum(shifted_PE_sum_16) );
    
    wire [19:0] total_PE_sum;

    wire [19:0] total_PE_sum_out;
    
    ACC_shift accumulator_shift( .clk(clk), .reset(reset),    
    .shifted_PE_sum_1(shifted_PE_sum_1), .shifted_PE_sum_2(shifted_PE_sum_2), .shifted_PE_sum_3(shifted_PE_sum_3), .shifted_PE_sum_4(shifted_PE_sum_4), 
    .shifted_PE_sum_5(shifted_PE_sum_5), .shifted_PE_sum_6(shifted_PE_sum_6), .shifted_PE_sum_7(shifted_PE_sum_7), .shifted_PE_sum_8(shifted_PE_sum_8), 
    .shifted_PE_sum_9(shifted_PE_sum_9), .shifted_PE_sum_10(shifted_PE_sum_10), .shifted_PE_sum_11(shifted_PE_sum_11), .shifted_PE_sum_12(shifted_PE_sum_12), 
    .shifted_PE_sum_13(shifted_PE_sum_13), .shifted_PE_sum_14(shifted_PE_sum_14), .shifted_PE_sum_15(shifted_PE_sum_15), .shifted_PE_sum_16(shifted_PE_sum_16), 
    
    .total_PE_sum(total_PE_sum)
    );
	
    ACC_register acc_reg(.clk(clk), .reset(reset), .acc_in(total_PE_sum), .acc_out(total_PE_sum_out));

    ACC accumulator(.clk(clk), .reset(reset), .PE_sum(total_PE_sum_out), .total_output(total_output) );
//    ACC accumulator(.clk(clk), .reset(reset), .PE_sum(total_PE_sum), .total_output(total_output) );

endmodule
