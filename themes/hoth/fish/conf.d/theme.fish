# Hoth theme: snow and slate, Rebel orange focus (see ../../README.md)

set -g fish_color_normal 1f2a37
set -g fish_color_command 2f73c0
set -g fish_color_keyword d9581f
set -g fish_color_param 3d4c5e
set -g fish_color_option 1c7f86
set -g fish_color_quote 3f8a3a
set -g fish_color_redirection 7550b0
set -g fish_color_end 1c7f86
set -g fish_color_operator 1c7f86
set -g fish_color_escape 7550b0
set -g fish_color_error c42f3a
set -g fish_color_cancel c42f3a
set -g fish_color_comment 718296 --italics
set -g fish_color_autosuggestion 91a1b3
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=c9d8ea
set -g fish_color_search_match --background=c9d8ea
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix d9581f --bold
set -g fish_pager_color_completion 3d4c5e
set -g fish_pager_color_description 718296
set -g fish_pager_color_progress 718296
set -g fish_pager_color_selected_background --background=cfd9e3

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right \
--color=light,bg:-1,bg+:#dce4ec,fg:#536478,fg+:#1f2a37,hl:#a87b00,hl+:#a87b00 \
--color=border:#bccad8,header:#718296,info:#718296,marker:#3f8a3a \
--color=pointer:#d9581f,prompt:#d9581f,spinner:#d9581f,gutter:-1"
