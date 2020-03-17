`timescale 1ns/1ns

module skel_top (
    // input CLOCK,
    // input [1:0] BUTTONS,
    input [5:0] DIP,

    output [5:0] LEDS
);

    assign LEDS = ~DIP;
endmodule
