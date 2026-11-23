# A wanderer's hello that changes with the hour, the weekday in kanji, and how long you have been on the road (the uptime)
function fish_greeting
    set -l hour (date +%-H)
    set -l greeting "Evening"
    set -l line "Good time to pick a fight."
    if test $hour -ge 5 -a $hour -lt 12
        set greeting "Too early"
        set line "Nobody worth fighting is up yet."
    else if test $hour -ge 12 -a $hour -lt 18
        set greeting "Afternoon"
        set line "Something to eat first, then we'll see."
    else if test $hour -ge 23 -o $hour -lt 5
        set greeting "Still up"
        set line "The night is long, and the road is longer."
    end

    set -l uptime (math -s0 (string split ' ' < /proc/uptime)[1] / 60)
    set -l road "$uptime min"
    if test $uptime -ge 60
        set road (math -s0 $uptime / 60)" h "(math $uptime % 60)" min"
    end
    set -l weekday (string sub -s (math (date +%w) + 1) -l 1 日月火水木金土)

    set_color d23a1e
    echo -n "● "
    set_color --bold 1e1a17
    echo -n "$greeting, "
    set_color --bold d23a1e
    echo -n (whoami)
    set_color --bold 1e1a17
    echo "."
    set_color 5c544a
    echo "  $line"
    set_color d23a1e
    echo -n "  $weekday "
    set_color 7b7163
    echo (date '+%A %d %B · %H:%M')"  ·  on the road for $road"
    set_color normal
end
