`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 14:11:42
// Design Name: 
// Module Name: pwm_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_tb;
    parameter N = 10;
    
    reg clk;
    reg rst;
    reg [N-1:0] compare;
    reg [N-1:0] overflow;
    wire [3:0] PWM_1;
    
    // Instantiate the top_pwm module
    top_pwm #(.N(N)) uut (
        .clk(clk),
        .rst(rst),
        .compare(compare),
        .overflow(overflow),
        .PWM_1(PWM_1)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10 ns period (100 MHz clock)
    
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        compare = 0;
        overflow = 0;
        

        #20;
        rst = 0;
        compare = 10;
        overflow = 20;

        #500;
        rst = 1;
        #20;
        rst = 0;
        compare = 5;
        overflow = 20;
        
        #500;
    end
    
endmodule
