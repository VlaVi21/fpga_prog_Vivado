`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 17:47:52
// Design Name: 
// Module Name: rtf_less2
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


module rtf_less2 #(parameter N = 16)(
    input wire clk,
    input wire rst,
    
    input wire [N-1:0] compare,
    input wire [N-1:0] overflow,
    output reg pwm
    
    );
    
    reg [N-1:0] count;
    

    always @(posedge clk)begin
        if (rst == 1'b1)begin
            count <= 0;
            pwm <= 0;   
        end
        else begin
            if(count == overflow) begin
            count <= 0;
            pwm <= 1;
        end
        else begin
            if(count == compare)begin
                pwm <= 1'b0;
                count <= count + 1'b1;
            end
         end 
      end
  end
       
endmodule
