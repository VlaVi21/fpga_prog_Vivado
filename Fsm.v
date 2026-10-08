`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 19:16:55
// Design Name: 
// Module Name: Fsm
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


 module Fsm (
    input wire clk,
    input wire rst,
    output reg [3:0] leds
);

    reg [1:0] state;           
    reg [3:0] pwm;         
    reg [23:0] cnt;
    always @(posedge clk) begin
        if (rst) begin
            state <= 0;
            cnt <= 0;
        end else begin
           cnt <= cnt + 1;
            if (cnt == 7812500 ) begin
                cnt <= 0;
                state <= state + 1;
            end
        end
    end

    
    always @(posedge clk) begin
        if (rst)
            pwm <= 0;
        else
            pwm <= pwm + 1;
    end

    
    always @(posedge clk) begin
        case (state)
            2'd0: leds = (pwm < 4)  ? 4'b1111 : 4'b0000;  
            2'd1: leds = (pwm < 8)  ? 4'b1111 : 4'b0000; 
            2'd2: leds = (pwm < 12) ? 4'b1111 : 4'b0000;  
            2'd3: leds = (pwm < 15) ? 4'b1111 : 4'b0000;  
        endcase
    end

endmodule

