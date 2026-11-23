# Coruscant theme: onyx navy, champagne gold focus (see ../../README.md)

set -g fish_color_normal ece6d8
set -g fish_color_command 7ea6e0
set -g fish_color_keyword d8b26e
set -g fish_color_param cdc8bc
set -g fish_color_option 7ea6e0
set -g fish_color_quote 4fb38a
set -g fish_color_redirection a68bd8
set -g fish_color_end 7ea6e0
set -g fish_color_operator a68bd8
set -g fish_color_escape a68bd8
set -g fish_color_error d9506a
set -g fish_color_cancel d9506a
set -g fish_color_comment 656b7c --italics
set -g fish_color_autosuggestion 474d5e
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=2a3040
set -g fish_color_search_match --background=2a3040
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix d8b26e --bold
set -g fish_pager_color_completion cdc8bc
set -g fish_pager_color_description 656b7c
set -g fish_pager_color_progress 656b7c
set -g fish_pager_color_selected_background --background=1e2330

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=sharp --info=inline-right \
--color=bg:#0b0d13,bg+:#161a24,fg:#a8a49b,fg+:#ece6d8,hl:#e39a55,hl+:#e39a55 \
--color=border:#2a3040,header:#656b7c,info:#656b7c,marker:#4fb38a \
--color=pointer:#d8b26e,prompt:#d8b26e,spinner:#d8b26e,gutter:#0b0d13"
