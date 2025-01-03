---
title: Log
---
# LED Floor Log

## 2025-01-02

Attempts to correct the module layout result in disaster:

* Found [XMPlayer 3.1.60 in English](../../controllers/dbstar/XMPlayer_3.1.60.exe) which successfully talked to the controller.
* Fetched the config from the system and saved it ([controller](./configs/controller-20250102.rspc), [display](./configs/display-20250102.rspd), [receiver](./configs/receiver-20250102.rspr), [export](./configs/export-20250102.rsps)).
* Accidentally hit the "preview" button. **This broke the receiver cards on the 12 modules which were connected to the sender at the time.** (Garbled output.)
    * Tried power-cycling, the issue persisted.
    * So much for "preview"
* Tried restoring from the saved configs. No luck.
* Panels which were not connected to the sender at the time of "preview" still work fine.
    * Tried again to fetch config from one of those and send to the working modules, but this still fails.
* Tried an older version of XMPlayer but this wouldn't run on Matt's Windows laptop
    * Maybe an incompatibility with the newer version?
    * We should try this on a clean machine
* Basil tried brute-forcing the receiver card config from scratch, but this didn't yield much luck.
* Russ disassembled one of the modules to determine the driver (it's JXI5020GP, see [internals](../internals)).

Upshot: **12 modules are now in a broken state.** We have 4 still-working modules (though two have very broken backshells) which are labelled with a "working config" label.

Hypothesis: there is an incompatibility between the firmware version on the receiver cards and the config sent by XMPlayer 3.1.

Next steps: try and get an older version of XMPlayer working.

## 2024-12-31

Got the floor working for the NYE party. This is the module order we got working:

|     |     |     |
|-----|-----|-----|
| 1-1 | 1-2 | 5-1 |
| 2-1 | 2-2 | 6-1 |
| 3-1 | 3-2 | 7-1 |
| 4-1 | 4-2 | 8-1 |

We used this command to play a video on the screen and unfuck the order of the modules, but this shouldn't be necessary once we work out how to configure the layout:

```
ffplay -vf "transpose=1,scale=144:192,setsar=1:1,pad=width=192:height=192:x=0:y=0:color=black,stereo3d=sbsl:abl,pad=width=1600:height=1200:x=0:y=0:color=black" video.mp4
```