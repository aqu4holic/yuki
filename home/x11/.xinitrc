#! /usr/bin/env fish

if [-z "$DISPLAY" ] && ( [ "$XDG_VTNR" == 1 ] || [ "$(tty)" == "/dev/tty1" ]); then
    exec startx
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

sxhkd &
exec bspwm
