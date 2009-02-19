#!/bin/sh
urxvtd -q -f -o &
xsetroot -solid black -cursor_name left_ptr &
xmodmap ~/.Xmodmap
exec ratpoison
