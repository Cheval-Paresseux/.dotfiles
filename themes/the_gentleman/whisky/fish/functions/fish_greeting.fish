# The barman greets you according to the hour, and the session's uptime is read like an age statement
function fish_greeting
    set -l hour (date +%-H)
    set -l greeting "Good evening"
    set -l line "The fire is lit and your glass is poured."
    if test $hour -ge 5 -a $hour -lt 12
        set greeting "Good morning"
        set line "Coffee first. The cellar opens tonight."
    else if test $hour -ge 12 -a $hour -lt 18
        set greeting "Good afternoon"
        set line "A little early for a dram, but the armchair is free."
    else if test $hour -ge 23 -o $hour -lt 5
        set greeting "Still up"
        set line "The lamps are low; one last glass before closing."
    end

    set -l uptime (math -s0 (string split ' ' < /proc/uptime)[1] / 60)
    set -l age "$uptime minutes"
    if test $uptime -ge 60
        set age (math -s0 $uptime / 60)" h "(math $uptime % 60)" min"
    end

    set_color 5a4838
    echo -n "❧ "
    set_color --italics eadcc2
    echo -n "$greeting, "
    set_color --bold --italics e3a14e
    echo -n (whoami)
    set_color normal
    set_color --italics eadcc2
    echo "."
    set_color --italics a8957d
    echo "  $line"
    set_color 7a6652
    echo "  "(date '+%A %d %B · %H:%M')"  ·  this session, aged $age"
    set_color normal
end
