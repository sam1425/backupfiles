- icons
                         


Bug fix: the terminal would go crazy and alternate between normal and insert mode also giving a bell signal to dwm
    fuser -v $(tty)
    this checks if there is any processes bothering with the current terminal
    allways use  >/dev/null 2>&1 & so return & errors & output are ignored

Previous versions of shellexecute
//static const char *dmenubash[]            = { "sh", "-c", "dmenu < /dev/null | xargs -I {} zsh -ic '{}'", NULL };
//static const char *dmenubash[] = { "sh", "-c", "cmd=$(dmenu < /dev/null) && [ -n \"$cmd\" ] && notify-send \"Output\" \"$(bash -c \"$cmd\" 2>&1)\"", NULL };
