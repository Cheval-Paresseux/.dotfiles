# A whisper that changes with the hour, and how long the two of you have been together (the uptime)
function fish_greeting
    set -l hour (date +%-H)
    set -l greeting "Good evening"
    set -l line "Close the door behind you."
    set -l mark "."
    if test $hour -ge 5 -a $hour -lt 12
        set greeting "Good morning"
        set line "Last night was something."
    else if test $hour -ge 12 -a $hour -lt 18
        set greeting "Patience"
        set line "The best things happen after dark."
    else if test $hour -ge 23 -o $hour -lt 5
        set greeting "Still awake"
        set mark "?"
        set line "Good. So am I."
    end

    set -l uptime (math -s0 (string split ' ' < /proc/uptime)[1] / 60)
    set -l together "$uptime min"
    if test $uptime -ge 60
        set together (math -s0 $uptime / 60)" h "(math $uptime % 60)" min"
    end

    set_color f03c96
    echo -n "♥ "
    set_color --italics f2e4e6
    echo -n "$greeting, "
    set_color --bold --italics f03c96
    echo -n (whoami)
    set_color normal
    set_color --italics f2e4e6
    echo $mark
    set_color --italics b0909c
    echo "  $line"
    set_color 7d5868
    echo "  "(string upper (date '+%A %d %B · %H:%M'))"  ·  together for $together"
    set_color normal
end
