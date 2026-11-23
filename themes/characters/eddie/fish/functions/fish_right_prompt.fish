function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color d0a443
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color --italics 554e3f
    echo -n (date '+%H:%M')
    set_color normal
end
