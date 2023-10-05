# Electronic Details

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

{{< figure src="../dmg1083_pcb.jpeg.svg" >}}
