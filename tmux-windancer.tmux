#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux bind-key P run-shell "$CURRENT_DIR/scripts/dance.sh left"
tmux bind-key N run-shell "$CURRENT_DIR/scripts/dance.sh right"
tmux bind-key M-w command-prompt -p "Move window to index: " "run-shell '$CURRENT_DIR/scripts/dance.sh %%'"
