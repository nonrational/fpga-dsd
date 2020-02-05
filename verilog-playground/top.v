/* top.v */

module top();
  wire [3:0] X = 4'b1111;
  wire [3:0] Y = 4'b1111;
  wire cin = 1;
  wire cout;
  wire [4:0] R;

  assign {cout, R} = X + Y + cin;

  initial begin
    $dumpvars(0, R);

    $display("R %b", R);
    $display("cout %b", cout);

    #1;

    $display("R %b", R);
    $display("cout %b", cout);
  end
endmodule

module counter(out, clk, reset);

  parameter WIDTH = 8;

  output [WIDTH-1 : 0] out;
  input            clk, reset;

  reg [WIDTH-1 : 0]   out;
  wire            clk, reset;

  always @(posedge clk)
    out <= out + 1;

  always @reset
    if (reset)
      assign out = 0;
    else
      deassign out;

endmodule // counter
