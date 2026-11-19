function fish_prompt
    set -l last_status $status

    set_color --bold f2a65a
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 8c7663
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color f5cf73
            echo -n "*"
        end
    end

    if test $last_status -eq 0
        set_color a9b665
    else
        set_color e5533d
    end
    echo -n " ❯ "
    set_color normal
end
