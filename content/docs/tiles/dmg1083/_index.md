---
title: DMG1083
bookCollapseSection: true
---
# DMG1083 LED Tiles

<table class="vertical">
<tr><th>Manufacturer</th><td>digiLED</td></tr>
<tr><th>Model</th><td>DMG1083</td></tr>
<tr><th>Size</th><td>250×250 mm</td></tr>
<tr><th>Resolution</th><td>78×78 px</td></tr>
<tr><th>Colour depth</th><td>14-bit</td></tr>
<tr><th>Pixel pitch</th><td>3.205 mm</td></tr>
<tr><th>Supply voltage</th><td>5 V</td></tr>
<tr><th>Supply current</th><td>~10 A</td></tr>
</table>

{{< support_warning >}}

## History

These are video wall tiles which were donated in September 2023. They were part of a batch of tiles
which had to be recalled due to an unacceptable failure rate.

Approximately 800 tiles were received in this batch. We are currently evaluating these tiles and it is
likely that some will be available for distribution soon.

## Description

These tiles are originally from a [digiLED IMAG-R 3200](../../../datasheets/digiLED_iMAG-R_Series.pdf) screen. They were driven with a Novastar system using the MRV270/MRV470 receiver card, with each receiver driving a module comprising a 2x2 array of tiles.

It appears these LED tiles are similar or identical to models DMG1085 and DMG1075 (perhaps the only difference is the specific model of LEDs).

The PCBs are mounted in a beautifully-manufactured aluminium frame which has magnets and alignment
pins for mounting.

Electronically, this as an 80x80 px display with 2 missing columns/rows. The 20 driver chips are capable of driving 320 pixels (4 rows) at a time, which means 6400/320 = 1/20th of the screen is driven at once.

The board also features a MOM (memory-on-module) flash chip (neatly labelled in a box on the silkscreen) which seems likely to contain panel-specific calibration data.

[More detailed info on the electronics](electronics).

## Interface

Power is provided on a 4-pin JST VH connector:

<table class="pinout">
  <tr><td class="vcc">5V</td></tr>
  <tr><td class="vcc">5V</td></tr>
  <tr><td class="gnd">GND</td></tr>
  <tr><td class="gnd">GND</td></tr>
</table>

Data is on a 2x15 connector:

<table class="pinout">
  <caption>Data connector pinout</caption>
  <tr><td class="misc">CS</td><td class="misc">SLK</td></tr>
  <tr><td class="address">A</td><td class="address">B</td></tr>
  <tr><td class="control not">OE</td><td class="control">LAT</td></tr>
  <tr><td class="control">CLK</td><td class="nc">NC</td></tr>
  <tr><td class="address">C</td><td class="address">D</td></tr>
  <tr><td class="address">E</td><td class="data">R1</td></tr>
  <tr><td class="data">G1</td><td class="data">B1</td></tr>
  <tr><td class="gnd">GND</td><td class="data">R2</td></tr>
  <tr><td class="data">G2</td><td class="data">B2</td></tr>
  <tr><td class="data">R3</td><td class="data">G3</td></tr>
  <tr><td class="data">B3</td><td class="gnd">GND</td></tr>
  <tr><td class="data">R4</td><td class="data">G4</td></tr>
  <tr><td class="data">B4</td><td class="nc">NC</td></tr>
  <tr><td class="misc">SR</td><td class="nc">NC</td></tr>
  <tr><td class="misc">MSI</td><td class="misc">MSO</td></tr>
</table>

The `CS`, `SLK`, `MSI`, and `MSO` lines are likely related to the MOM flash and are not required to drive the display.

The `SR` line is currently a mystery. The panel appears to work with it disconnected. (Untested hypothesis: could this connect the data lines to the output of the shift register chains to allow the feedback data from the LED drivers to be read back? Perhaps this is what the `74HC4051D` ICs are doing.)

The remainder of the pins _appear_ to be a standard "HUB320" interface:
* `A`, `B`, `C`, `D`, `E` are address lines.
* `R1`, `B1`, `G1`, etc are the pixel data lines (which are connected to the input of the MBI5153 shift register drivers).
* `CLK`, `LAT` and `OE` are the standard control lines, but as discussed below, the behaviour is anything but standard. They correspond to the `DCLK`, `LE`, and `GCLK` pins on the MBI5153.

Data lines are buffered with 74HC245 bus transceivers. These may not be drivable with 3.3V logic. The original driver cards are 5V.

The two data connectors on the left and right sides are directly connected and the pinouts are identical. (This is convenient for connecting a logic analyser.)

## Driving

<div class="warning">We're yet to drive these panels with custom code, so this is all partially speculative!</div>

Don't be deceived: while the interface on this panel looks superficially similar to smaller LED matrix panels, this hides the significant complexity of the MBI5153 driver chip. You'll need to refer extensively to the MBI5153 [datasheet](/datasheets/MBI5153-VA.01-EN.pdf) and [application note](/datasheets/MBI5153%20Application%20Note%20V1.02-EN.pdf).

The `CLK` line on the connector feeds `DCLK` on the MBI5153s.

The `OE` line on the connector actually feeds the `GCLK` input on the MBI5153s, and this provides both blanking and the PWM reference clock for the drivers.

The `LAT` line on the connector feeds the `LE` input on the MBI5153. This not only handles latching-in the pixel data, but also sending other commands to the MBI5153, depending on how many `DCLK` pulses are sent while `LAT` is asserted.

Significantly, a whole frame's worth of pixels is clocked into this panel at once, and held in a SRAM double-buffer on the MBI5153 chips. Once this is complete, the output is blanked and a `VSYNC` command is sent to the MBI5153, which switches the buffers over. The previous frame is displayed while the next frame's data is being clocked in.

Since there are 20 "scan lines" (320 pixels each) on this screen, this means that the driver chip must switch the scan line it's displaying at the same time as the controller switches the scan line address. The MBI5153 does this on the 512th rising edge of the `GCLK`, so the least significant address line must be clocked at 1/512th the frequency of the `GCLK`.

The MBI5153 has the number of scan lines configured in its configuration registers (among other things). Note that there are 5 address lines but the number of scan lines is 20 so the address lines need to roll over at 0x14.

It's currently not certain whether the configuration registers are nonvolatile - it's possible that the drivers need to be configured at every power up. According to the datasheet, the scanlines setting defaults to `4`.

## Pictures

{{< figure src="dmg1083_pcb.jpeg" >}}
{{< figure src="pinout_silkscreen.jpeg" >}}
