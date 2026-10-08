module Top_Module_Slaves (

    input  wire i_Clk,
	input  wire i_Btn,
    
    input  wire i_SPI_Clk,
    input  wire i_SPI_MOSI,
    input  wire i_SPI_CS_n, 
    output wire o_SPI_MISO  // Лінія відповіді (поки мовчить)
    
);

    wire w_RX_DV;
    wire [15:0] w_RX_Byte; // Дані які приймаються
	 reg [15:0] r_TX_Byte; // Регістри даних які відправляться на ESP32
    
    //Цикл для тесування значеннь від 0 до 4096
    reg [15:0] i_val = 0;
    reg count_direction; // 1 - вгору, 0 - вниз
    reg [15:0] delay_count = 0;
    
    always @(posedge i_Clk) begin
        if(i_Btn == 1'b0) begin
            delay_count <= delay_count + 1;
        
            if (delay_count == 0) begin
                if(count_direction == 1'b1) begin
                    if (i_val >= 15'd4095) begin
                        count_direction <= 1'b0;
                        i_val <= i_val - 1;
                    end else begin
                        i_val <= i_val + 1;
                    end
                end
                else begin 
                    if (i_val == 15'd0) begin
                        count_direction <= 1'b1;
                        i_val <= i_val + 1;
                    end else begin
                        i_val <= i_val - 1;
                    end
                end
            end 
         end else begin delay_count <= 0; // Можна прибрати
         end
      end
	 // Обробка кнопки (0xFF - кнопка натиснута, 0x00 - відпущена)
	 always @(posedge i_Clk) begin 
		if(i_Btn == 1'b0)
			r_TX_Byte <= i_val;
		else
			r_TX_Byte <= 15'b0;
	 end 
	 
    // Інстанціюємо модуль Nandland (Slave)
    SPI_Slaves #(.SPI_MODE(0)) SPI_Slave_Inst (
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

endmodule