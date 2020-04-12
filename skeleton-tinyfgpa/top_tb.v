`timescale 1ns/1ns

`define STEP 4194304000
`define MESSAGE_WIDTH 32
`define COUNTER_WIDTH 26
`define COUNTER_INDEX_WIDTH 5

module top_tb ();
  reg clock;
  initial clock = 0;
  always #1 clock <= ~clock;

  wire gr_led;

  reg [MESSAGE_WIDTH-1:0] blink_pattern = 32'b01010101010101001111111111111111;

  wire [COUNTER_WIDTH-1:0] blink_counter;
  wire [COUNTER_INDEX_WIDTH-1:0] index;
  assign index = blink_counter[COUNTER_WIDTH-1:COUNTER_WIDTH-COUNTER_INDEX_WIDTH];

  lookup_blinker #(.MESSAGE_WIDTH(`MESSAGE_WIDTH), .COUNTER_WIDTH(`COUNTER_WIDTH), .COUNTER_INDEX_WIDTH(`COUNTER_INDEX_WIDTH)) blinky (
    .CLK(clock),
    .blink_pattern(blink_pattern),

    .LED(gr_led),
    .blink_counter(blink_counter)
  );

  realtime last_flip_at;
  initial last_flip_at = 0;

  always begin
    @(gr_led) // on every flip, print how long since the last flip
      begin
        $display("[%t] idx:%b pattern:%b gr_led:%b", $realtime - last_flip_at, index, blink_pattern[index], gr_led);
        $fflush();
        last_flip_at = $realtime;
      end
  end

  always begin
    #(`STEP) begin
      $fflush();

      if (index == 0)
        begin
        $display("[%t] @%b -> %b", $realtime - last_flip_at, index, gr_led);
        $fflush();
        $finish();
        end
    end
  end
endmodule
