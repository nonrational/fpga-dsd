// width = 14

module structural_adder (
    input [13:0] a,
    input [13:0] b,
    output [14:0] sum
);

    wire [14:0] running_sum;
    wire [15:0] running_carry;

    assign running_carry = 16'b0;

    genvar i;

    generate
        for (i = 0; i < 14 ; i = i + 1) begin:twobitadder
            full_adder genadder (
                .a(a[i]),
                .b(b[i]),
                .carry_in(running_carry[i]),
                .sum(running_sum[i]),
                .carry_out(running_carry[i+1])
            );
        end
    endgenerate

    assign sum = {running_carry[14], running_sum};
endmodule
