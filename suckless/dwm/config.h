/* sam's dwm build */

#include <X11/XF86keysym.h>
#define CLICKABLE_BLOCKS 1
/* appearance */
static unsigned int             borderpx        = 1;            /* border pixel of windows */
static unsigned int             snap            = 32;           /* snap pixel */
static const unsigned int       gappih          = 0;            /* horiz inner gap between windows */
static const unsigned int       gappiv          = 0;            /* vert inner gap between windows */
static const unsigned int       gappoh          = 0;            /* horiz outer gap between windows and screen edge */
static const unsigned int       gappov          = 0;            /* vert outer gap between windows and screen edge */
static int                      smartgaps       = 0;            /* 1 means no outer gap when there is only one window */
static const int                swallowfloating = 0;            /* 1 means swallow floating windows by default */
static int                      showbar         = 1;            /* 0 means no bar */
static const int                showtitle       = 0;            /* 0 means no title */
static const int                showtags        = 1;            /* 0 means no tags */
static const int                showlayout      = 0;            /* 0 means no layout indicator */
static const int                showstatus      = 1;            /* 0 means no status bar */
static const int                showfloating    = 0;            /* 0 means no floating indicator */
static int                      topbar          = 1;            /* 0 means bottom bar */
static int                      lrpad           = 20;           /* left and right padding for text */
//static char                     dmenufont[]             = "monospace:size=14";
static const char               *fonts[]        = {
	"PixellariMono:size=14:antialias=true:autohint=false",
	"Hack Nerd Font:size=12:antialias=false:autohint=true",
	"NotoColorEmoji:pixelsize=14:antialias=true:autohint=true"
};

static char                     normbgcolor[]           = "#111314";
static char                     normbordercolor[]       = "#282828";
static char                     normfgcolor[]           = "#EBDBB2";
static char                     selfgcolor[]            = "#141c21";
static char                     selbordercolor[]        = "#289c93";
static char                     selbgcolor[]            = "#b48ead";

static char                     *colors[][3]            = {
	/*               fg           bg           border   */
	[SchemeNorm]            = {normfgcolor, normbgcolor,    normbordercolor   },
	[SchemeSel]             = {selbgcolor, selbordercolor, selfgcolor        },
	[SchemeStatus]          = {normfgcolor, normbgcolor,    normbgcolor       },    /* status R */
	[SchemeTagsSel]         = {selbordercolor, normbgcolor,    normbgcolor       }, /* tag L selected */
	[SchemeTagsNorm]        = {normfgcolor, normbgcolor,    normbgcolor       },    /* tag L unselected */
	[SchemeInfoSel]         = {normfgcolor, normbgcolor,    normbgcolor       },    /* info M selected */
	[SchemeInfoNorm]        = {normfgcolor, normbgcolor,    normbgcolor       },    /* info M unselected */
};

// static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
// static const char *tags[] = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳", "󰎶", "󰎹", "󰎼" };
// static const char *tags[] = {" I ", "I I", "III", "I V", "V", "V I", "VII", "VIII", "I X"};
static const char               *tags[] = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};

