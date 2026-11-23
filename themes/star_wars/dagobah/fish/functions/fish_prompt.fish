function fish_prompt
    set -l last_status $status

    set_color --bold 6cb6ff
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 607a71
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color e8c15d
            echo -n "*"
        end
    end

    if test $last_status -eq 0
        set_color 9ccc65
    else
        set_color e0735a
    end
    echo -n " ❯ "
    set_color normal
end
