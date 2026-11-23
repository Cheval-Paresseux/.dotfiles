# Whisky theme: bottle-green darks, ivory text, antique gold focus (see ../../README.md)

set -g fish_color_normal e4dcc8
set -g fish_color_command 8b9cab
set -g fish_color_keyword c8a96a
set -g fish_color_param c2bfae
set -g fish_color_option e3cf9c
set -g fish_color_quote 88a878
set -g fish_color_redirection 9c7f9a
set -g fish_color_end c98a4b
set -g fish_color_operator 6f9a8e
set -g fish_color_escape 9c7f9a
set -g fish_color_error b24a4f
set -g fish_color_cancel b24a4f
set -g fish_color_comment 66716a --italics
set -g fish_color_autosuggestion 45524a
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=2a372e
set -g fish_color_search_match --background=2a372e
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix c8a96a --bold
set -g fish_pager_color_completion c2bfae
set -g fish_pager_color_description 66716a --italics
set -g fish_pager_color_progress 66716a
set -g fish_pager_color_selected_background --background=1f2a23

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right --pointer=❧ --marker=❦ \
--color=bg:#0e1210,bg+:#18201b,fg:#9a9f94,fg+:#e4dcc8,hl:#c98a4b,hl+:#c98a4b \
--color=border:#2a372e,header:#66716a,info:#66716a,marker:#88a878 \
--color=pointer:#c8a96a,prompt:#c8a96a,spinner:#c8a96a,gutter:#0e1210"
