`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 14:08:24
// Design Name: 
// Module Name: pwm
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


module pwm #(parameter N=10)(
input wire clk,
      wire [N-1:0] compare,
      wire [N-1:0] overflow,
      wire rst,
output reg PWM_1
    );
    
   reg [N-1:0] count;
    
   
   
    always @(posedge clk) begin
    if ( rst) begin
    count <= 0;
    PWM_1 <= 0;
    end 
    else begin
        if (count == overflow) begin
        count <= 0;
        PWM_1 <= 1'b1;   
    end
        else begin
            if ( count == compare) begin
            PWM_1 <= 1'b0;
            end
            count <= count + 1'b1;
            end
        end
    end
endmodule

