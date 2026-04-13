
#Debug
#exec > ~/tmp-dwm-autostart.log 2>&1
#set -x

#xrandr --output eDP1 --mode 1368x768
feh --bg-scale --randomize ~/Pictures/wallpaper/ 
#unison workspace >/dev/null 2>&1 &
#deskflow&

#xorg config
xset s noblank
xset s off -dpms
xset r rate 200 30

# Daemons 
/home/c0mplex/Documents/Programming/c/dwm/dwmblocks-async/updatemusic.sh >/dev/null 2>&1 &
dwmblocks >/dev/null 2>&1 & echo $! > /tmp/dwmblocks.pid
clipmenud --primary >/dev/null 2>&1 &
dunst >/dev/null 2>&1 &
unclutter idle 5 >/dev/null 2>&1 &

# GUI Apps 
pgrep -x firefox >/dev/null || firefox >/dev/null 2>&1 &
pgrep -x emacs   >/dev/null || emacs >/dev/null 2>&1 &

# Terminal
#pgrep -f "st -n basalt" >/dev/null || st -n basalt -e basalt &
pgrep -f "st -n nchat"  >/dev/null || st -n nchat  -e nchat  &
