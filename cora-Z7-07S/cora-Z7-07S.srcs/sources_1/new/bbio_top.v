`timescale 1ns / 1ps

module bbio_top(
  input clk,
  input [1:0] BUTTONS,
  input wire DIP0,
  input wire DIP1,

  output [5:0] LEDS
);
  assign LEDS[1:0] = {1'b0,DIP0} + {1'b0,DIP1};
endmodule

