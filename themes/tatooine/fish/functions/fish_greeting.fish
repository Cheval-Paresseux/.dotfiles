function fish_greeting
    set_color f2a65a
    echo -n "◉ ◉  "
    set_color eedfc4
    echo -n "Twin suns over "(prompt_hostname)". Watch your back, "
    set_color --bold f2a65a
    echo (whoami)"."
    set_color 8c7663
    echo (date '+%A %d %B %Y · %H:%M')
    set_color normal
end
