function fish_greeting
    set_color 2f73c0
    echo -n "󰜗  "
    set_color 1f2a37
    echo -n "Ice storm over "(prompt_hostname)". Hold the line, "
    set_color --bold d9581f
    echo (whoami)"."
    set_color 718296
    echo (date '+%A %d %B %Y · %H:%M')
    set_color normal
end
