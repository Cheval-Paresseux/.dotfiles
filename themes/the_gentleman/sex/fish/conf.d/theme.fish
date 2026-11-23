# Sex theme: black and wine, skin-warm text, neon focus, the safeword lights for status (see ../../README.md)

set -g fish_color_normal f2e4e6
set -g fish_color_command 4fc3d9
set -g fish_color_keyword f03c96
set -g fish_color_param d4b8c0
set -g fish_color_option f7a8c8
set -g fish_color_quote 6fd08c
set -g fish_color_redirection 9b7cf2
set -g fish_color_end f2a541
set -g fish_color_operator 82d8e8
set -g fish_color_escape 9b7cf2
set -g fish_color_error ff4b3a
set -g fish_color_cancel ff4b3a
set -g fish_color_comment 7d5868 --italics
set -g fish_color_autosuggestion 5c3a4b
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=3a2130
set -g fish_color_search_match --background=3a2130
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix f03c96 --bold
set -g fish_pager_color_completion d4b8c0
set -g fish_pager_color_description 7d5868 --italics
set -g fish_pager_color_progress 7d5868
set -g fish_pager_color_selected_background --background=2a1822

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right --pointer=♥ --marker=♥ \
--color=bg:#100a0d,bg+:#1f1219,fg:#b0909c,fg+:#f2e4e6,hl:#f2a541,hl+:#f2a541 \
--color=border:#3a2130,header:#7d5868,info:#7d5868,marker:#6fd08c \
--color=pointer:#f03c96,prompt:#f03c96,spinner:#f03c96,gutter:#100a0d"
