function fish_prompt
    set -l last_status $status

    set_color --bold e32b36
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 676e79
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color f2b134
            echo -n "*"
        end
    end

    if test $last_status -eq 0
        set_color 84c26a
    else
        set_color b18cff
    end
    echo -n " ❯ "
    set_color normal
end
