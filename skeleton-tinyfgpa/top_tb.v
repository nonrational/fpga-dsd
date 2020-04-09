`timescale 1ns/1ns

`define STEP 10000000

module top_tb ();
  reg clock;
  initial clock = 0;
  always #4 clock <= ~clock;

  wire gr_led;
  wire usb;
  wire onboard;
  wire [26:0] blink_counter;

  reg [34:0] blink_pattern = 35'b10101000_11101110111000_10101000;

  top blinky (
    .CLK(clock),
    .LED(onboard),
    .PIN_13(gr_led),
    .USBPU(usb),
    .counter(blink_counter)
  );

  wire last_gr_led;

  initial begin
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $display("[%t] %b", $time, blink_counter);
    #(`STEP)
    $fflush();
    $finish;
  end
endmodule
