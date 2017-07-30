#ifndef STATUS_INCLUDED
#define STATUS_INCLUDED
#define TEMP_CALC(t) t / 1000;
#define RAM_CALC(r) r / 1000000;

static const char BBSWITCH[] = "/proc/acpi/bbswitch";
static const char STATUS_PSTAT[] = "/tmp/prev_stat";
static const char PROC_STAT[] = "/proc/stat";
static const char PROC_MEM[] = "/proc/meminfo";
static const char PROC_LOADAVG[] = "/proc/loadavg";
static const char SIZES[] = "KMGTP";

static const char FORMAT_STRING[] = "<txt><span font_weight='bold'><span fgcolor='#D0B03C' font='FontAwesome' font_weight='normal'> </span> <span fgcolor='#FFE377'>%.2Lf%% </span><span fgcolor='#72B3CC' font='FontAwesome' font_weight='normal'>   </span> <span fgcolor='#9CD9F0'>%d%c free</span> <span fgcolor='#C75646' font='FontAwesome' font_weight='normal'>  </span> <span fgcolor='#E09690'>%u°C</span><span fgcolor='#8EB33B' font='FontAwesome' font_weight='normal'>    </span><span fgcolor='#cdee69'>%s</span></span></txt><tool> %.2f %.2f %.2f</tool>";
#endif
