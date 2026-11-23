function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color c98a4b
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color --italics 45524a
    echo -n (date '+%H:%M')
    set_color normal
end
