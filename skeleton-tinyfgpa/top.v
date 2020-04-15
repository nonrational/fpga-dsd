// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,     // 16MHz clock
    input PIN_23,  // Piezo Speaker 1

    output LED,    // User/boot LED next to power LED
    output USBPU,  // USB pull-up resistor

    output PIN_13, // Green LED
    output PIN_15  // Speaker 2
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    tickspeed_blinker #(.MESSAGE_WIDTH(78)) tsb1 (
        .CLK(CLK),
        .blink_pattern(78'b0001_000111010101_000101_000101011101_00011101_00000_00010101_000101_00000_000111_000101),

        .LED(PIN_13),
        .START(),
        .blink_index()
    );

    tone_generator tg1 (
        .clk(CLK),
        .output_enable(PIN_13),
        .tone_switch_period(),
        .volume(),

        .square_wave_out(PIN_15)
    );

    assign LED = PIN_23;
endmodule

module tickspeed_blinker
    #(
        parameter TICK_RATE='d2500000,
        parameter MESSAGE_WIDTH=32
     )
(
    input CLK,
    input [MESSAGE_WIDTH-1:0] blink_pattern,

    output LED,   // blinks the message
    output START, // blinks at the start of the message
    output reg [$clog2(MESSAGE_WIDTH)-1:0] blink_index
);
    reg [31:0] tick;

    assign START = blink_index == 0;

    always @(posedge CLK)
    begin
        tick = tick + 1;
        if (tick >= TICK_RATE)
        begin
            blink_index <= blink_index + 1;
            tick = 0;
        end
    end

    initial
        begin
            blink_index = 0;
            tick = 0;
        end

    assign LED = blink_pattern[blink_index];
endmodule

module tone_generator (
    input        clk,                   // 125Mhz clock
    input        output_enable,         // Stop oscillation unless 1
    input [23:0] tone_switch_period,    // ??
    input        volume,                // TODO: how to affect magnitue of wave?

    output       square_wave_out        // assign out to reg value for square wave
);
  localparam TONE_PERIOD_CLOCK_CYCLES = 7200;

  integer counter = 0;

  reg square_wave;
  initial square_wave = 1;

  assign square_wave_out = output_enable & square_wave;

  always @(posedge clk) begin
    if (counter == 0)
      begin
          square_wave = ~square_wave;
          counter = TONE_PERIOD_CLOCK_CYCLES;
      end
    else begin
      if (counter > 0)
        counter = counter - 1;
    end
  end
endmodule
