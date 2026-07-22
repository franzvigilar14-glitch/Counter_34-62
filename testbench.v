//testbench for counter 2D(34-62)
module testbench;
 //tb signals
  reg            en;
  reg	         ud;
  reg        clk_50;
  reg        rst;
  wire [0:6] hex_10s;
  wire [0:6] hex_1s;
  wire       clk_led;
  wire            bz;


 
 // instantiate dut
 counter_2d3462 dut(
 .hex_10s(hex_10s),
 .hex_1s(hex_1s),
 .clk_led(clk_led),
 .bz(bz),
 .clk_50(clk_50),
 .rst(rst),
 .en(en),
 .ud(ud)
 );
 
 // apply stimuli
 initial clk_50 = 1'b0;
 always #1 clk_50 = ~clk_50;
 
 initial begin
 rst = 0; en = 1; ud = 1; #20;
        
        // Reset and start counting up
        rst = 1; en = 1; ud = 1; #20;
        
        // Count down 
        rst = 1; en = 0; ud = 0; #100;
        
        // Change count up
        ud = 1; en = 1; #300
        
        // Reset
        rst = 0; #400;
        
        
       	
        

        
    end
    

    


endmodule
