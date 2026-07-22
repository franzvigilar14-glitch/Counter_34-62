/*=====================================
          2-DIGIT-COUNTER
=======================================
Description:
 This module is a 4-bit up counter(34-62)
 with active-LOW asynchronuos reset.
 
Design Engineer:
 Caberoy, Adrian Miko A.
 Vigilar, Franz Louis G.
 
Date:
 18 Feb 2026
 --------------------------------------*/
 module counter_2d3462(hex_10s,hex_1s,clk_led,bz,clk_50,rst,en,ud);
  //ports
  input        en;
  input	       ud;
  input        clk_50;
  input        rst;
  output [0:6] hex_10s;
  output [0:6] hex_1s;
  output       clk_led;
  output reg      bz;

  //1Hz Clock
  wire clk;
  clk_div #(.TICKS_500MS(2)) div(
  .clk_out(clk),
  .clk_led(clk_led),
  .clk_in(clk_50)
  );
  
  // 34 (MINIMUM COUNT) - 62 (MAXIMUM COUNT)
  parameter [7:0] MAX_COUNT = 8'd62;
  parameter [7:0] MIN_COUNT = 8'd34;
  reg [7:0] counter = 8'd0;
 
 always@(posedge clk, negedge rst)begin
  if (!rst) begin
    //reset
    if (ud)
      counter <= MIN_COUNT;
    else
      counter <= MAX_COUNT;
    bz <= 0;
  end
    else if (en) begin
      if (ud) begin
        //count up
        if (counter < MAX_COUNT)
          counter <= counter + 8'b1;
        else begin
          counter <= counter;
          bz <= (~bz);
			 end
      end
    else begin
      //count down
      if (counter > MIN_COUNT)
        counter <= counter - 8'b1;
      else begin
        counter <= counter;

      bz <= (~bz);
		end
    end
  end
end


  //bcd-to-2-digit 7-segment
  bcd_2d f2d(
     .hex_10s(hex_10s),
     .hex_1s(hex_1s),
     .bcd_in(counter)
    );
   
 endmodule
