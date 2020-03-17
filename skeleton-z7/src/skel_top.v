`timescale 1ns/1ns

module skel_top (
    input CLOCK,
    input [1:0] BUTTONS,
    output [5:0] LEDS
);
    assign LEDS[5:0] = 6'b111111;
endmodule
