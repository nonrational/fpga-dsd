`timescale 1ns / 1ps

module z1top_adder (
  input CLOCK,
  input [1:0] BUTTONS,
  output [5:0] LEDS
);
  wire [11:0] ain = BUTTONS[0] == 1 ? 11'b00000000111 : 0;
  wire [11:0] bin = BUTTONS[1] == 1 ? 11'b00000000111 : 0;

  structural_adder user_adder (
      .a(ain),
      .b(bin),
      .sum(LEDS[3:0])       // Upper bits will be truncated
  );

  // // Self test of the structural adder
  // wire [13:0] adder_operand1, adder_operand2;
  // wire [14:0] structural_out, behavioral_out;
  // wire test_fail;
  // assign LEDS[4] = ~test_fail;
  // assign LEDS[5] = ~test_fail;

  // structural_adder structural_test_adder (
  //     .a(adder_operand1),
  //     .b(adder_operand2),
  //     .sum(structural_out)
  // );

  // behavioral_adder behavioral_test_adder (
  //     .a(adder_operand1),
  //     .b(adder_operand2),
  //     .sum(behavioral_out)
  // );

  // adder_tester tester (
  //     .structural_sum(structural_out), // in
  //     .behavioral_sum(behavioral_out), // in
  //     .adder_operand1(adder_operand1), // out
  //     .adder_operand2(adder_operand2), // out
  //     .clk(CLOCK),                     // in
  //     .test_fail(test_fail)            // out
  // );

endmodule
