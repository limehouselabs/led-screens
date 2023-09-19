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

There are a bunch of chips used on the PCB:
- 60x Macroblock [MBI5153](/datasheets/MBI5153GP-A.pdf) 16-Channel PWM Constant Current LED Drivers. 
  - These actually drive the pixels. There are 20 for each colour.
  - Unlike the previous generation of tiles, these drivers support 14-bit PWM dimming on-chip.
  - They're quite complex. See [#driving](#driving)
- 12x `74HC4051D` 8-channel analog multiplexer/demultiplexer (marked `U15 - U26`)
  - These are a digitally controllable 1-pole 8-throw switch.
  - Not sure what purpose they serve here yet...
  - They switch a single common (`Z`) to one of 8 in/out pins (`Y0-7`) depending on 3 address (`S0-2`) pins, with the switch being "off" if the enable (`E`) pin is high.
  - Here, each of the 3 address pins are connected across all 12 chips on the board.
    (as in, all the `S0`s are connected together, etc)
  - The `Z` common pins are not connected together
  - The `E` enable pins are connected in groups:
    - `U15`,`U18`,`U21`, and `U24`
    - `U16`,`U19`,`U22`, and `U25`
    - `U17`,`U20`,`U23`, and `U26`
- 6x `HC245` Octal bus transceiver; 3-state
  - These allow 8 pairs of pins to communicate directionally, with the direction being set by a logic input `DIR`, with `OE` disabling any communication.
  - Here, they are just used as a way to fan out a single input on the pin headers to all the separate driver chips, possibly so that the thing driving the panel doesn't need to sink as much current into the inputs, possibly to clean up the inputs and provide some isolation. Possibly both. I wondered if these were also working as level shifters from 3.3v to the 5v logic the MBI5153 uses, but it looks like it would be marginal.
  - `DIR` is tied to Vcc and `OE` is tied to GND, which means these are permanently enabled unidirectionally.
- 1x `HC123` Monostable multivibrator
  - Generates pulses on rising/falling edges
  - Don't know what it's doing here yet
- 5x `HC138` 3-line to 8-line decoder/demultiplexers
  - These pull one of 8 output pins (`Y0-7`) low depending on the 3 bit address input (`A-C`). 
  - Here they're used as the address decoders for the address lines `A`-`E`, where 1 is
    cascaded into 3 to give 6-bit addressing (though only 5 bits are needed).
  - the lower two (`U2` and `U3`) are fed address lines `D` and `E`
    - `U2` cascades its first 3 outputs into the each of the upper group of 3, see below
    - `U3` feeds something else. Not sure what...
  - The upper group of 3 are fed address lines A, B and C 
    - `U4` does rows 1-8 (`Q*1`-`Q*4`) and is enabled by output 0 of `U2`
    - `U5` does rows 9-16 (`Q*5` - `Q*8`) and is enabled by output 1 of `U2`
    - `U6` does rows 17-20 (`Q*9`, `Q*0`) and is enabled by output 2 of `U2`
  - The outputs of the upper 3 go to the groups of `APM4953`s to toggle the pixel row groups (see below)
- 39x `APM4953` dual MOSFETs. 
  - These switch each row of the display on and off. Each chip has two separate mosfets in it - `39*2 = 78 rows`.
  - They are split into 18 groups of 4 rows and 2 groups of 3. These 20 groups fit
    neatly into the 5 bit "address" lines `A`-`E`, fed via the `HC138` decoder cascade.

It seems to be best to consider this as an 80x80 px display with 2 missing columns/rows. The 20 driver chips are capable of driving 320 pixels at a time, which means 6400/320 = 1/20th of the screen is driven at once.

The board also features a flash chip (neatly labelled in a box on the silkscreen) which seems likely to contain panel-specific calibration data. The Novastar Armor series of receiving cards support reading this calibration data, but the standard MRV series don't.

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

The `CS`, `SLK`, `MSI`, `MSO` and `SR` lines are likely related to the calibration flash and are not required to drive the display.

The remainder of the pins _appear_ to be a standard "HUB320" interface:
* `A`, `B`, `C`, `D`, `E` are address lines.
* `R1`, `B1`, `G1`, etc are the pixel data lines (which are connected to the input of the MBI5153 shift register drivers).
* `CLK`, `LAT` and `OE` are the standard control lines, but as discussed below, the behaviour is anything but standard. They correspond to the `DCLK`, `LE`, and `GCLK` pins on the MBI5153.

Note that the "high" level on the MBI5153 is defined as 0.7 * V<sub>DD</sub>, and V<sub>DD</sub> is 5V, so driving these pins off a 3.3V microcontroller may not work. 

The two data connectors on the left and right sides are directly connected and the pinouts are identical. (This is convenient for connecting a logic analyser.)

## Driving

<div class="warning">We're yet to drive these panels with custom code, so this is all partially speculative!</div>

Don't be deceived: while the interface on this panel looks superficially similar to smaller LED matrix panels, this hides the significant complexity of the MBI5153 driver chip. You'll need to refer extensively to the MBI5153 [datasheet](/datasheets/MBI5153GP-A.pdf) and [application note](/datasheets/MBI5051-52-53-AN.pdf) (this one is not quite the right model but it appears identical).

The `CLK` line on the connector feeds `DCLK` on the MBI5153s.

The `OE` line on the connector actually feeds the `GCLK` input on the MBI5153s, and this provides both blanking and the PWM reference clock for the drivers.

The `LAT` line on the connector feeds the `LE` input on the MBI5153. This not only handles latching-in the pixel data, but also sending other commands to the MBI5153, depending on how many `DCLK` pulses are sent while `LAT` is asserted.

Significantly, a whole frame's worth of pixels is clocked into this panel at once, and held in a SRAM double-buffer on the MBI5153 chips. Once this is complete, the output is blanked and a `VSYNC` command is sent to the MBI5153, which switches the buffers over. The previous frame is displayed while the next frame's data is being clocked in.

Since there are 20 "scan lines" (320 pixels each) on this screen, this means that the driver chip must switch the scan line it's displaying at the same time as the controller switches the scan line address. The MBI5153 does this on the 1024th rising edge of the `GCLK`, so the least significant address line must be clocked at 1/1024th the frequency of the `GCLK`.

The MBI5153 has the number of scan lines configured in its configuration registers (among other things). Note that there are 5 address lines but the number of scan lines is 20 so the address lines need to roll over at 0x14.

It's currently not certain whether the configuration registers are nonvolatile - it's possible that the drivers need to be configured at every power up. According to the datasheet, the scanlines settings defaults to `4`.

## Pictures

{{< figure src="dmg1083_pcb.jpeg" >}}
{{< figure src="dmg1083_pcb.jpeg.svg" >}}
{{< figure src="pinout_silkscreen.jpeg" >}}
