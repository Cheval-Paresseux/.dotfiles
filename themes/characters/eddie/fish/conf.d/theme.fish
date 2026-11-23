# Eddie theme: loden and oak darks, oatmeal text, hunting scarlet for focus (see ../../README.md)

set -g fish_color_normal e8dfc5
set -g fish_color_command 7f9cb0
set -g fish_color_keyword c8432c
set -g fish_color_param c7bea2
set -g fish_color_option e2bf6c
set -g fish_color_quote 8ea35a
set -g fish_color_redirection 9b85ad
set -g fish_color_end d0a443
set -g fish_color_operator 6e9f92
set -g fish_color_escape 9b85ad
set -g fish_color_error a63a55
set -g fish_color_cancel a63a55
set -g fish_color_comment 776e5a --italics
set -g fish_color_autosuggestion 554e3f
set -g fish_color_valid_path --underline
set -g fish_color_selection --background=3a352a
set -g fish_color_search_match --background=3a352a
set -g fish_color_history_current --bold

set -g fish_pager_color_prefix c8432c --bold
set -g fish_pager_color_completion c7bea2
set -g fish_pager_color_description 776e5a --italics
set -g fish_pager_color_progress 776e5a
set -g fish_pager_color_selected_background --background=2d2921

set -gx BAT_THEME ansi
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --border=rounded --info=inline-right --pointer=❯ --marker=⚜ \
--color=bg:#15130e,bg+:#23201a,fg:#a39a80,fg+:#e8dfc5,hl:#d0a443,hl+:#d0a443 \
--color=border:#3a352a,header:#776e5a,info:#776e5a,marker:#8ea35a \
--color=pointer:#c8432c,prompt:#c8432c,spinner:#c8432c,gutter:#15130e"
