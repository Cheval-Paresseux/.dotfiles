function fish_greeting
    set_color 9ccc65
    echo -n "󰌪  "
    set_color dbe6dc
    echo -n "Mist settles over "(prompt_hostname)". Breathe, "
    set_color --bold 6cb6ff
    echo -n (whoami)
    set_color dbe6dc
    echo ", and let the Force guide your hands."
    set_color 607a71
    echo (date '+%A %d %B %Y · %H:%M')
    set_color normal
end
