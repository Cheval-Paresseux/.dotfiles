# Mugen theme: washi paper, sumi ink, the sun's vermilion for focus (see ../../README.md)

set -g fish_color_normal 1e1a17
set -g fish_color_command 2e5a88
set -g fish_color_keyword d23a1e
set -g fish_color_param 3f3932
set -g fish_color_option d23a1e
set -g fish_color_quote 4f7d35
set -g fish_color_redirection 7a4588
set -g fish_color_end 8a5634
set -g fish_color_operator 23787a
set -g fish_color_escape 7a4588
set -g fish_color_error 9c1730
set -g fish_color_cancel 9c1730
set -g fish_color_comment 7b7163 --italics
set -g fish_color_autosuggestion 9c917f
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=c6bca8
set -g fish_color_search_match --background=c6bca8
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix d23a1e --bold
set -g fish_pager_color_completion 3f3932
set -g fish_pager_color_description 7b7163
set -g fish_pager_color_progress 7b7163
set -g fish_pager_color_selected_background --background=d8cfbd

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=sharp --info=inline-right \
--color=light,bg:#f5f1e8,bg+:#e3dccd,fg:#5c544a,fg+:#1e1a17,hl:#a8740f,hl+:#a8740f \
--color=border:#c6bca8,header:#7b7163,info:#7b7163,marker:#4f7d35 \
--color=pointer:#d23a1e,prompt:#d23a1e,spinner:#d23a1e,gutter:#f5f1e8"
