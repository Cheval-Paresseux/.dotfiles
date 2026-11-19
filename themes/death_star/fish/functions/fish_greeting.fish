function fish_greeting
    set_color e32b36
    echo -n "  "
    set_color dfe2e6
    echo -n "Reactor online on "(prompt_hostname)". Awaiting your orders, Lord "
    set_color --bold e32b36
    echo (whoami)"."
    set_color 676e79
    echo (date '+%A %d %B %Y · %H:%M')
    set_color normal
end
