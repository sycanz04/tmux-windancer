#!/bin/bash

# Get the action from call
ACTION=$1

# Get the current session name
SESSION=$(tmux display-message -p '#S')

# Get the current window index
CURRENT_INDEX=$(tmux display-message -p '#I')

# Get the left and right window index
LEFT_INDEX=$((CURRENT_INDEX - 1))
RIGHT_INDEX=$((CURRENT_INDEX + 1))

# Get the max window index of current session
MAX_INDEX=$(tmux list-windows -t "$SESSION" -F '#I' | sort -n | tail -1)

# If conditions met, move windows
if [[ $ACTION == "left" ]]; then
    if [[ $LEFT_INDEX -ge 0 ]]; then
        tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$LEFT_INDEX"
    else
        echo "Cannot move window further let. Already at the leftmost position"
    fi
elif [[ $ACTION == "right" ]]; then
    if [[ $RIGHT_INDEX -le $MAX_INDEX ]]; then
        tmux swap-window -s "$SESSION:$CURRENT_INDEX" -t "$SESSION:$RIGHT_INDEX"
    else
        echo "Cannot move window further let. Already at the rightmost position"
    fi
else
    echo "Invalid action: $ACTION. Use 'left' or 'right'."
fi
