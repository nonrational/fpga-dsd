`timescale 1ns / 1ps

module z1top(
  input CLOCK,
  input [3:0] BUTTONS,
  output [5:0] LEDS
);
  and(LEDS[2], BUTTONS[0], BUTTONS[1]);
endmodule
