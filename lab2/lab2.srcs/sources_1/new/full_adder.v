module full_adder (
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
);
    assign sum = a ^ b ^ c
    assign carry_out = (a * b) + (a * c) + (b * c)
endmodule
