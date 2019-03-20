#!/usr/bin/env bash

# take a screenshot and save that to /tmp/lockpic.png
scrot /tmp/lockpic.png

# add a blur, make it grayscale and save that, overwriting the first picture
convert /tmp/lockpic.png -blur 0x5 -grayscale Rec709Luma /tmp/lockpic.png

#add the overlay located at ~/.cheeselock/arch-logo-2.png to the blurred screenshot and save that as /tmp/lockpic.png
#composite ~/.cheeselock/arch-logo-2.png /tmp/lockpic.png /tmp/lockpic.png

#start i3lock with the overlayed + blurred picture at /tmp/lockpic.png
i3lock -e -i /tmp/lockpic.png
