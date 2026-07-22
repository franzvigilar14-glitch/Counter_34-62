# 2-Digit Up/Down Counter (34–62)

A 4-bit-based up/down counter that counts within a fixed range (34 to 62), with buzzer feedback at the limits and dual 7-segment display output.

## Description

`counter_2d3462` counts up or down between a minimum value of **34** and a maximum value of **62**, driven by a 1 Hz internal clock derived from a clock divider. Direction is selectable via the `ud` input, counting is gated by `en`, and a buzzer output toggles whenever the counter hits either boundary and further counting in that direction is attempted.

## Ports

| Port | Direction | Width | Description |
|---|---|---|---|
| `clk_50` | input | 1 | Raw input clock (e.g. 50 MHz board clock) |
| `rst` | input | 1 | Active-low asynchronous reset |
| `en` | input | 1 | Count enable |
| `ud` | input | 1 | Up/down select — `1` = count up, `0` = count down |
| `hex_10s` | output | [0:6] | 7-segment output — tens digit |
| `hex_1s` | output | [0:6] | 7-segment output — ones digit |
| `clk_led` | output | 1 | Blink-rate clock output from the divider |
| `bz` | output reg | 1 | Buzzer toggle output, triggered at count limits |

## Behavior

- **Clock generation:** An internal `clk_div` instance (with `TICKS_500MS(2)`) divides the 50 MHz input clock down to a 1 Hz counting rate.
- **Reset behavior:** On active-low reset, the counter loads either `MIN_COUNT` (34) or `MAX_COUNT` (62) depending on the current direction (`ud`), rather than resetting to zero — so the counter always resets to a boundary appropriate to its counting direction.
- **Counting:**
  - When `ud = 1` (count up): increments each tick while `en` is high, until `MAX_COUNT` (62) is reached
  - When `ud = 0` (count down): decrements each tick while `en` is high, until `MIN_COUNT` (34) is reached
- **Limit behavior:** Once the counter reaches its limit in the active direction, it holds its value and toggles `bz` (buzzer) every tick as a boundary alert, instead of wrapping around or continuing to count.
- **Display:** The current counter value is passed to a `bcd_2d` module (`f2d` instance), which splits it into tens and ones digits and drives the two 7-segment outputs.

## Parameters

| Parameter | Value | Description |
|---|---|---|
| `MAX_COUNT` | 62 | Upper count boundary |
| `MIN_COUNT` | 34 | Lower count boundary |

## Authors

Caberoy, Adrian Miko A. · Vigilar, Franz Louis G. — 18 Feb 2026
