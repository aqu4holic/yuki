#! /usr/bin/env fish

if test -z "$DISPLAY" -a \( "$XDG_VTNR" = 1 -o "$(tty)" = "/dev/tty1" \)
    exec startx
end
