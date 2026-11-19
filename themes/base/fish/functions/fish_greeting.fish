function fish_greeting
    set_color e6e6e6
    echo -n "Hello, "
    set_color --bold 73daca
    echo (whoami)
    set_color 737373
    echo (date '+%A %d %B %Y · %H:%M')
    set_color normal
end
