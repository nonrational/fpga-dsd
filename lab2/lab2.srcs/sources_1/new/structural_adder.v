module structural_adder (
    input [13:0] a,
    input [13:0] b,
    output [14:0] sum
);

    wire [13:0] summing;
    wire [14:0] carrying;

    assign carrying[0] = 1'b0;

    genvar i;

    generate
        for (i = 0; i < 14 ; i = i + 1) begin:twobitadder
            full_adder genadder (
                .a(a[i]),
                .b(b[i]),
                .carry_in(carrying[i]),
                .sum(summing[i]),
                .carry_out(carrying[i+1])
            );
        end
    endgenerate

    assign sum = {carrying[14], summing};
endmodule
