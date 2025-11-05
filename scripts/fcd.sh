#!/bin/bash

sanity_check() {
    if ! command -v tmux >/dev/null 2>&1
    then 
        echo "tmux not installed"
        exit 1
    fi

    if ! command -v nvim >/dev/null 2>&1
    then 
        echo "nvim not installed"  
        exit 1
    fi
}

find_directories() {
    # Get active tmux sessions with their working directories
    # Format: "session_name (or number) -> working_directory"
    tmux_sessions=$(tmux list-sessions -F "TMUX_SESSION:#{session_name} -> #{session_path}" 2>/dev/null | \
        sed 's/^TMUX_SESSION:/\x1b[32m[ TMUX ]\x1b[0m /')
    
    # Define the directories to be searched below
    file_dirs=$(find ~/Documents ~/Projects ~/Uni ~/dotfiles \
        -type d \( \
            -name ".cache" \
            -o -name "node_modules" \
            -o -name ".git" \
            -o -name ".venv" \
            -o -name "bin" \
        \) -prune \
        -o -type d -print 2>/dev/null)
    
    # Combine directories and tmux sessions and pipe to fzf
    selection=$(printf "%s\n%s" "$tmux_sessions" "$file_dirs" | fzf --ansi)
    
    # If a tmux session was selected, extract the session name and switch to it
    if [[ "$selection" == *"[SESSION]"* ]]; then
        session_name=$(echo "$selection" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[SESSION\] \(.*\) ->.*/\1/')
        tmux switch-client -t "$session_name" 2>/dev/null || tmux attach -t "$session_name"
        exit 0
    fi
    
    dir="$selection"
}


main() {
    sanity_check  
    find_directories

    if [ -z "$dir" ]; then
        exit 0
    fi

    if [ -z "$TMUX" ]; then
        tmux new-session -c "$dir" \; send-keys "nvim ." Enter
    else
        cd "$dir" && nvim .
    fi
}

main  
