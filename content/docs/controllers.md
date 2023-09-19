---
title: Commercial Controllers
weight: 50
---
# Commercial LED Controllers

If you want to display video on more than a handful of LED tiles, the requirements for I/O lines and higher bitrates quickly add up.

Off-the-shelf video wall controllers from China are surprisingly cheap and almost universally used, even in high-end Western-designed video walls. Common brands include Novastar, Colorlight, Linsn, and DBStar. Systems from these manufacturers are all suspiciously similar in appearance and operation, although they are not compatible with each other. Novastar generally appears to be the best option.

They consist of a "sender" which accepts video (normally in DVI format), and converts it to Ethernet. "Receivers" connect to the sender and output the raw LED panel protocol. Receivers can generally drive 10,000-500,000 pixels each -- in commercial video wall systems there's normally one receiver per display module, with many modules daisy-chained together to form a full wall.

An entry-level sender (generally good for up to 1.3 megapixels) is $100-150 and a receiver card is $15-40. [led-card.com](https://www.led-card.com) is a good place to buy them from.

(Receiver cards are so cheap, with a powerful FPGA, dual Ethernet, and plentiful I/O breakouts, that they're [used by some hobbyists as FPGA devboards](https://github.com/q3k/chubby75).)

## Receiver card selection

Manufacturers will offer many different receiver cards for different purposes. Sometimes those purposes are poorly documented and difficult to determine (perhaps some cards developed for specific downstream manufacturers have ended up on the general market).

There are two kind-of-standard LED tile interfaces: HUB75 and HUB320. Video wall tiles from the last decade generally don't use HUB75 as it's designed for smaller tiles. HUB320 seems to be more of a standard these days, but even then, connector pinouts often don't match.

## Configuration

Receiver cards need to be configured with the specific details of the LED driver protocol, which differs between different models of tiles. Receiver configuration is the trickiest part, particularly as the software is often badly-translated from Chinese, and getting this right may require talking to the controller manufacturer. You'll need to know the details of the shift-register driver chip in your tiles, and how they are interfaced.

If you have more than one receiver card, the sender card needs to be configured with the arrangement of your modules, the order they're connected in, what size of display it should pretend to be, and where the modules live inside that virtual screen.

## Quirks

Senders and receivers are universally connected using Ethernet cables, but they are not Ethernet as we normally know it - they just use it as a convenient, low-cost gigabit bus. The Ethernet physical layer is used, but not the MAC layer, so if you connect a normal computer to it, all you'll see is checksum errors.

For some reason, senders are often in PCI card format, but they don't need to be in a PCI slot to operate (and they often aren't in commercial installations). They can be powered from an external 5V supply and are configured over an external USB port. (They can presumably be powered from the PCI port, with the DVI and USB jumpered externally to the host computer, but I've never tried it.)