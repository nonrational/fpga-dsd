# Tone Generator

## Questions

- [x] What is period of our clock signal (frequency = 125 MHz)? 8µs
- [x] The period of a 220 Hz square wave? 4545µs
- [x] How many clock cycles fit in one period of the square wave? 568

### Notes

Period (s) = 1 / Frequency (Hz)

#### 125Mhz Clock -> 220 Hz Tone
```
1 / 125000 Hz = 0.000008 s = 8µs
1 / 220 Hz = 0.00454545 s = 4.545ms = 4545.4545µs
4545.4545 / 8 = 568.1818125
```

#### 16Mhz Clock -> 220 Hz Tone
```
1/16000 Hz = 62.5µs
1 / 220 Hz = 4545.4545µs
4545.45µs / 62.5µs = 72.7272
```

## Links
- https://numato.com/kb/generating-square-wave-using-fpga/
- http://www.sengpielaudio.com/calculator-period.htm
