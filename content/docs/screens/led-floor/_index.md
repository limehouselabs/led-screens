---
title: LED Floor
---
# LED Floor

This is a small LED floor, with 15 panels.

* Square tiles with 48x48 LEDs, made from 4 24x24 subpanels
* Shows up as 1600x1200 on the computer, top left portion goes to the screen

Resolution, details, etc TBC.

It uses a DBStar controller system, which is not the easiest to work with.

## Photos

{{< figure src="./images/led_floor.jpg">}}
{{< figure src="./images/tile_rear_case.jpeg">}}
{{< figure src="./images/tile_connections.jpeg">}}
{{< figure src="./images/tile_internals1.jpeg">}}
{{< figure src="./images/tile_internals2.jpeg">}}
{{< figure src="./images/tile_internals3.jpeg">}}
{{< figure src="./images/tile_driver.jpeg">}}

## Playing stuff
This is the screen order we got working on 2024-12-31

|     |     |     |
|-----|-----|-----|
| 1-1 | 1-2 | 5-1 |
| 2-1 | 2-2 | 6-1 |
| 3-1 | 3-2 | 7-1 |
| 4-1 | 4-2 | 8-1 |

This command will play a video on the screen and unfuck the order of the panels:

```
ffplay -vf "transpose=1,scale=144:192,setsar=1:1,pad=width=192:height=192:x=0:y=0:color=black,stereo3d=sbsl:abl,pad=width=1600:height=1200:x=0:y=0:color=black" video.mp4
```