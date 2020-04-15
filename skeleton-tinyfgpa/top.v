// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,     // 16MHz clock

    output LED,    // User/boot LED next to power LED
    output USBPU,  // USB pull-up resistor

    output PIN_1,
    output PIN_13
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    tickspeed_blinker #(.MESSAGE_WIDTH(84)) tsb1 (
        .CLK(CLK),
        .blink_pattern(84'b0001_000000000_0001010111_000000000_00010111010111_000000000_000101010111_000000000_00011101),

        .LED(PIN_13),
        .START(),
        .blink_index()
    );

    // tone_generator tg1 (
    //     .clk(CLK),
    //     .output_enable(),
    //     .tone_switch_period(),
    //     .volume(),

    //     .square_wave_out(PIN_1)
    // );

    assign PIN_1 = PIN_13;
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
    input        clk, // 125Mhz clock
    input        output_enable, // ??
    input [23:0] tone_switch_period, // ??
    input        volume, // how to affect magnitue of wave?
    output       square_wave_out // assign out to reg value for square wave
);
  localparam TONE_PERIOD_CLOCK_CYCLES = 72;

  integer counter = 0;

  initial square_wave_out = 1;

  always @(posedge clk) begin
    if (counter == 0)
      begin
          square_wave_out = ~square_wave_out;
          counter = TONE_PERIOD_CLOCK_CYCLES;
      end
    else begin
      if (counter > 0)
        counter = counter - 1;
    end
  end
endmodule
