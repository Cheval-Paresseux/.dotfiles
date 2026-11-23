function fish_prompt
    set -l last_status $status

    set_color --bold c8a96a
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color --italics 7d6535
        echo -n " $branch"
        set_color normal
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color c98a4b
            echo -n "*"
        end
    end

    # A fleuron, sage after a success, claret after a failure
    if test $last_status -eq 0
        set_color 88a878
    else
        set_color b24a4f
    end
    echo -n " ❧ "
    set_color normal
end
