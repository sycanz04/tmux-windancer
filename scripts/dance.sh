#!/bin/bash

# Get the action from call
TARGET=$1

# Get the current session name
SESSION=$(tmux display-message -p '#S')

# Get the current window index
CURRENT_INDEX=$(tmux display-message -p '#I')

# Get the left and right window index
LEFT_INDEX=$((CURRENT_INDEX - 1))
RIGHT_INDEX=$((CURRENT_INDEX + 1))

# Get the max window index of current session
MAX_INDEX=$(tmux list-windows -t "$SESSION" -F '#I' | sort -n | tail -1)
MIN_INDEX=$(tmux list-windows -t "$SESSION" -F '#I' | sort -n | head -1)

# Function to rotate if current index is left/rightmost
rotateLeft() {
    for (( i=CURRENT_INDEX ; i<$MAX_INDEX ; i++ ));
    do
        tmux swap-window -s "$SESSION:$i" -t "$SESSION:$((i+1))"
    done
}

rotateRight() {
    for (( i=$CURRENT_INDEX ; i>$MIN_INDEX ; i--));
    do
        tmux swap-window -s "$SESSION:$i" -t "$SESSION:$((i-1))"
    done
}

# Main function
main() {
    if [[ $TARGET == "left" ]]; then
        if [[ $LEFT_INDEX -ge 0 ]]; then
            tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$LEFT_INDEX"
        else
            rotateLeft
        fi
    elif [[ $TARGET == "right" ]]; then
        if [[ $RIGHT_INDEX -le $MAX_INDEX ]]; then
            tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$RIGHT_INDEX"
        else
            rotateRight
        fi
    elif [[ $TARGET -ge $MIN_INDEX ]] && [[ $TARGET -le $MAX_INDEX ]]; then
        tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$TARGET"

    elif [[ $TARGET -lt $MIN_INDEX ]] || [[ $TARGET -gt $MAX_INDEX ]]; then
        tmux display "The index does not exist!"
    else
        echo "Invalid target: $TARGET. Use 'left', 'right' or a valid index!"
    fi
}

main
