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
<tr><th>Pixel pitch</th><td>~3 mm (TBC)</td></tr>
<tr><th>Supply voltage</th><td>5 V</td></tr>
</table>

{{< support_warning >}}

## History

These are video wall tiles which were donated in September 2023. They were part of a batch of tiles
which had to be recalled due to an unacceptable failure rate.

Approximately 800 tiles were received in this batch. We are currently evaluating these tiles and it is
likely that some will be available for distribution soon.

## Description

The PCBs are mounted in a beautifully-manufactured aluminium frame which has magnets and alignment
pins for mounting.

- The driver chips are Macroblock [MBI5153](/datasheets/MBI5153GP-A.pdf) 16-Channel PWM Constant Current LED Drivers. There are 20 of these for each colour. Unlike the previous generation of tiles, these drivers support 14-bit PWM dimming on-chip.
- The address decoder is a 74HC138 (presumably 2 of them).
- There's also a bunch of other chips:
  - 74HC4051D 8-channel analog multiplexer/demultiplexer
  - HC245 Octal bus transceiver; 3-state
  - HC123 Monostable multivibrator
  - And a line of 39(?) APM4953 dual MOSFETs. 

It seems to be best to consider this as an 80x80 px display with 2 missing columns/rows. The 20 driver chips are capable of driving 320 pixels at a time, which means 6400/320 = 1/20th of the screen is driven at once.

The board also features a flash chip (neatly labelled in a box on the silkscreen) which seems likely to contain panel-specific calibration data. The Novastar Armor series of receiving cards support reading this calibration data, but the standard MRV series don't.

## Interface
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

The `CS`, `SLK`, `MSI`, `MSO` and `SR` lines are likely related to the calibration flash and are not required to drive the display.

The remainder of the pins _appear_ to be a standard "HUB320" interface:
* `A`, `B`, `C`, `D`, `E` are address lines.
* `R1`, `B1`, `G1`, etc are the pixel data lines (which are connected to the input of the MBI5153 shift register drivers).
* `CLK`, `LAT` and `OE` are the standard control lines, but as discussed below, the behaviour is anything but standard. They correspond to the `DCLK`, `LE`, and `GCLK` pins on the MBI5153.

Note that the "high" level on the MBI5153 is defined as 0.7V<sub>DD</sub>, and V<sub>DD</sub> is 5V, so driving these pins off a 3.3V microcontroller may not work. 

The two data connectors on the left and right sides are directly connected and the pinouts are identical. (This is convenient for connecting a logic analyser.)

## Driving

Don't be deceived: while the interface on this panel looks superficially similar to smaller LED matrix panels, this hides the significant complexity of the MBI5153 driver chip. You'll need to refer extensively to the MBI5153 [datasheet](/datasheets/MBI5153GP-A.pdf) and [application note](/datasheets/MBI5051-52-53-AN.pdf) (this one is not quite the right model but it appears identical).

The `OE` line on the connector actually feeds the `GCLK` input on the MBI5153, and this provides both blanking and the PWM reference clock for the drivers.

The `LAT` line on the connector feeds the `LE` input on the MBI5153. This not only handles latching-in the pixel data, but also sending other commands to the MBI5153, depending on the width of the pulse.

Significantly, a whole frame's worth of pixels is clocked into this panel at once, and held in a SRAM double-buffer on the MBI5153 chips. Once this is complete, the output is blanked and a `VSYNC` command is sent to the MBI5153, which switches the buffers over. The previous frame is displayed while the next frame's data is being clocked in.

Since there are 20 "scan lines" (320 pixels each) on this screen, this means that the driver chip must switch the scan line it's displaying at the same time as the controller switches the scan line address. The MBI5153 does this on the 1024th rising edge of the `GCLK`, so the least significant address line must be clocked at 1/1024th the frequency of the `GCLK`.

The MBI5153 has the number of scan lines configured in its configuration registers (among other things). Note that there are 5 address lines but the number of scan lines is 20 so the address lines need to roll over at 0x14.

## Pictures

{{< figure src="dmg1083_pcb.jpeg" >}}
{{< figure src="pinout_silkscreen.jpeg" >}}
