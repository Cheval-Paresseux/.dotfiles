# switch-theme.sh sets this universal variable: running shells re-apply the new theme
function __reload_theme --on-variable dotfiles_theme
    source ~/.config/fish/conf.d/theme.fish
    for name in fish_prompt fish_right_prompt fish_greeting
        source ~/.config/fish/functions/$name.fish
    end
end
