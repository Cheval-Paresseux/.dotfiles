# Default applications
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx TERMINAL kitty
set -gx BROWSER zen-browser

# Add personal executable directory to PATH
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
