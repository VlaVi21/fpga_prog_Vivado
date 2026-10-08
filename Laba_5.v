`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2025 14:41:14
// Design Name: 
// Module Name: Laba_5
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


module Laba_5(
    input wire clk,             // Тактовий сигнал
    input wire rst_n,           // Скидання (активний низький)
    input wire [31:0] phase_inc, // "Крок" фази (задає частоту)
    output reg signed [15:0] sine_out // Вихід синусоїди
);

    // 1. Акумулятор фази (32 біти)
    reg [31:0] phase_acc;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            phase_acc <= 32'd0;
        end else begin
            // Постійно інкрементуємо акумулятор
            phase_acc <= phase_acc + phase_inc;
        end
    end

    // 2. Формування адреси для ROM
    
     wire [10:0] rom_addr; //heart_wave
    //wire [9:0] rom_addr;
    
    //assign rom_addr = phase_acc[31:22];
     assign rom_addr = phase_acc[31:21]; // для heart_wave

    // 3. Пам'ять ROM (Look-Up Table)
     reg [15:0] sine_rom [0:2047]; // для heart_wave
     //reg [15:0] sine_rom [0:1023];

    // Завантаження файлу з MATLAB у пам'ять
    initial begin
        $readmemh("heart_wave.txt", sine_rom);
    end

    // 4. Читання з пам'яті
    always @(posedge clk) begin
        sine_out <= sine_rom[rom_addr];
    end
endmodule