static const Rule               rules[] = {
	/*
	 * xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */ /* class         instance        title      tags    mask  isfloating  isterminal  noswallow monitor */
	//terminal
	{ NULL,          "pulsemixer",    NULL,                     0,                     1,         1,          1,          -1         },
	{"kitty",        NULL,            NULL,                     0,                     1,         1,          0,          -1         },
	{"st",           "basalt",        NULL,                     1 << 3,                0,         1,          0,          -1         },
	{"st",           "nchat",         NULL,                     1 << 4,                0,         1,          0,          -1         },
	{"st",           "floating",      NULL,                     0,                     1,         1,          0,          -1         },
	{"st",           "yazi",          NULL,                     0,                     1,         1,          0,          -1         },
	{"pavucontrol",  NULL,            NULL,                     0,                     1,         0,          0,          -1         },
	{"feh",          NULL,            NULL,                     0,                     1,         0,          0,          -1         },
	{"fzfmenu",      NULL,            "fzf",                    0,                     1,         1,          1,          -1         },
	{"Deskflow",     NULL,            NULL,                     1 << 10,               0,         0,          0,          -1         },
	{NULL,           "Deskflow",      NULL,                     1 << 10,               0,         0,          0,          -1         },
	{NULL,           NULL,            "Deskflow",               1 << 10,               0,         0,          0,          -1         },
	{NULL,           NULL,            "Event Tester",           0,                     0,         0,          1,          -1         },
	//apps
	{NULL,           "sublime_text",  NULL,                     1 << 1,                0,         0,          1,          -1         },
	{"sublime_text", NULL,            "sublime_text",           1 << 1,                0,         -1,         0,          -1         },
	{"Emacs",        NULL,            NULL,                     1 << 1,                0,         0,          1,          -1         },
	{"firefox",      NULL,            NULL,                     1 << 2,                0,         0,          1,          -1         },
	{"obsidian",     NULL,            NULL,                     1 << 3,                0,         0,          0,          -1         },
	{"discord",      NULL,            NULL,                     1 << 3,                0,         0,          0,          -1         },
	{"Spotify",      NULL,            NULL,                     1 << 4,                0,         0,          0,          -1         },
};

#include "vanitygaps.c"

/* layout(s) */
static const float              mfact           = 0.55; /* factor of master area size [0.05..0.95] */
static const int                nmaster         = 1;    /* number of clients in master area */
static const int                resizehints     = 0;    /* 1 means respect size hints in tiled resizals */
static const int                lockfullscreen  = 0;    /* 1 will force focus on the fullscreen window */

static const Layout             layouts[]       = {
	/* alt glyphs: 󱡗 󱏋 */
	/* symbol     arrange function */
	{"", tile   }, /* first entry is default */
	{"󰇥", NULL   }, /* no layout function means floating behavior */
	{"󰫥", monocle},
	{"󱏋", spiral },
	{"󱡗", dwindle},
};

/* key definitions */
#define WINKEY Mod4Mask // windows key
#define MODKEY Mod1Mask // Alt
#define TAGKEYS(KEY, TAG)                                                  \
	{MODKEY, KEY, view, {.ui = 1 << TAG}},                             \
	{MODKEY | ControlMask, KEY, toggleview, {.ui            = 1 << TAG}}, \
	{MODKEY | ShiftMask, KEY, tag, {.ui                     = 1 << TAG}},          \
	{MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},
#define STACKKEYS(MOD, ACTION)                      \
	{MOD, XK_h, ACTION ## stack, {.i = INC(+1)}}, \
	{MOD,                               \
	 XK_l,                       \
	 ACTION ## stack,              \
	 {.i = INC(-1)}},                /*{ MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \
	                                    { MOD, XK_q,     ACTION##stack, {.i = 0 } }, \
	                                    { MOD, XK_a,     ACTION##stack, {.i = 1 } }, \
	                                    { MOD, XK_z,     ACTION##stack, {.i = 2 } }, \
	                                    { MOD, XK_x,     ACTION##stack, {.i = -1 } }, */

/* spawning shell commands */
#define SHCMD(cmd)                                                   \
	{                                                            \
		.v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } \
	}

/* launch gtk application */
#define GTKCMD(cmd)                                                        \
	{                                                                  \
		.v = (const char *[]) { "/usr/bin/gtk-launch", cmd, NULL } \
	}

#define STATUSBAR "dwmblocks"
#define BROWSER "firefox"

