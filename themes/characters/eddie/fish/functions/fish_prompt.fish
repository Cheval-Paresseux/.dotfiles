function fish_prompt
    set -l last_status $status

    set_color --bold c8432c
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color --italics b5865a
        echo -n " $branch"
        set_color normal
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color d0a443
            echo -n "*"
        end
    end

    # The fleur-de-lis of the family arms, moss green after a success, claret after a failure
    if test $last_status -eq 0
        set_color 8ea35a
    else
        set_color a63a55
    end
    echo -n " ⚜ "
    set_color normal
end
