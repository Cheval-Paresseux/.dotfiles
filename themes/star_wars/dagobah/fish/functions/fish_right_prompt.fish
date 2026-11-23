function fish_right_prompt
    if test "$CMD_DURATION" -gt 3000
        set_color e8c15d
        echo -n (math -s1 $CMD_DURATION / 1000)"s "
    end

    set_color 476058
    echo -n (date '+%H:%M')
    set_color normal
end
