// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,     // 16MHz clock

    output LED,    // User/boot LED next to power LED
    output USBPU,  // USB pull-up resistor

    output PIN_13
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    tickspeed_blinker nonrational (
        .CLK(CLK),
        .blink_pattern(102'b000101011101_00011101_00010111_00011101110111_000101_000111_00011101_0001011101_00010111_00011101110111_00010111),

        .LED(PIN_13),
        .START(LED),
        .blink_index()
    );
endmodule

module tickspeed_blinker
    #(
        parameter TICK_RATE='d5_000_000,
        parameter MESSAGE_WIDTH=102
     )
(
    input CLK,
    input [MESSAGE_WIDTH-1:0] blink_pattern,

    output LED,
    output START,
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
            blink_index = 'b1;
            tick = 0;
        end

    assign LED = blink_pattern[blink_index];
endmodule
