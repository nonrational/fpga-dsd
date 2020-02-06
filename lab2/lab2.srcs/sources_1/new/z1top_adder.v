`timescale 1ns / 1ps

module z1top_adder (
  input CLOCK,
  input [1:0] BUTTONS,
  output [5:0] LEDS
);

  full_adder fa (
    .a(BUTTONS[0]),
    .b(BUTTONS[1]),
    .carry_in(0),
    .sum(LEDS[0]),
    .carry_out(LEDS[3])
  );

endmodule
