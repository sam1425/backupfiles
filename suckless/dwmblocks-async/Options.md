

//X("", "case $BLOCK_BUTTON in 1) st -n pulsemixer -e pulsemixer & ;; 3) pamixer -t ;; esac; pamixer --get-volume", 0, 10)
//X("󰎆 ", "playerctl metadata --format '{{ title }} - {{ artist }}' 2>/dev/null || echo 'Stopped'", 5, 7)
//X(" ", "[ \"$(pamixer --get-mute)\" = \"true\" ] && echo '! !' || pamixer --get-volume", 0, 10)

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

