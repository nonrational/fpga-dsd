module structural_adder (
    input [13:0] a,
    input [13:0] b,
    output [14:0] sum
);

    genvar i;

    full_adder f0 (
        .a(a[0]),
        .b(b[0]),
        .carry_in(0),
        .sum(sum[0]),
        .carry_out(sum[1])
    );

    generate
        for (i = 1; i <= 13 ; i = i + 1) begin:twobitadder
            full_adder genadder (
                .a(a[i]),
                .b(b[i]),
                .carry_in(sum[i-1]),
                .sum(sum[i]),
                .carry_out(sum[i+1])
            );
        end
    endgenerate
endmodule
