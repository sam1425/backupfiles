#ifndef CONFIG_H
#define CONFIG_H
#define DELIMITER "  \x03⎸ "
#define DELIMITER_TRAILING "  \x03⎸"

#define YAD "GDK_SCALE=2 GDK_DPI_SCALE=1.0 yad --calendar --class='Yad' --undecorated --fixed --no-buttons --position=mouse --width=300 --height=200;"
#define MAX_BLOCK_OUTPUT_LENGTH 45
#define CLICKABLE_BLOCKS 1
#define LEADING_DELIMITER 0
#define TRAILING_DELIMITER 1
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
    && s=$(((s+1)%3)) && echo $s > /tmp/dt_st; \
    case $s in  \
            0) date '+%B %d' ;; \
            1) date '+%A' ;;  \
            2) date '+%d/%m' ;; \
    esac \
    ", 0, 11)\
    X("", "date '+%I:%M %p' | xargs -I{} printf \"  \\003%s\" \"{}\"", 1, 12)\
    X("", "~/Documents/Programming/c/projects/habit_tracker/main",   0,                    15)
#endif  // CONFIG_H
