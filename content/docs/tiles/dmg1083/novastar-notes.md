# Driving the DMG1093 with the Novastar controller

## 2023-09-15

I had a go at driving this with the Novastar MCTRL300/MRV300. Limited success was had.

* The screen is actually an 80x80 screen with 2 rows/cols removed, should be configured as 80x80 in the software.
* The screen is connected to the MRV300 according to the "20-group parallel data mode" pinout in the MRV300 datasheet.
* The NovaLCT smart config wizard appears to deal with these missing rows/cols in the "irregular" mode, but I had more luck configuring it in "regular" mode for some reason.
* However, when the receiver card is configured for 20-group mode, the display output is garbled.
* It mostly works when NovaLCT is configured for 24-group hub mode, except now the `E` address line is getting data instead of address, which results in mostly-blank sections of the screen with ghosting. (Verified with logic analyser. Disconnecting `E` removes the ghosting.)
* The software was generating a configuration with 1:10 scan rate, when I think this should be 1:20 -- 6400 pixels total divided by 320 column drivers (20 chips with 16 channels each).
* NovaLCT reports a different model of receiver card for some reason -- maybe this is an issue?
* Occasionally the screen fades out in a rather pleasing way when driven brightly. I suspect/hope this is due to voltage drop and I need to construct some better power cables.

It's possible there is some receiver card incompatibility here. I've ordered an MRV432 to see if I have more luck with that one. At least we know the screen works in principle.

{{< figure src="../20230915-test.jpg">}}