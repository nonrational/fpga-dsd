`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/05/2020 12:06:18 PM
// Design Name:
// Module Name: ledbtn_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module ledbtn_top(
  input clk,
  input [1:0] BUTTONS,

  output [5:0] LEDS,
  output wire r_led,
  output wire g_led
);
  reg [2:0] state;
  integer debouncer;

  always @(negedge clk)
    if(debouncer == 0 && BUTTONS[0] == 1)
      begin
        state = state + 1;
        debouncer = 32'd50_000_000;
      end
    else
      if(debouncer > 0)
        debouncer = debouncer - 1;

  assign LEDS[2:0] = state;
  assign r_led = debouncer > 0;
  assign g_led = BUTTONS[1];
endmodule

