 `timescale 1ns / 1ps

module Labs_4_Filt(
    input wire clk ,rst,
    input wire enable,
    input wire signed [15:0] x,
    output wire signed [32:0] Sum 
    );
    
    localparam N = 31;

    reg signed [15:0] delay [0:N-1];      
    reg signed [32:0] sum;              
    reg signed [15:0] COEFFICIENTS [0:N-1]; 

    wire signed [31:0] acc [0:N-1];        
    wire signed [32:0] current_sum;      
    wire signed [32:0] partial_sum [0:N-1];

    integer i;

    initial begin
        COEFFICIENTS[0] = ; 
        COEFFICIENTS[1] = ; 
        COEFFICIENTS[2] = ; 
        COEFFICIENTS[3] = ; 
        COEFFICIENTS[4] = ; 
        COEFFICIENTS[5] = ; 
        COEFFICIENTS[6] = ; 
        COEFFICIENTS[7] = ; 
        COEFFICIENTS[8] = ; 
        COEFFICIENTS[9] = ; 
        COEFFICIENTS[10] = ; 
        COEFFICIENTS[11] = ; 
        COEFFICIENTS[12] = ; 
        COEFFICIENTS[13] = ; 
        COEFFICIENTS[14] = ; 
        COEFFICIENTS[15] = ; 
        COEFFICIENTS[16] = ; 
        COEFFICIENTS[17] = ; 
        COEFFICIENTS[18] = ; 
        COEFFICIENTS[19] = ;
        COEFFICIENTS[20] = ; 
        COEFFICIENTS[21] = ; 
        COEFFICIENTS[22] = ; 
        COEFFICIENTS[23] = ; 
        COEFFICIENTS[24] = ; 
        COEFFICIENTS[25] = ; 
        COEFFICIENTS[26] = ; 
        COEFFICIENTS[27] = ; 
        COEFFICIENTS[28] = ; 
        COEFFICIENTS[29] = ;
        COEFFICIENTS[30] = ; 
        COEFFICIENTS[31] = ;
    end


    always@(posedge clk or negedge rst) begin
        if (~rst) begin
            for (i = 0; i < N; i = i + 1) delay[i] <= 0;
        end
        else if (enable) begin
         delay[0] <= x; 
            for (i = 1; i < 20; i = i + 1) delay[i] <= delay[i-1];
        end
    end


    generate 
        for (genvar i = 0; i < N; i = i + 1) begin : MULT_GEN
            assign acc[i] = delay[i] * COEFFICIENTS[i];
        end
    endgenerate


    generate
        assign partial_sum[0] = acc[0]; 
        for (genvar i = 1; i < N; i = i + 1) begin : SUM_CASCADE_GEN
            assign partial_sum[i] = partial_sum[i-1] + acc[i];
        end
    endgenerate


    assign current_sum = partial_sum[31];

    always@(posedge clk or negedge rst) begin
        if (~rst) begin
            sum <= 0;
        end 
        else if (enable) begin
            sum <= current_sum; 
        end
    end

 
    assign Sum = sum >>> 15;

endmodule