`timescale 1ns/1ns

module tone_top (
    input CLOCK,
    input [1:0] BUTTONS,
    output [5:0] LEDS
);
    // TODO(you): Your code here. Remove the following lines once you add your implementation.
    assign LEDS[5:0] = 6'b111111;
endmodule
