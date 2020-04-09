// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output LED,   // User/boot LED next to power LED
    output PIN_13,
    output USBPU,  // USB pull-up resistor
    output [26:0] counter
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    //  _______ _    _ _
    // |__ /_  ) |__(_) |_
    //  |_ \/ /| '_ \ |  _|
    // |___/___|_.__/_|\__|
    //
    // keep track of time and location in blink_pattern
    reg [26:0] blink_counter;
    assign counter = blink_counter;

    initial
        begin
            blink_counter = 27'b000000100000000000000000000;
        end

    wire [34:0] blink_pattern = 35'b10101000_11101110111000_10101000;
    always @(posedge CLK)
    begin
        blink_counter <= blink_counter + 1;
    end

    wire [5:0] index;
    // 6-bit index
    assign index = blink_counter[26:21];
    // index into pattern
    assign PIN_13 = blink_pattern[index];
    // blink onboard LED every cycle
    assign LED = index == 0;

    //                   _
    //  _ _ __ _ _ _  __| |___ _ __
    // | '_/ _` | ' \/ _` / _ \ '  \
    // |_| \__,_|_||_\__,_\___/_|_|_|
    //

    // reg loadseed_i;
    // assign LED = rng(CLK,PIN_13,)

endmodule
