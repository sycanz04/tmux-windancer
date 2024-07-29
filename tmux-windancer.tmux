#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
    tmux bind-key P run-shell "$CURRENT_DIR/scripts/dance.sh left"
    tmux bind-key N run-shell "$CURRENT_DIR/scripts/dance.sh right"
}

main
