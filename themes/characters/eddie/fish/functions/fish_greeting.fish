# Good day from the estate, according to the hour; the uptime is how long you have been out in the fields
function fish_greeting
    set -l hour (date +%-H)
    set -l greeting "Good evening"
    set -l line "Boots by the door, the fire is lit."
    if test $hour -ge 5 -a $hour -lt 12
        set greeting "Good morning"
        set line "The dogs are fed and the kettle is on."
    else if test $hour -ge 12 -a $hour -lt 18
        set greeting "Good afternoon"
        set line "Rain is expected. It usually is."
    else if test $hour -ge 23 -o $hour -lt 5
        set greeting "Still up"
        set line "The house is asleep. The estate never quite is."
    end

    set -l uptime (math -s0 (string split ' ' < /proc/uptime)[1] / 60)
    set -l fields "$uptime minutes"
    if test $uptime -ge 60
        set fields (math -s0 $uptime / 60)" h "(math $uptime % 60)" min"
    end

    set_color 8c6a45
    echo -n "⚜ "
    set_color e8dfc5
    echo -n "$greeting, "
    set_color --bold c8432c
    echo -n "Your Grace"
    set_color normal
    set_color e8dfc5
    echo "."
    set_color --italics a39a80
    echo "  $line"
    set_color 776e5a
    echo "  "(date '+%A %-d %B · %H:%M')"  ·  out in the fields for $fields"
    set_color normal
end
