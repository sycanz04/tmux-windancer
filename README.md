# Tmux Windancer 🔄
This is a Tmux plugin that lets you rearrange your windows. I made this as an excuse to practice shell scripting.
![tmux-windancer](https://github.com/user-attachments/assets/dffb7212-103b-4958-8212-990965a9f2c6)

## Installation with [TPM](https://github.com/tmux-plugins/tpm) ⚙️
Add plugin to the list of TPM plugins in config file (like `.tmux.conf`):
```bash
set -g @plugin 'sycanz04/tmux-windancer'
```
Hit `Prefix + I` to fetch the plugin and source it. You should now be able to use the plugin.

## Key bindings ⌨️
- `Prefix + P` - Move window left
- `Prefix + N` - Move window right
- `Prefix + Alt + w` - Specify window to swap with

**Note**: The window rotates to the other end if it's at the left/rightmost corner

## Changing keybinds 🛠️
After [installing the plugin](https://github.com/sycanz04/tmux-windancer/edit/main/README.md#installation-with-tpm-%EF%B8%8F).
1. Navigate to .tmux plugin run file
```
$ cd ~/.tmux/plugins/tmux-windancer/tmux-windancer.tmux
```
2. Change they keybinds on these 3 lines (default keybinds are `P`, `N`, `M-w`)
```bash
tmux bind-key P run-shell "$CURRENT_DIR/scripts/dance.sh left"
tmux bind-key N run-shell "$CURRENT_DIR/scripts/dance.sh right"
tmux bind-key M-w command-prompt -p "Move window to index: " "run-shell '$CURRENT_DIR/scripts/dance.sh %%'"
```
3. Source your tmux config
