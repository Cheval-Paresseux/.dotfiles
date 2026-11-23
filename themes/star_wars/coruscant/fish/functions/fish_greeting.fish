function fish_greeting
    set -l hour (date +%H)
    set -l part evening
    if test $hour -lt 12
        set part morning
    else if test $hour -lt 18
        set part afternoon
    end

    set_color d8b26e
    echo -n "󰁰  "
    set_color ece6d8
    echo -n "Good $part, Senator "
    set_color --bold d8b26e
    echo -n (whoami)
    set_color normal
    set_color ece6d8
    echo ". The Exchange awaits you on "(prompt_hostname)"."
    # The day's quote: the system load as an index, moving up or down against the last fifteen minutes
    set -l load (string split ' ' < /proc/loadavg)
    set -l move ▪
    if test (math "$load[1] - $load[3]") -gt 0.05
        set move ▲
    else if test (math "$load[3] - $load[1]") -gt 0.05
        set move ▼
    end
    set_color 656b7c
    echo -n (date '+%A %d %B %Y · %H:%M')" GST  ◆  "
    set_color d8b26e
    echo -n "LOAD INDEX "
    set_color cdc8bc
    echo "$load[1] $move"
    set_color normal
end
