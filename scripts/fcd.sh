#!/bin/bash

dir=$(find ~/Documents ~/Projects ~/Uni ~/dotfiles \
    -type d \( \
        -name ".cache" \
        -o -name "node_modules" \
        -o -name ".git" \
        -o -name ".venv" \
        -o -name "bin" \
    \) -prune \
    -o -type d -print 2>/dev/null \
    | fzf)

if [ -z "$dir" ]; then
    exit 0
fi

if [ -z "$TMUX" ]; then
    tmux new-session -c "$dir" \; send-keys "nvim ." Enter
else
    cd "$dir" && nvim .
fi
