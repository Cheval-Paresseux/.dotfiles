function fish_prompt
    set -l last_status $status

    set_color --bold e3a14e
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color --italics 9a7038
        echo -n " $branch"
        set_color normal
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color e8743c
            echo -n "*"
        end
    end

    # A fleuron, velvet green after a success, wine red after a failure
    if test $last_status -eq 0
        set_color 7aa874
    else
        set_color c94a52
    end
    echo -n " ❧ "
    set_color normal
end
