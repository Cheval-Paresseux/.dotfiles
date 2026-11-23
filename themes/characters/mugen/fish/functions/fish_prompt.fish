# The directory in the sun's red, the branch, then a sword: bamboo green after a success, crimson after a failure
function fish_prompt
    set -l last_status $status

    set_color --bold d23a1e
    echo -n (prompt_pwd)
    set_color normal

    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        set_color 7b7163
        echo -n " $branch"
        if test -n "$(git status --porcelain 2>/dev/null)"
            set_color a8740f
            echo -n "*"
        end
    end

    if test $last_status -eq 0
        set_color 4f7d35
    else
        set_color 9c1730
    end
    echo -n " 󰓥 "
    set_color normal
end
