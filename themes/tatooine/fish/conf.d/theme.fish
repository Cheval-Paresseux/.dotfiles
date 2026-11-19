# Tatooine theme: dusk browns, sand and twin-sun accents (see ../../README.md)

set -g fish_color_normal eedfc4
set -g fish_color_command 7fb4b5
set -g fish_color_keyword f2a65a
set -g fish_color_param d3c1a5
set -g fish_color_option 7fb4b5
set -g fish_color_quote a9b665
set -g fish_color_redirection b48ead
set -g fish_color_end d2734a
set -g fish_color_operator 8aa6c1
set -g fish_color_escape b48ead
set -g fish_color_error e5533d
set -g fish_color_cancel e5533d
set -g fish_color_comment 8c7663 --italics
set -g fish_color_autosuggestion 6e5b49
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=47382b
set -g fish_color_search_match --background=47382b
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix f2a65a --bold
set -g fish_pager_color_completion d3c1a5
set -g fish_pager_color_description 8c7663
set -g fish_pager_color_progress 8c7663
set -g fish_pager_color_selected_background --background=372b21

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=sharp --info=inline-right \
--color=bg:#18120d,bg+:#2b221a,fg:#b9a58d,fg+:#eedfc4,hl:#f5cf73,hl+:#f5cf73 \
--color=border:#47382b,header:#8c7663,info:#8c7663,marker:#a9b665 \
--color=pointer:#f2a65a,prompt:#f2a65a,spinner:#f2a65a,gutter:#18120d"
