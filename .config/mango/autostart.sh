#!/usr/bin/env sh
# Mango autostart (translated from ~/.dwm/autostart.sh)
# Exports to ensure DISPLAY/XAUTHORITY for session-run services
export DISPLAY=${DISPLAY:-:0}
export XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}

# set wallpaper
feh --bg-scale --randomize "$HOME/Pictures/wallpaper/" >/dev/null 2>&1 &

# xorg settings
xset s noblank
xset s off -dpms
xset r rate 200 300

# Daemons
"$HOME"/Documents/Programming/c/dwm/dwmblocks-async/updatemusic.sh >/dev/null 2>&1 &
# start dwmblocks if present
if command -v dwmblocks >/dev/null 2>&1; then
  dwmblocks >/dev/null 2>&1 &
  echo $! > /tmp/dwmblocks.pid
fi

clipmenud --primary >/dev/null 2>&1 &
dunst >/dev/null 2>&1 &
unclutter idle 5 >/dev/null 2>&1 &

# start gesture daemon if available
if command -v libinput-gestures >/dev/null 2>&1; then
  libinput-gestures-setup start >/dev/null 2>&1 || true
fi

# GUI apps (start if not already running)
pgrep -x firefox >/dev/null || firefox >/dev/null 2>&1 &
pgrep -x emacs >/dev/null || emacs >/dev/null 2>&1 &
pgrep -x obsidian >/dev/null || obsidian >/dev/null 2>&1 &

# terminal apps
pgrep -f "st -n nchat" >/dev/null || st -n nchat -e nchat &

exit 0
