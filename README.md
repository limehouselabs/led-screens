We have a lot of LED screen panels (200 or something?), let's make them work.

The panels were manufactured by digiLED and originally donated to London Hackspace. There's some info [on their wiki](https://wiki.london.hackspace.org.uk/view/LED_tiles_V2).

## Interface

Each panel has three sets of 2x4 2.54mm pin headers. The top one is +5V, the middle is data, and the bottom is ground. There is **no polarity protection** on the panel - connecting power incorrectly will damage them.

Data connectors have D1 and D2 (data channels), A0 and A1 (address channels), LAT, OE, and CLK.

## Driving

We have the [Novastar MSD300](http://www.novastar-led.com/product_detail.php?id=67&cid=40&pid=23) sender card. This takes DVI and converts it to what is apparently Ethernet, which is sent to the [receiver cards](https://www.novastar.tech/receiving-cards). 

The receiver cards receive data over ethernet and then output the screen protocol. The card recommended by the donor was the Novastar MRV336 (note: not MRV366), but these cards only output HUB75 which is not the protocol used by these screens.

An appropriate receiver card is probably the MRV420 which supports "64-group serial data mode". This is broken down into 4 groups of channels which have 4 address lines (A, B, C, D) and 16 data lines, as well as OE, LAT, and CLK outputs. 

As each LED screen panel uses 2 address lines and 2 data lines, we should probably be able to have two panels share the same pair of data lines, which equates to 64 panels per receiver card. However, due to the physical layout below, 60 panels is more convenient.

# Proposed electrical setup
![Layout Diagram](/diagrams/diag.png)

## Power

For power distribution, we want to minimise the number of switch-mode power supplies connected to the mains to reduce earth leakage. In order to minimise voltage drop at 5V this necessitates an intermediate distribution voltage (probably 24V).

The largest economical 24V power supply appears to be 960W which is enough to run 24 panels (4 groups of 6). 600W supplies appear to be cheaper. A group of 60 panels requires 2400W (3x 960W or 4x 600W).

## Components

This requires 3 components to be manufactured:

### Connector board
One per panel. Plugs onto the back of the panel and passively breaks out power and data into useful (polarised!) connectors. Design files [here](./panel-connector).

### Intermediate distribution board
Manages a group of 6 panels. 24V and bulk data in. 5V and individual panel data connection out.

Power output: 5A 48A (240W)
Power input: 24V 10A

Will need a DC-DC converter. The largest practical one is 40A which is probably sufficient.

Data input: Address lines x4, data lines x6, OE, LAT, CLK, data ground (total 14 lines)

### Receiver breakout board

Break out the headers on the receiver board to 10x connectors to send data to the intermediate board.

May also have a small DC-DC converter to simplify power routing. The receiver card needs 5V 0.5A (2.5W).

## Cost

Approx cost per group of 60 panels (excluding sender card):

* [24V 600W PSU](https://www.aliexpress.com/item/12-Volt-Power-Supply-24-Volt-5V-36V-48V-LED-Driver-Adapter-12V-Switching-Power-Supply/32840389365.html) x 4 = £116
* [MRV420 receiver card](https://controller-led.com/collections/led-receiving-card/products/novastar-class-b-led-receiving-card-mrv560-mrv470-mrv420-mrv410-led-display-controller) = £23
* Receiver breakout board = £5
* Intermediate distribution board x 10 = £30
* DC-DC converter x 10 = £175
* Intermediate-panel wiring x 60 = £70
* PSU-intermediate wiring x 10 = £20
* Receiver-intermediate wiring x 10 = £25

Total: £464
