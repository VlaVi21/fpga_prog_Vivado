`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 14:08:52
// Design Name: 
// Module Name: top_pwm
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


module top_pwm  #(parameter N=10)(
input wire clk,
      wire rst,
output wire [3:0] PWM_1 
);
   reg [N-1:0] compr [3:0]; //= {10'h200, 10'h150, 10'h100, 10'h07f};
   initial begin
   compr[0] = 10'h07f;
   compr[1] = 10'h150;
   compr[2] = 10'h200;
   compr[3] = 10'h250;
   end
  
   reg [22:0] count;
   reg en;
   
//eнебл, умова = 1
    always @(posedge clk)begin
        if(rst) begin
            en <=0;
            en <= 1'b0;
        end
        else begin
            if (count != 7812500)begin
                count <= count + 1'b1;
                en <= 1'b0;
                
            end
            else begin
                en <= 1'b1;
                count <= 0;
            end
            if (en) begin
               compr[0] <= compr[1];
               compr[1] <= compr[2];
               compr[2] <= compr[3];
               compr[3] <= compr[0];
            end
         end
      end
    
   genvar g;
   
   generate 
    for (g = 0; g < 4; g = g + 1) begin : pwm_gen
        pwm #(.N(N)) pwm_inst (
    .clk(clk),
    .compare(compr[g]),
    .overflow(10'h250),
    .rst(rst),
    .PWM_1(PWM_1[g])
   );
   end
endgenerate
    
endmodule