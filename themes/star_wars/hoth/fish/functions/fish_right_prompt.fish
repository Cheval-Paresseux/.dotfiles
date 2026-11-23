function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color a87b00
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color 91a1b3
    echo -n (date '+%H:%M')
    set_color normal
end
