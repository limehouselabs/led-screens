---
title: DMG1083
---
# DMG1083 LED Tiles

<table class="vertical">
<tr><th>Manufacturer</th><td>digiLED</td></tr>
<tr><th>Model</th><td>DMG1083</td></tr>
<tr><th>Size</th><td>250×250 mm</td></tr>
<tr><th>Resolution</th><td>78×78 px (TBC)</td></tr>
<tr><th>Colour depth</th><td>14-bit</td></tr>
<tr><th>Pixel pitch</th><td>~3 mm (TBC)</td></tr>
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

The driver chips are Macroblock [MBI5153](/datasheets/MBI5153GP-A.pdf) 16-Channel PWM Constant Current LED Drivers. Unlike the previous generation of tiles, these drivers support 14-bit PWM dimming on-chip.

The board also features a flash chip (neatly labelled in a box on the silkscreen) which seems likely to contain panel-specific calibration data. Maybe.

## Interface
The pins are labelled:
|  |  |
|-----|--------|
| CS | SLK |
| A |  B |
| OE | LAT |
| CLK | NC |
| C | D |
| E | R1 |
| G1 | B1 |
| GND | R2 |
| G2 | B2 |
| R3 | G3 |
| B3 | GND |
| R4 | G4 |
| B4 | NC |
| SR | NC |
| MSI | MSO |

With the top and bottom rows likely to be just for the flash chip.

The other pins for the panel itself look like 4x R G and B shift registers, with 5 bit address(?)

## Pictures

{{< figure src="dmg1083_pcb.jpeg" >}}
{{< figure src="pinout_silkscreen.jpeg" >}}