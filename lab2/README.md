# Lab2 - Build a Structural 14-bit Adder

- [x] [`full_adder.v`](lab2.srcs/sources_1/new/full_adder.v) - Fill in the logic to product the full adder output from the inputs.
- [x] [`structural_adder.v`](lab2.srcs/sources_1/new/structural_adder.v) - Construct a ripple carry adder using the full adder cells you designed earlier and a 'for-generate loop'.
- [ ] Explain the differences between the behavioral and structural adder as they are synthesized in schematic and SLICE views.

## Full Adder

A full adder is a circuit that satisfies a truth table, with 3 inputs and 2 outputs.

So, how do we represent a truth table with two outputs? Karnaugh Maps. Also, KMaps allow us to derive a boolean function from a truth table via Sum-Of-Product notation.

[Introduction to K-Maps](https://www.youtube.com/watch?v=3vkMgTmieZI)

[Full Adder](https://www.youtube.com/watch?v=F-2C59sTl6w) (Note: He keeps saying hexidecimal but he means binary)

### I/O

- A - input - left-hand side input
- B - input right-hand side input
- Cin - input - carry from last full adder (since we will sequence them)
- Cout - output - higher order bit from sum
- Sum - output - lower order bit from sum

### Truth Table

| A | B | Cin | Cout | Sum |
|---|---|-----|------|-----|
| 1 | 1 | 1   | 1    | 1   |
| 1 | 1 | 0   | 1    | 0   |
| 1 | 0 | 1   | 1    | 0   |
| 1 | 0 | 0   | 0    | 1   |
| 0 | 1 | 1   | 1    | 0   |
| 0 | 1 | 0   | 0    | 1   |
| 0 | 0 | 1   | 0    | 1   |
| 0 | 0 | 0   | 0    | 0   |


### K-Map Sum

|    | !B!C | !BC | BC | B!C |
|----|------|-----|----|-----|
| !A | 0    | 1   | 0  | 1   |
| A  | 1    | 0   | 1  | 0   |

This K-Map produces no "nice" groups, so we have 4 groups of 1, which we express via SOP as

`sum = !A*!B*C + !A*B*!C + A!B!C + ABC = C(!A!B + AB) + !C(!AB+A!B) = C ⊗ A ⊗ B`

### K-Map Cout

|    | !B!C | !BC | BC | B!C |
|----|------|-----|----|-----|
| !A | 0    | 0   | 1  | 0   |
| A  | 0    | 1   | 1  | 1   |

This K-Map produces 3 groups, which we express as

`Cout = AC + AB + BC`

## Demo

<img src=assets/2bitadder2.mp4.gif width=500>

## 14-bit Ripple Carry Adder

Instatiate full adders to sum each bit of the 14-bit inputs A and B, with wires for each Sum and Cout. As each bit is summed, the resulting Cout can be wired back into the Cin of each full adder. Then, we can hook the higest order output bit up to the carry wire, and "concatenate" the values to produce the output.

### What went wrong?

I think my first implementation suffered because I tried to wire the full_adders directly to the output sum. It's tricky to get your head around the fact that this isn't a procedural loop, but a generative loop. I also had trouble with wire initialization. I need to understand more about how `assign` works for wire initialization.

```
# assign carrying = 15'b000000000000000;

iverilog structural_adder_tb.v && ./a.out
xxxxxxxxxxxxxxx == 000000000000000
000000000000000 == 000000000000000
xxxxxxxxxxxxxx0 == 000100010000000
000000000000011 == 000000000000011
x01111111111111 == 101111111111111

# assign carrying[0] = 15'b0;

iverilog structural_adder_tb.v && ./a.out
xxxxxxxxxxxxxxx == 000000000000000
000000000000000 == 000000000000000
000100010000000 == 000100010000000
000000000000011 == 000000000000011
101111111111111 == 101111111111111
```

## Other Links

- <https://www.sciencedirect.com/topics/computer-science/full-adder>
- <https://www.nandland.com/vhdl/modules/module-full-adder.html>
