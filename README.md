We have a lot of LED screen panels (200 or something?), let's make them work.

The panels were manufactured by digiLED and originally donated to London Hackspace. There's some info [on their wiki](https://wiki.london.hackspace.org.uk/view/LED_tiles_V2). They are 64x16 pixels.

## Interface

Each panel has three sets of 2x4 2.54mm pin headers. The top one is +5V, the middle is data, and the bottom is ground. There is **no polarity protection** on the panel - connecting power incorrectly will damage them.

Data connectors have D1 and D2 (data channels), A0 and A1 (address channels), LAT, OE, and CLK.

## Driving

We have the [Novastar MSD300](http://www.novastar-led.com/product_detail.php?id=67&cid=40&pid=23) sender card. This takes DVI and converts it to what is apparently Ethernet, which is sent to the [receiver cards](https://www.novastar.tech/receiving-cards). 

The receiver cards receive data over ethernet and then output the screen protocol. The card recommended by the donor was the Novastar MRV336 (note: not MRV366), but these cards only output HUB75 which is not the protocol used by these screens.

An appropriate receiver card is probably the MRV420/MRV300 which supports "64-group serial data mode". This is broken down into groups of channels which have 4 address lines (A, B, C, D), 16/32 data lines, as well as OE, LAT, and CLK outputs. 

As each LED screen panel uses 2 address lines and 2 data lines, we should probably be able to have two panels share the same pair of data lines, which equates to 64 panels per receiver card. The MRV300 card only supports 256x226 pixels though, which equates to 4x14 = 56 panels.

# Proposed electrical setup
![Layout Diagram](/diagrams/diag.png)

## Power

Panels require 5V 8A (40W) at max brightness. It would be nice to minimise the number of switch-mode power supplies connected to the mains to reduce earth leakage, by using a higher DC intermediate voltage, but 5A 300W power supplies are cheaper than the DC-DC converters alone.

## Components

This requires 3 components to be manufactured:

### Connector board
One per panel. Plugs onto the back of the panel and passively breaks out power and data into useful (polarised!) connectors. Design files [here](./panel-connector).

### Intermediate distribution board
Manages a group of 8 panels. 5V 60A supply from PSU, individual panel power and data connection out.

Data input: Address lines x4, data lines x8, OE, LAT, CLK, data ground (total 16 lines)

### Receiver breakout board

Break out the headers on the receiver board to 10x connectors to send data to the intermediate board. The receiver card needs 5V 0.5A (2.5W).

## Cost

Approx cost per group of 56panels (excluding sender card):

* [5V 300W PSU](https://www.aliexpress.com/store/product/G-energy-N300V5-A-Slim-300W-LED-Display-Power-Supply-Size-212-83-30mm-300W-LED/709678_32638656794.html) x 7 = £112
* MRV300 receiver card = £23
* Receiver breakout board = £5
* Intermediate distribution board x 7 = £22
* Intermediate-panel wiring x 56 = £70
* Mains wiring = £25
* Receiver-intermediate wiring x 7 = £18

Total: £285
