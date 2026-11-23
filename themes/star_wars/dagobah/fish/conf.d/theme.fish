# Dagobah theme: swamp greens, saber blue focus (see ../../README.md)

set -g fish_color_normal dbe6dc
set -g fish_color_command 7cc4b8
set -g fish_color_keyword 6cb6ff
set -g fish_color_param b4c6bd
set -g fish_color_option c8d67a
set -g fish_color_quote 9ccc65
set -g fish_color_redirection a79bd6
set -g fish_color_end c8d67a
set -g fish_color_operator 7cc4b8
set -g fish_color_escape a79bd6
set -g fish_color_error e0735a
set -g fish_color_cancel e0735a
set -g fish_color_comment 607a71 --italics
set -g fish_color_autosuggestion 476058
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=2c403a
set -g fish_color_search_match --background=2c403a
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix 6cb6ff --bold
set -g fish_pager_color_completion b4c6bd
set -g fish_pager_color_description 607a71
set -g fish_pager_color_progress 607a71
set -g fish_pager_color_selected_background --background=22332e

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right \
--color=bg:-1,bg+:#1a2824,fg:#90a79e,fg+:#dbe6dc,hl:#e8c15d,hl+:#e8c15d \
--color=border:#2c403a,header:#607a71,info:#607a71,marker:#9ccc65 \
--color=pointer:#6cb6ff,prompt:#6cb6ff,spinner:#6cb6ff,gutter:-1"
