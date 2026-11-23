function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color f2a541
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color --italics 5c3a4b
    echo -n (date '+%H:%M')
    set_color normal
end
