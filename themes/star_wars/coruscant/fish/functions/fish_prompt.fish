function fish_prompt
    set -l last_status $status

    set_color --bold d8b26e
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 656b7c
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color e39a55
            echo -n "*"
        end
    end

    # Like a ticker: up after a success, down after a failure
    if test $last_status -eq 0
        set_color 4fb38a
        echo -n " ▲ "
    else
        set_color d9506a
        echo -n " ▼ "
    end
    set_color normal
end
