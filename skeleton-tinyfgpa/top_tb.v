`timescale 1ns/1ns

`define STEP 33554424000

module top_tb ();
  reg clock;
  initial clock = 0;
  always #1 clock <= ~clock;

  reg [31:0] blink_pattern = 32'b01010101010101001111111011111111;

  wire [4:0] index;
  assign index = blink_counter[25:21];

  wire gr_led;

  wire [25:0] blink_counter;

  lookup_blinker_32 blinky (
    .CLK(clock),
    .blink_pattern(blink_pattern),

    .LED(gr_led),
    .blink_counter(blink_counter)
  );

  // initial $monitor("@%t %b", $time, $realtime, gr_led);

  realtime flipon;
  initial flipon = 0;

  always begin
    @(gr_led)      // wait for sig to goto 0
      begin
        $display("[%t] @%b -> %b", $realtime - flipon, index, gr_led);
        $fflush();
        flipon = $realtime;
      end
  end

  always begin
    #500 begin
      $fflush();

      if (index == 0)
        begin
        $display("[%t] @%b -> %b", $realtime - flipon, index, gr_led);
        $fflush();
        $finish();
        end
    end
  end
endmodule
