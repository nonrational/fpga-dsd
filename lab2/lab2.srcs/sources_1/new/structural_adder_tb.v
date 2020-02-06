`include "structural_adder.v"
`include "behavioral_adder.v"
`include "full_adder.v"

module structural_adder_tb ();
  reg [13:0] r_ADD_1 = 14'b00000000000000;
  reg [13:0] r_ADD_2 = 14'b00000000000000;
  wire [14:0]  s_RESULT;
  wire [14:0]  b_RESULT;

  structural_adder sadder (
     .a(r_ADD_1),
     .b(r_ADD_2),
     .sum(s_RESULT)
  );

  behavioral_adder badder (
     .a(r_ADD_1),
     .b(r_ADD_2),
     .sum(b_RESULT)
  );

  initial
    begin
      #10
      $display("%b == %b", s_RESULT, b_RESULT);
      #10;
      r_ADD_1 = 14'b00100001111111;
      r_ADD_2 = 14'b00000000000001;
      #10;
      $display("%b == %b", s_RESULT, b_RESULT);
      r_ADD_1 = 14'b00000000000010;
      r_ADD_2 = 14'b00000000000001;
      #10;
      $display("%b == %b", s_RESULT, b_RESULT);
      r_ADD_1 = 14'b00000000000111; // 7
      r_ADD_2 = 14'b00000000011111; // 31
      #10;
      $display("%b == %b", s_RESULT, b_RESULT);
    end

endmodule
