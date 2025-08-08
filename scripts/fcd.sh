#!/bin/bash

dir=$(find ~/Documents ~/Projects ~/Uni ~/dotfiles \
    -type d \( \
        -name ".cache" \
        -o -name "node_modules" \
        -o -name ".git" \
        -o -name ".venv" \
    \) -prune \
    -o -type d -print 2>/dev/null \
    | fzf)

if [ -n "$dir" ]; then
    if [ -z "$TMUX" ]; then
        tmux new-session -c "$dir" "vim ."
    else
        cd "$dir" && vim .
    fi
fi
