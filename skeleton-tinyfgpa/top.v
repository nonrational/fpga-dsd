// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,     // 16MHz clock

    output LED,    // User/boot LED next to power LED
    output USBPU,  // USB pull-up resistor

    output PIN_13
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;
    assign LED = 0;

    lookup_blinker_32 SOS (
        .CLK(CLK),
        .blink_pattern(32'b10101000_11101110111000_10101000_00),
        .LED(PIN_13),
        .blink_counter()
    );
endmodule

module lookup_blinker_32 (
    input CLK,
    input [31:0] blink_pattern,
    output reg [25:0] blink_counter,
    output LED
);
    always @(posedge CLK)
    begin
        blink_counter <= blink_counter + 1;
    end

    initial
        begin
            blink_counter = 26'b00001000000000000000000000;
        end

    // "Bit extraction of var[31:0] requires 5 bit index, not 6 bits."
    wire [4:0] index;
    assign index = blink_counter[25:21];
    assign LED = blink_pattern[index];
endmodule

// module lookup_blinker
//     #(parameter WIDTH=32)
//     (
//         input CLK,
//         input [WIDTH-1:0] blink_pattern,
//         output LED,
//         output [25:0] blink_counter
//     );

//     initial blink_counter = 26'b00001000000000000000000000;
//     always @(posedge CLK)
//     begin
//         blink_counter <= blink_counter + 1;
//     end
//     wire [4:0] index;
//     assign index = blink_counter[25:21];
//     assign LED = blink_pattern[index];
// endmodule
