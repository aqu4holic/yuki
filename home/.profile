if [ -z "$DISPLAY" ] && ( [ "$XDG_VTNR" = 1 ] || [ "$(tty)" = "/dev/tty1" ] ); then
    exec startx
fi