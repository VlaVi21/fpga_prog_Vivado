`timescale 1ns / 1ps
module Labs_4_fl_tb();
    
    reg clk, rst;
    reg [15:0] x;
    wire [31:0] Sum;
    
    
    initial begin
    clk = 0;
    rst = 0;
    x = 0;
    end
    initial begin
        forever #5 clk = ~clk;
    end 
    
        initial begin
        #0 rst = 0;
        #10 rst = 1;

       
    end 
    initial begin
        #50 x = 0;
        #10 x = 1;
        #10 x = 0;
        end
        
        
    Labs_4_Filt DUT (
    .clk (clk),
    .rst (rst),
    .x (x),
    .Sum (Sum)
    ); 

endmodule
