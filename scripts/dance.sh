#!/bin/bash

# Get the action from call
TARGET=$1

# Get the current session name
SESSION=$(tmux display-message -p '#S')

# Get the current window index
CURRENT_INDEX=$(tmux display-message -p '#I')

# Get windows list
WINDOWS=$(tmux list-windows -t "$SESSION" -F '#I')

# Get the max window index of current session
MAX_INDEX=$(tmux list-windows -t "$SESSION" -F '#I' | sort -n | tail -1)
MIN_INDEX=$(tmux list-windows -t "$SESSION" -F '#I' | sort -n | head -1)

WINDOW_LIST=($WINDOWS)

# Function to rearrange missing window index
reassignWin() {
    local index=0
    
    for wins in "${WINDOW_LIST[@]}"; do
        if [[ "$wins" != "$index" ]]; then
            tmux move-window -s "$SESSION:$wins" -t "$SESSION:$index"
            if [["$wins" -eq "$CURRENT_INDEX" ]]; then
                CURRENT_INDEX="$index"
            fi
        fi
        index=$((index + 1))
        
        # Get the left and right window index
        LEFT_INDEX=$((CURRENT_INDEX - 1))
        RIGHT_INDEX=$((CURRENT_INDEX + 1))
    done

    tmux move-window -r
}

# Function to move current index to left/right
moveLeft() {
    tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$LEFT_INDEX"
    tmux select-window -t "$SESSION:$LEFT_INDEX"
}

moveRight() {
    tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$RIGHT_INDEX"
    tmux select-window -t "$SESSION:$RIGHT_INDEX"
}

# Function to rotate if current index is left/rightmost
rotateLeft() {
    for (( i=CURRENT_INDEX ; i<$MAX_INDEX ; i++ )); do
        tmux swap-window -s "$SESSION:$i" -t "$SESSION:$((i+1))"
    done
    tmux select-window -t "$SESSION:$MAX_INDEX"
}

rotateRight() {
    for (( i=$CURRENT_INDEX ; i>$MIN_INDEX ; i--)); do
        tmux swap-window -s "$SESSION:$i" -t "$SESSION:$((i-1))"
    done
    tmux select-window -t "$SESSION:$MIN_INDEX"
}

# Function to select specified window
selectWindow() {
    tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$TARGET"
    tmux select-window -t "$SESSION:$TARGET"
}

# Main function
main() {
    reassignWin

    if [[ $TARGET == "left" ]]; then
        if [[ $LEFT_INDEX -ge 0 ]]; then
            moveLeft
        else
            rotateLeft
        fi
    elif [[ $TARGET == "right" ]]; then
        if [[ $RIGHT_INDEX -le $MAX_INDEX ]]; then
            moveRight
        else
            rotateRight
        fi
    elif [[ $TARGET -ge $MIN_INDEX ]] && [[ $TARGET -le $MAX_INDEX ]]; then
        selectWindow
    elif [[ $TARGET -lt $MIN_INDEX ]] || [[ $TARGET -gt $MAX_INDEX ]]; then
        tmux display "The index does not exist!"
    else
        echo "Invalid target: $TARGET. Use 'left', 'right' or a valid index!"
    fi
}

main
