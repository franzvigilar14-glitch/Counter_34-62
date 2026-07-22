/*===========================================
              BCD-TO-2-DIGIT
=============================================
Description:
 This module accepts 7-bit bcd input then 
 displays a corresponding 2-digits 7-segment 
 display.

Design Engineer:
 Caberoy, Adrian Miko A.
 Vigilar, Franz Louis G.
 
Date:
 19 Feb 2026
--------------------------------------------*/
module bcd_2d(hex_10s,hex_1s,bcd_in);
 //ports
 input  [7:0] bcd_in;
 output [0:6] hex_10s;
 output [0:6] hex_1s;
 
 // double-dabble algorithm
 reg [14:0] b = 15'b0; //b14-b11: 10s, b10-b7: 1s, b6-b0: in
 wire [3:0] bcd_10s;
 wire [3:0] bcd_1s;
 
 always@(bcd_in)begin
   b = 15'b0;
   b[7:0] = bcd_in;
   
   repeat(7) begin
     // 10's
     if(b[14:11] >= 4'd5) b[14:11] = b[14:11] + 4'd3;
   
     // 1's
     if(b[10:7] >= 4'd5) b[10:7] = b[10:7] + 4'd3;   
      
     // shift-left
     b = b<<1;
  
  end
   
 end
 
 assign bcd_10s = b[14:11]; //10's
 assign bcd_1s  = b[10:7]; //1's
 
 // bcd-to-2-digit 7-segment
 assign hex_10s = leds(bcd_10s);
 assign hex_1s  = leds(bcd_1s);
 
 // BCD-to-7-Segment
 function   [0:6] leds;
 input      [3:0] bcd;
  begin
    case(bcd)       //abcdefg
      4'd0: leds = 7'b1111110;
      4'd1: leds = 7'b0110000;
      4'd2: leds = 7'b1101101;
      4'd3: leds = 7'b1111001;
      4'd4: leds = 7'b0110011;
      4'd5: leds = 7'b1011011;
      4'd6: leds = 7'b0011111;
      4'd7: leds = 7'b1110000;
      4'd8: leds = 7'b1111111;
      4'd9: leds = 7'b1110011;
      default: leds = 7'b0000001;
     endcase
    end
  endfunction

endmodule
