# Lab2 - Build a Structural 14-bit Adder

- [ ] [`full_adder.v`](lab2.srcs/new/full_adder.v) - Fill in the logic to product the full adder output from the inputs.
- [ ] [`structural_adder.v`](lab2.srcs/new/structural_adder.v) - Construct a ripple carry adder using the full adder cells you designed earlier and a 'for-generate loop'.
- [x] How are we managing to input two 3-bit integers? Via a switch and two buttons

## Full Adder

A full adder is a circuit that satisfies a truth table, with 3 inputs and 2 outputs.

So, how do we represent a truth table with two outputs? Karnaugh Maps. Also, KMaps allow us to derive a boolean function from a truth table.

[Introduction to K-Maps](https://www.youtube.com/watch?v=3vkMgTmieZI)
[Full Adder](https://www.youtube.com/watch?v=F-2C59sTl6w)

https://tams.informatik.uni-hamburg.de/research/software/tams-tools/kvd-editor.html

### I/O

- A - input - left-hand side input
- B - input right-hand side input
- Cin - input - carry from last full adder (since we will sequence them)
- Cout - output - higher order bit from sum
- Sum - output - lower order bit from sum

### Truth Table

| A | B | Cin | Cout | Sum |
|---|---|-----|------|-----|
| 1 | 1 |  1  |  1   |  1  |
| 1 | 1 |  0  |  1   |  0  |
| 1 | 0 |  1  |  1   |  0  |
| 1 | 0 |  0  |  0   |  1  |
| 0 | 1 |  1  |  1   |  0  |
| 0 | 1 |  0  |  0   |  1  |
| 0 | 0 |  1  |  0   |  1  |
| 0 | 0 |  0  |  0   |  0  |


## Links

![https://www.sciencedirect.com/topics/computer-science/full-adder](foo)
- [https://www.nandland.com/vhdl/modules/module-full-adder.html](https://www.nandland.com/vhdl/modules/module-full-adder.html)
