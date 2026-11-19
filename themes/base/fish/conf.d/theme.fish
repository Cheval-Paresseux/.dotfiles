# Base theme: neutral greys, green, blue and yellow accents (see ../../README.md)

set -g fish_color_normal e6e6e6
set -g fish_color_command 7aa2f7
set -g fish_color_keyword 73daca
set -g fish_color_param c4c4c4
set -g fish_color_option 73daca
set -g fish_color_quote 9ece6a
set -g fish_color_redirection bb9af7
set -g fish_color_end ff9e64
set -g fish_color_operator 7dcfff
set -g fish_color_escape bb9af7
set -g fish_color_error f7768e
set -g fish_color_cancel f7768e
set -g fish_color_comment 737373 --italics
set -g fish_color_autosuggestion 595959
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=3d3d3d
set -g fish_color_search_match --background=3d3d3d
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix 73daca --bold
set -g fish_pager_color_completion c4c4c4
set -g fish_pager_color_description 737373
set -g fish_pager_color_progress 737373
set -g fish_pager_color_selected_background --background=303030

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=sharp --info=inline-right \
--color=bg:#161616,bg+:#262626,fg:#a6a6a6,fg+:#e6e6e6,hl:#ecd06f,hl+:#ecd06f \
--color=border:#3d3d3d,header:#737373,info:#737373,marker:#9ece6a \
--color=pointer:#73daca,prompt:#73daca,spinner:#73daca,gutter:#161616"