/* commands */
static char             dmenumon[2]             = "0";
static const char *dmenubash[] = {
    "sh", "-c",
    "cmd=$(dmenu < /dev/null) && [ -n \"$cmd\" ] && "
    "out=$(sh -c \". ~/.scripts/shellaliases; $cmd\" 2>&1) && "
    "[ -n \"$out\" ] && notify-send \"Output\" \"$out\"",
    NULL
};
static const char *i3dmenucmd[] = {
    "sh", "-c",
    "j4-dmenu-desktop --dmenu=\"dmenu -i -b -fn 'Poppins:size=12' -nb '$1' -nf '$2' -sb '$3' -sf '$4'\"",
    "--", normbgcolor, normfgcolor, selbordercolor, selfgcolor,
    NULL
};
static const char       *dmenucmd[]             = {"dmenu_run", "-i", "-b", "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL};
static const char       *clipmenud[]            = {"clipmenu", "-i", "-b", "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL};
static const char       *termcmd[]              = {"st", NULL};
static const char       *termfloatingcmd[]      = {"st", "-n", "floating"};
static const char       *kittyterm[]            = {"kitty", NULL};


static const Arg        tagexec[]               = {
	/* spawn application when tag is middle-clicked */
	{.v     = termcmd},     /* 1 */
	{.v     = termcmd},     /* 2 */
	{.v     = termcmd},     /* 3 */
	{.v     = termcmd},     /* 4 */
	{.v     = termcmd},     /* 5 */
	{.v     = termcmd},     /* 6 */
	{.v     = termcmd},     /* 7 */
	{.v     = termcmd},     /* 8 */
	{.v     = termcmd},     /* 9 */
	/* GTKCMD("gtkapplication") */
};

static const Key        keys[] = {
	/* modifier                        key               function          argument */
	{MODKEY,                           XK_s,                                            spawn,                                     {.v      = dmenubash       }},
	{MODKEY,                           XK_a,                                            spawn,                                     {.v      = i3dmenucmd      }},
	{MODKEY,                           XK_d,                                            spawn,                                     {.v      = dmenucmd        }},
	{MODKEY,                           XK_Return,                                       spawn,                                     {.v      = termcmd         }},
	{MODKEY | ShiftMask,               XK_Return,                                       spawn,                                     {.v      = termfloatingcmd }},
	{MODKEY | ControlMask |ShiftMask,  XK_Return,                                       spawn,                                     {.v      = kittyterm       }},
	{MODKEY,                           XK_q,                                            killclient,                                {0}}, /* quit window */
	{MODKEY | ShiftMask,               XK_b,                                            togglebar,                                 {0}},
	STACKKEYS(MODKEY, focus)
	STACKKEYS(MODKEY | ShiftMask, push){
		MODKEY | ShiftMask, XK_i, incnmaster,{.i = +1}
	},                                                                                                                                                              /* increase # of master windows */
	{MODKEY | ControlMask,             XK_i,                                            incnmaster,                                {.i      = -1              }},   /* decrease # of master windows */
	/*{MODKEY,                           XK_k,                                            setmfact,                                  {.f      = -0.05           }},
	{MODKEY,                           XK_j,                                            setmfact,                                  {.f      = +0.05           }},*/
	{MODKEY,                           XK_Tab,                                          view,                                      {0}},
	{MODKEY,                           XK_0,                                            view,                                      {.ui     = ~0              }},
	{MODKEY | ShiftMask,               XK_0,                                            tag,                                       {.ui     = ~0              }},
	{MODKEY | ControlMask | ShiftMask, XK_q,                                            quit,                                      {1}},                            /* refresh dwm (restartsig) */
	{MODKEY | ShiftMask,               XK_BackSpace,                                    quit,                                      {0}},                            /* quit dwm */
    {MODKEY | ControlMask,             XK_BackSpace,                                     quit,                                     {0}}, /* quit dwm (alt binding) */
	{MODKEY | ShiftMask,               XK_q,                                            killclient,                                {.ui     = 1               }},   /* kill all windows besides current */
	/* { MODKEY|ShiftMask|ControlMask,  XK_q,	 killclient,     {.ui = 2} }, */
	{MODKEY | ControlMask,             XK_backslash,                                    xrdb,                                      {.v      = NULL            }},   /* refresh xrdb; run this when setting new colors */
	{MODKEY,                           XK_t,                                            setlayout,                                 {.v      = &layouts[0]     }},
	{MODKEY,                           XK_f,                                            togglefullscreen,                          {0}},                            /* focus fullscreen patch */
	{MODKEY | ShiftMask,               XK_m,                                            setlayout,                                 {.v      = &layouts[2]     }},   /* monacle */
	{MODKEY,                           XK_y,                                            setlayout,                                 {.v      = &layouts[3]     }},   /* spiral */
	{MODKEY | ShiftMask,               XK_t,                                            setlayout,                                 {.v      = &layouts[4]     }},   /* dwindle */
	{MODKEY | ControlMask,             XK_space,                                        setlayout,                                 {0}},
	{MODKEY,                           XK_space,                                        togglefloating,                            {0}},
	/*{ MODKEY, XK_space,  zoom, {0} },*/
	{MODKEY | ControlMask,             XK_space,                                        focusmaster,                               {0}},
	{MODKEY | ShiftMask,               XK_y,                                            togglesticky,                              {0}},

	/* multi-monitor control */
	{MODKEY,                           XK_bracketright,                                 focusmon,                                  {.i      = -1              }},
	{MODKEY | ShiftMask,               XK_bracketright,                                 tagmon,                                    {.i      = -1              }},
	{MODKEY,                           XK_bracketleft,                                  focusmon,                                  {.i      = +1              }},
	{MODKEY | ShiftMask,               XK_bracketleft,                                  tagmon,                                    {.i      = +1              }},

	/* gaps control */
	{MODKEY,                           XK_minus,                                        incrgaps,                                  {.i      = -3              }},   /* all */
	{MODKEY,                           XK_equal,                                        incrgaps,                                  {.i      = +3              }},
	{MODKEY | Mod1Mask,                XK_i,                                            incrigaps,                                 {.i      = +1              }},   /* inner */
	{MODKEY | Mod1Mask | ShiftMask,    XK_i,                                            incrigaps,                                 {.i      = -1              }},
	{MODKEY | Mod1Mask,                XK_o,                                            incrogaps,                                 {.i      = +1              }},   /* outer */
	{MODKEY | Mod1Mask | ShiftMask,    XK_o,                                            incrogaps,                                 {.i      = -1              }},
	{MODKEY | Mod1Mask,                XK_6,                                            incrihgaps,                                {.i      = +1              }},   /* inner horiz */
	{MODKEY | Mod1Mask | ShiftMask,    XK_6,                                            incrihgaps,                                {.i      = -1              }},
	{MODKEY | Mod1Mask,                XK_7,                                            incrivgaps,                                {.i      = +1              }},   /* inner vert */
	{MODKEY | Mod1Mask | ShiftMask,    XK_7,                                            incrivgaps,                                {.i      = -1              }},
	{MODKEY | Mod1Mask,                XK_8,                                            incrohgaps,                                {.i      = +1              }},   /* outer horiz */
	{MODKEY | Mod1Mask | ShiftMask,    XK_8,                                            incrohgaps,                                {.i      = -1              }},
	{MODKEY | Mod1Mask,                XK_9,                                            incrovgaps,                                {.i      = +1              }},   /* outer vert */
	{MODKEY | Mod1Mask | ShiftMask,    XK_9,                                            incrovgaps,                                {.i      = -1              }},
	{MODKEY | ShiftMask,               XK_equal,                                        togglegaps,                                {0}},
	{MODKEY | ShiftMask,               XK_minus,                                        defaultgaps,                               {0}},

	/* tag keys */
	TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4)
	TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7) TAGKEYS(XK_9, 8)

	/* toggle statusbar pieces individually */
	{
		MODKEY | ControlMask, XK_t, togglebartitle,{0}
	},
	{MODKEY | ControlMask,             XK_s,                                            togglebarstatus,                           {0}},
	{MODKEY | ControlMask,             XK_1,                                            togglebartags,                             {0}},
	{MODKEY | ControlMask,             XK_e,                                            togglebarcolor,                            {0}}, /* swaps fg/bg for tag+win */
	{MODKEY | ControlMask,             XK_r,                                            togglebarlt,                               {0}},
	{MODKEY | ControlMask,             XK_y,                                            togglebarfloat,                            {0}},
	/* application bindings */
	{MODKEY,                           XK_m,                                            spawn,                                     {.v      = (const char *[]){"st", "-e", "termusic", NULL}}},
	{MODKEY,                           XK_w,                                            spawn,                                     {.v      = (const char *[]){BROWSER, NULL}}},
	{MODKEY | ShiftMask,               XK_f,                                            spawn,                                     {.v      = (const char *[]){"st", "-c","yazi","-e", "yazi", NULL}}},
	{MODKEY,                           XK_n,                                            spawn,                                     {.v      = (const char *[]){"st", "-e", "nvim", NULL}}},
	/* script launch bindings */
	{MODKEY | ShiftMask,               XK_n,                                            spawn,                                     {.v      = (const char *[]){"dmenunotes", NULL}}},
	{MODKEY,                           XK_v,                                            spawn,                                     {.v      = clipmenud       }},
	{MODKEY | ShiftMask,               XK_a,                                            spawn,                                     {.v      = (const char *[]){"dmenuvids", NULL}}},
	{MODKEY | ControlMask,             XK_a,                                            spawn,                                     {.v      = (const char *[]){"dmenuaudioswitch", NULL}}},
	{MODKEY | ShiftMask,               XK_d,                                            spawn,                                     {.v      = (const char *[]){"rip", NULL}}},
	{MODKEY,                           XK_r,                                            spawn,                                     {.v      = (const char *[]){"rec", NULL}}},
	{MODKEY | ShiftMask,               XK_grave,                                        spawn,                                     {.v      = (const char *[]){"define", NULL}}},
	{MODKEY | ShiftMask,               XK_w,                                            spawn,                                     {.v      = (const char *[]){"wallpapermenu", NULL}}},
	{MODKEY | ShiftMask,               XK_s,                                            spawn,                        SHCMD("/home/c0mplex/.scripts/bpscripts/images-photos-wallpapers/screenshot")},
	{MODKEY | ShiftMask,               XK_z,                                            spawn,                        SHCMD("/home/c0mplex/Documents/Programming/c/graphics/Inspiration/boomer/boomer")},
	{MODKEY | ShiftMask,               XK_F1,                                           spawn,                        SHCMD("/home/c0mplex/.scripts/bpscripts/images-photos-wallpapers/screenshot color")},
	{MODKEY,                           XK_F2,                                           spawn,                                     {.v      = (const char *[]){"vb", NULL}}},
	{MODKEY | ShiftMask,               XK_F2,                                           spawn,                                     {.v      = (const char *[]){"dmenutemp", NULL}}},
	{MODKEY,                           XK_F3,                                           spawn,                                     {.v      = (const char *[]){"phototransfer", NULL}}},
	{WINKEY,                           XK_a,                                            spawn,                        SHCMD("/home/c0mplex/.scripts/system/keyboardlayout")},

	/* Hardware keys */
	{0,                                XF86XK_AudioLowerVolume,                         spawn,
	 SHCMD("/usr/sbin/pactl set-sink-volume @DEFAULT_SINK@ -5%; /usr/bin/sleep 0.01;  "
	       "/usr/bin/kill -44 "
	       "$(/usr/bin/pidof dwmblocks)")},
	{0,                                XF86XK_AudioMute,                                spawn,
	 SHCMD("/usr/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle; /usr/bin/sleep 0.01; "
	       "/usr/bin/kill -44 "
	       "$(/usr/bin/pidof dwmblocks)")},
	{0,                                XF86XK_AudioRaiseVolume,                         spawn,
	 SHCMD("/usr/sbin/pactl set-sink-volume @DEFAULT_SINK@ +5%; /usr/bin/sleep 0.01;  "
	       "/usr/bin/kill -44 "
	       "$(/usr/bin/pidof dwmblocks)")},
	{0, XF86XK_MonBrightnessUp,   spawn, SHCMD("brightnessctl s 50+")},
	{0, XF86XK_MonBrightnessDown, spawn, SHCMD("brightnessctl s 50-")},
	{MODKEY,                           XK_F2,                                           spawn,                        SHCMD("playerctl previous kill;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{MODKEY,                           XK_F3,                                           spawn,                        SHCMD("playerctl play-pause kill;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{MODKEY,                           XK_F4,                                           spawn,                        SHCMD("playerctl next;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{0,                                XF86XK_AudioPlay,                                spawn,                        SHCMD("playerctl play-pause;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{0,                                XF86XK_AudioNext,                                spawn,                        SHCMD("playerctl next;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{0,                                XF86XK_AudioPrev,                                spawn,                        SHCMD("playerctl previous;/usr/bin/pkill -RTMIN+1 dwmblocks")},
	{MODKEY,                           XK_BackSpace,                                    spawn,                        SHCMD("~/.config/i3/powermenu/powermenu.sh")},
	{MODKEY,                           XK_F7,                                           spawn,                        SHCMD("xdotool key alt+3; xdg-open https://mail.google.com")},
	{MODKEY | ShiftMask,               XK_F7,                                           spawn,                        SHCMD("status-timer cleanup")},
	{MODKEY,                           XK_F8,                                           spawn,                        SHCMD("qalculate-gtk")},
	{MODKEY,                           XK_F11,                                          spawn,
	 SHCMD("/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%;"
           "/usr/bin/kill -44 $(</tmp/dwmblocks.pid)")},
	{MODKEY,                           XK_F10,                                          spawn,
	 SHCMD("/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%;"
           "/usr/bin/kill -44 $(</tmp/dwmblocks.pid)")},
	{MODKEY,                           XK_F12,                                          spawn,
	 SHCMD("/usr/bin/pactl set-sink-mute   @DEFAULT_SINK@ toggle;"
           "/usr/bin/kill -44 $(</tmp/dwmblocks.pid)")},
	/* {MODKEY,                           XK_x,                                            spawn,                                     SHCMD("~/.scripts/system/keybindgrabfix.sh")}, */
};

/* button definitions */
static const Button     buttons[] = {
/* click        event mask button   function      argument */
#ifndef __OpenBSD__
	{ClkWinTitle,   0,          Button2,         zoom,                  {0  }},
	{ClkStatusText, 0,          Button1,         sigstatusbar,          {.i = 1}},
	{ClkStatusText, 0,          Button2,         sigstatusbar,          {.i = 2}},
	{ClkStatusText, 0,          Button3,         sigstatusbar,          {.i = 3}},
	{ClkStatusText, 0,          Button4,         sigstatusbar,          {.i = 4}},
	{ClkStatusText, 0,          Button5,         sigstatusbar,          {.i = 5}},
	{ClkStatusText, ShiftMask,  Button1,         sigstatusbar,          {.i = 6}},
#endif
	{ClkStatusText, ShiftMask,  Button3,         spawn,
	 SHCMD("st -e nvim ~/.local/src/dwmblocks/blocks.h")},
	{ClkClientWin,  MODKEY,     Button1,         movemouse,             {0  }},     /* left click */
	{ClkClientWin,  MODKEY,     Button2,         defaultgaps,           {0  }},     /* middle click */
	{ClkClientWin,  MODKEY,     Button3,         resizemouse,           {0  }},     /* right click */
	{ClkClientWin,  MODKEY,     Button4,         incrgaps,              {.i = +1}}, /* scroll up */
	{ClkClientWin,  MODKEY,     Button5,         incrgaps,              {.i = -1}}, /* scroll down */
	{ClkTagBar,     0,          Button1,         view,                  {0  }},
	{ClkTagBar,     0,          Button3,         toggleview,            {0  }},
	{ClkTagBar,     MODKEY,     Button1,         tag,                   {0  }},
	{ClkTagBar,     MODKEY,     Button3,         toggletag,             {0  }},
	{ClkRootWin,    0,          Button2,         togglebar,             {0  }},/* hide bar */
};
