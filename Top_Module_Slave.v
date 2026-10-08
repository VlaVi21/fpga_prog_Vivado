module Top_Module_Slave (

    input  wire i_Clk,
	 input  wire i_Btn,
    
    input  wire i_SPI_Clk,
    input  wire i_SPI_MOSI,
    input  wire i_SPI_CS_n, 
    output wire o_SPI_MISO,  // Лінія відповіді (поки мовчить)
    
    output wire [7:0] o_LEDs  // Світлодіоди
);

    wire w_RX_DV;
    wire [15:0] w_RX_Byte; // Дані які приймаються
	 reg [15:0] r_TX_Byte; // Регістри даних які відправляться на ESP32

	 // Обробка кнопки (0xFF - кнопка натиснута, 0x00 - відпущена)
	 always @(posedge i_Clk) begin 
		if(i_Btn == 1'b0)
			r_TX_Byte <= 12'd4095;
		else
			r_TX_Byte <= 12'd0;
	 end 
	 
    // Інстанціюємо модуль Nandland (Slave)
    SPI_Slave #(.SPI_MODE(0)) SPI_Slave_Inst (
        .i_Rst_L(1'b1),
        .i_Clk(i_Clk),
        
        .o_RX_DV(w_RX_DV),     // Сигнал "Дані прийшли"
        .o_RX_Byte(w_RX_Byte), // Саме число
        
		  .i_TX_DV(w_RX_DV),   // Завантажуємо нові дані одразу після отримання попереднього байту
        .i_TX_Byte(r_TX_Byte), // Байт, який містить стан кнопки
        
        .i_SPI_Clk(i_SPI_Clk),
        .o_SPI_MISO(o_SPI_MISO),
        .i_SPI_MOSI(i_SPI_MOSI),
        .i_SPI_CS_n(i_SPI_CS_n)
    );
	 
	reg [7:0] r_PWM_Cnt = 0;
	reg r_LED_State;
	
    // Коли прийшов байт -> виводимо на LED
    always @(posedge i_Clk) begin
		  r_PWM_Cnt <= r_PWM_Cnt + 1;
		  
		  if (r_PWM_Cnt < w_RX_Byte) begin
				r_LED_State <= 1'b1;
			end 
			else begin
				r_LED_State <= 1'b0;
			end
    end
	
	//Фінальний сигнал
	assign o_LEDs = {8{r_LED_State}} ^ 8'b11100000;
endmodule