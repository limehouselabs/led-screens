---
title: LED Floor
---
# LED Floor

This is a small LED floor, with 16 panels.

* Square tiles with 48x48 LEDs, made from 4 24x24 subpanels
* DBStar XMPlayer software configures the sender/reciever modules
  * BEWARE it's very easy to break it in this software, even if you backup the config first
  * Pressing the Preview button in the software has broken the screen output for us.

Resolution, details, etc TBC.

It uses a DBStar controller system, which is not the easiest to work with.

## Playing stuff
On 2025-01-02, we broke it while trying to make it display the content in the correct order. This happened when pressing the Preview button in the DBStar XMPlayer software.

This is the screen order we got working on 2024-12-31.

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
## Photos

{{< figure src="./images/led_floor.jpg">}}
{{< figure src="./images/tile_rear_case.jpeg">}}
{{< figure src="./images/tile_connections.jpeg">}}
{{< figure src="./images/tile_internals1.jpeg">}}
{{< figure src="./images/tile_internals2.jpeg">}}
{{< figure src="./images/tile_internals3.jpeg">}}
{{< figure src="./images/tile_driver.jpeg">}}
