#!/usr/bin/env bash

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

export QT4_IM_MODULE=ibus

export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus

if [[ -z "$DISPLAY" && ( "$XDG_VTNR" = 1 || "$(tty)" = "/dev/tty1" ) ]]; then
    exec startx
fi