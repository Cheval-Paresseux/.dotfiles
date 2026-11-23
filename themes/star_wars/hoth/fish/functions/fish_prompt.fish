function fish_prompt
    set -l last_status $status

    set_color --bold d9581f
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 718296
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color a87b00
            echo -n "*"
        end
    end

    if test $last_status -eq 0
        set_color 3f8a3a
    else
        set_color c42f3a
    end
    echo -n " ❯ "
    set_color normal
end
