function fish_prompt
    set -l last_status $status

    set_color --bold f03c96
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color --italics 7d5868
        echo -n " $branch"
        set_color normal
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color f2a541
            echo -n "*"
        end
    end

    # The heart takes the safeword light: green to go on, red to stop
    if test $last_status -eq 0
        set_color 6fd08c
    else
        set_color ff4b3a
    end
    echo -n " ♥ "
    set_color normal
end
