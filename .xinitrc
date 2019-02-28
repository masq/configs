#!/bin/sh

# merge xresources in so they are used
xrdb -merge $HOME/.Xresources

# start the urxvt (our terminal emulator) daemon
urxvtd -q -o -f

# attempt to start f.lux
xflux -z 98125

# start our window manager
exec i3
