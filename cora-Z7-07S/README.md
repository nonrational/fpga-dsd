# Overview

- `ledbtn_top.v`
  - Pressing `BTN0` cycles `LD0` through its BGR states.
  - LD0 displays the "debounce" status to allow for a single press to advance the color only one step.
- `cora-z7-07s.xdc`
  - hardware-to-software pin-to-variable mapping

### Notes
```
LEDS[0] - led0_blue
LEDS[1] - led0_green
LEDS[2] - led0_red
LEDS[3] - led1_blue
LEDS[4] - led1_green
LEDS[5] - led1_red
```

### Demo

