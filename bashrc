#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias fcd='dir=$(find . -mount -type d \( -path "$HOME/Cloud" -o -name ".cache" \) -prune -o -type d -print | fzf) && if [ -z "$TMUX" ]; then tmux new-session -c "$dir"; else cd "$dir"; fi'
PS1='[\u@\h \W]\$ '

# Wayland/Hyprland environment variables
export WLR_NO_HARDWARE_CURSORS=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# Podman docker compatibility
alias docker=podman
source ~/.globalenv/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH=$HOME/go/bin:$PATH
