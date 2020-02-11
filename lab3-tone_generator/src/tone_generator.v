`timescale 1ns/1ns
module tone_generator (
    input        clk, // 125Mhz clock
    input        output_enable, // ??
    input [23:0] tone_switch_period, // ??
    input        volume, // how to affect magnitue of wave?
    output       square_wave_out // assign out to reg value for square wave
);
  localparam CLOCK_FREQUENCY = 125_000_000; // 125Mhz
  localparam TONE_FREQUENCY = 220;
  localparam TONE_PERIOD_CLOCK_CYCLES = 568;


  integer counter = 0;

  reg square_wave_state = 1; // is this implemented with a flip/flop?

  assign square_wave_out = square_wave_state;

  always @(posedge clk) begin
    if (counter == 0)
      begin
          square_wave_state = ~square_wave_state;
          counter = TONE_PERIOD_CLOCK_CYCLES;
      end
    else begin
      if (counter > 0)
        counter = counter - 1;
    end
  end
endmodule
