`timescale 1ns / 1ps

// Because it's register(small buffer), 
// we have set the PE_sum_out as reg(registerd)

module PE_register(
    input clk,
    input reset,
    
    input [9:0] PE_sum, 
    output reg [9:0] PE_sum_out
);
    
    always @ (posedge clk)
    if (reset)
        PE_sum_out <= 0;
    else
        PE_sum_out <= PE_sum;
        
endmodule
