#ifndef CONFIG_H
#define CONFIG_H
#define DELIMITER "  |  "

#define MAX_BLOCK_OUTPUT_LENGTH 45
#define CLICKABLE_BLOCKS 1
#define LEADING_DELIMITER 0
#define TRAILING_DELIMITER 0

//X("", "pamixer --get-volume", 0, 10)
//X("", "case $BLOCK_BUTTON in 1) st -n pulsemixer -e pulsemixer & ;; 3) pamixer -t ;; esac; pamixer --get-volume", 0, 10)
//X("󰎆 ", "playerctl metadata --format '{{ title }} - {{ artist }}' 2>/dev/null || echo 'Stopped'", 5, 7)
//X(" ", "[ \"$(pamixer --get-mute)\" = \"true\" ] && echo '! !' || pamixer --get-volume", 0, 10)
//X("", "s=$(cat /tmp/dt_st 2>/dev/null || echo 0); [ \"$BLOCK_BUTTON\" = \"1\" ] && s=$(((s+1)%3)) && echo $s > /tmp/dt_st; case $s in 0) date '+%B %d' ;; 1) date '+%d/%m' ;; 2) date '+%Y-%m-%d' ;; esac", 0, 1)

//󰎆	\uf0386 (Music Note)
//󰐊	\uf040a (Play Circle)
//󰏤	\uf03e4 (Pause Circle)
//󰓛	\uf04db (Stop Square)
//󰓇	\uf04c7 (Record)
//	\uf147d (Music Box)
//󰓠	\uf04e0 (Levels)
//󰲸	\uf0cbc (List)
//󰠃	\uf0803 (Microphone)
//󰒮 󰒭
//
//Muted	󰝟	\uf075f (Volume Off/Mute)
//Low (1-33%)	󰕿	\uf057f (Volume Low)
//Medium (34-66%)	󰖀	\uf0580 (Volume Mid)
//High (67-100%)	󰕾	\uf057e (Volume High)
//Headphones	󰋋	\uf02cb (Headphones)
//Earbuds	󰋎	\uf02ce (Earbuds)
//Bluetooth Audio	󰂰	\uf00b0 (BT Audio)
//Speaker		\uf04c3 (Speaker)
//󰐊
//󱑽
//Active: 󰎆 (Aqua/Green)
//Paused: 󰏤 (Yellow/Orange)
//High Volume: 󰕾 (Red/Purple)

#define BLOCKS(X)             \
    X("", "status=$(playerctl status 2>/dev/null); if [ \"$status\" = \"Playing\" ]; then [ \"$BLOCK_BUTTON\" = \"1\" ] && playerctl pause; playerctl metadata --format '󰎆 {{ title }}'; elif [ \"$status\" = \"Paused\" ]; then [ \"$BLOCK_BUTTON\" = \"1\" ] && playerctl play; playerctl metadata --format '󰏤 {{ title }}'; fi", 0, 1)\
    X("", "case $BLOCK_BUTTON in 1) pavucontrol >/dev/null 2>&1 & ;; 3) pamixer -t ;; esac; [ \"$(pamixer --get-mute)\" = \"true\" ] && echo '! !' || pamixer --get-volume", 0, 10)\
    X("", "s=$(cat /tmp/dt_st 2>/dev/null || echo 0); [ \"$BLOCK_BUTTON\" = \"1\" ] && yad --calendar --class='Yad' --undecorated --fixed --no-buttons --position=mouse; [ \"$BLOCK_BUTTON\" = \"3\" ] && s=$(((s+1)%3)) && echo $s > /tmp/dt_st; case $s in 0) date '+%B %d' ;; 1) date '+%d/%m' ;; 2) date '+%Y-%m-%d' ;; esac", 0, 3)\
    X("", "date '+%I:%M %p'", 60, 0)\
    X("", "[ ! -f \"$HOME/.is_laptop\" ] && printf '' && exit 0; case $BLOCK_BUTTON in 1) pgrep -x onboard >/dev/null && pkill onboard || onboard & ;; esac; printf ' ⌨ '", 0, 2)\
    X("",     "printf '%1s'  ''",                    0,              0)

#endif  // CONFIG_H
