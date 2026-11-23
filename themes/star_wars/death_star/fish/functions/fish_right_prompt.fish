function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color f2b134
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color 4b515b
    echo -n (date '+%H:%M')
    set_color normal
end
