`timescale 1ns/1ns

module top_tb ();
  reg clock;
  initial clock = 0;
  always #4 clock <= ~clock;

  wire gr_led;

  reg [31:0] blink_pattern = 32'b01010101010101001111111111111111;
  wire [4:0] blink_index;

  tickspeed_blinker #(.TICK_RATE(100), .MESSAGE_WIDTH(32)) blinky (
    .CLK(clock),
    .blink_pattern(blink_pattern),

    .LED(gr_led),
    .START(),
    .blink_index(blink_index)
  );

  realtime last_flip_at;
  initial last_flip_at = 0;

  // initial $monitor("[%t] %b", $time, blink_index);

  always begin
    @(gr_led) // on every flip, print how long since the last flip
      begin
        $display("[%t] elapsed:%t gr_led:%b", $realtime, $realtime - last_flip_at, gr_led);
        $fflush();
        last_flip_at = $realtime;
      end
  end

  always begin
    #500 begin
      $fflush();

      if (blink_index == 0 && $realtime > 500000)
        begin
          $display("[%t] elapsed:%t gr_led:%b", $realtime, $realtime - last_flip_at, gr_led);
          $fflush();
          $finish();
        end
    end
  end
endmodule
