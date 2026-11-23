# Death Star theme: gunmetal greys, saber red focus (see ../../README.md)

set -g fish_color_normal dfe2e6
set -g fish_color_command 73a7d9
set -g fish_color_keyword e32b36
set -g fish_color_param b8bdc5
set -g fish_color_option e8743b
set -g fish_color_quote 84c26a
set -g fish_color_redirection 6fc3c9
set -g fish_color_end e8743b
set -g fish_color_operator 6fc3c9
set -g fish_color_escape 6fc3c9
set -g fish_color_error b18cff
set -g fish_color_cancel b18cff
set -g fish_color_comment 676e79 --italics
set -g fish_color_autosuggestion 4b515b
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=30353d
set -g fish_color_search_match --background=30353d
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix e32b36 --bold
set -g fish_pager_color_completion b8bdc5
set -g fish_pager_color_description 676e79
set -g fish_pager_color_progress 676e79
set -g fish_pager_color_selected_background --background=24282e

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=sharp --info=inline-right \
--color=bg:#0d0f12,bg+:#1b1e23,fg:#9399a3,fg+:#dfe2e6,hl:#f2b134,hl+:#f2b134 \
--color=border:#30353d,header:#676e79,info:#676e79,marker:#84c26a \
--color=pointer:#e32b36,prompt:#e32b36,spinner:#e32b36,gutter:#0d0f12"
