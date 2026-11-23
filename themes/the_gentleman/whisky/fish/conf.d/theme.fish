# Whisky theme: tobacco darks, cream text, amber focus (see ../../README.md)

set -g fish_color_normal eadcc2
set -g fish_color_command 8da4bf
set -g fish_color_keyword e3a14e
set -g fish_color_param cbb89c
set -g fish_color_option f2c37d
set -g fish_color_quote 7aa874
set -g fish_color_redirection c9849b
set -g fish_color_end e8743c
set -g fish_color_operator 6fa89a
set -g fish_color_escape c9849b
set -g fish_color_error c94a52
set -g fish_color_cancel c94a52
set -g fish_color_comment 7a6652 --italics
set -g fish_color_autosuggestion 5a4838
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=382b20
set -g fish_color_search_match --background=382b20
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix e3a14e --bold
set -g fish_pager_color_completion cbb89c
set -g fish_pager_color_description 7a6652 --italics
set -g fish_pager_color_progress 7a6652
set -g fish_pager_color_selected_background --background=2a2119

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right --pointer=❧ --marker=❦ \
--color=bg:#110d0a,bg+:#201913,fg:#a8957d,fg+:#eadcc2,hl:#e8743c,hl+:#e8743c \
--color=border:#382b20,header:#7a6652,info:#7a6652,marker:#7aa874 \
--color=pointer:#e3a14e,prompt:#e3a14e,spinner:#e3a14e,gutter:#110d0a"
