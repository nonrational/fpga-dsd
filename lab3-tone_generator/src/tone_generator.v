`timescale 1ns/1ns
module tone_generator (
    input        clk, // 125Mhz clock
    input        output_enable, // ??
    input [23:0] tone_switch_period, // ??
    input        volume, // how to affect magnitue of wave?
    output       square_wave_out // assign out to reg value for square wave
);
    localparam CLOCK_FREQUENCY = 125_000_000; // 125Mhz

    integer counter = 0;

    reg square_wave_state; // is this implemented with a flip/flop?

    assign square_wave_out = square_wave_state;

    // always (*) begin
    // ...
    // ... do clock math to determine if the wave should be high or low, set to square_wave_reg
    // end
endmodule
