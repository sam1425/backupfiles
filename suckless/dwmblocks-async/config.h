#ifndef CONFIG_H
#define CONFIG_H
#define DELIMITER "    "

/* X("", "[ ! -f \"$HOME/.is_laptop\" ] && printf '' && exit 0; case $BLOCK_BUTTON in 1) pgrep -x onboard >/dev/null && pkill onboard || onboard & ;; esac; printf ' ⌨ '", 0, 2)\ */

#define YAD "GDK_SCALE=2 GDK_DPI_SCALE=1.0 yad --calendar --class='Yad' --undecorated --fixed --no-buttons --position=mouse --width=300 --height=200;"
#define MAX_BLOCK_OUTPUT_LENGTH 45
#define CLICKABLE_BLOCKS 1
#define LEADING_DELIMITER 0
#define TRAILING_DELIMITER 0
#define BLOCKS(X)             \
    X("", "\
    status=$(playerctl status 2>/dev/null); \
    [ \"$BLOCK_BUTTON\" = \"1\" ] && playerctl play-pause; \
    if [ \"$status\" = \"Playing\" ]; then \
        playerctl metadata --format '󰎆 {{ title }}'; \
    elif [ \"$status\" = \"Paused\" ]; then \
        playerctl metadata --format '󰏤 {{ title }}'; \
    fi", 0, 1)\
    X("", "case $BLOCK_BUTTON in \
            1) pavucontrol >/dev/null 2>&1 & ;; \
            3) pamixer -t ;;  \
           esac;\
           [ \"$(pamixer --get-mute)\" = \"true\" ] && echo '! !' || pamixer --get-volume", 0, 10)\
    X("", "s=$(cat /tmp/dt_st 2>/dev/null || echo 0); \
    [ \"$BLOCK_BUTTON\" = \"1\" ] && " YAD " [ \"$BLOCK_BUTTON\" = \"3\" ] \
    && s=$(((s+1)%4)) && echo $s > /tmp/dt_st; \
    case $s in  \
            0) date '+%B %d' ;; \
            1) date '+%d/%m' ;; \
            2) date '+%Y-%m-%d' ;; \
            3) date '+%A' ;;  \
    esac \
    ", 0, 3)\
    X("", "date '+%I:%M %p'", 1, 4)\
    X("", "s=$(cat /tmp/x_st 2>/dev/null || echo 0); [ \"$BLOCK_BUTTON\" = \"1\" ] && s=$(((s+1)%2)) && echo \"$s\" > /tmp/x_st; [ \"$s\" = \"1\" ] && echo \"X\" || echo \" \"",   0,                    30) \
    X("", "~/Documents/Programming/c/projects/habit_tracker/main",   0,                    5) \
    X("",     "printf '%1s'  ''",                    0,              0)
#endif  // CONFIG_H
