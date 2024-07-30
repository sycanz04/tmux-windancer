# Tmux Windancer 🔄
This is a Tmux plugin that lets you rearrange your windows. I made this as an excuse to practice shell scripting lol.

## Installation with [TPM](https://github.com/tmux-plugins/tpm) ⚙️
Add plugin to the list of TPM plugins in config file (like `.tmux.conf`):
```bash
set -g @plugin `sycanz04/tmux-windancer`
```
Hit `Prefix + I` to fetch the plugin and source it. You should now be able to use the plugin.

## Key bindings ⌨️
- `Prefix + P` - Move window left
- `Prefix + N` - Move window right
- `Prefix + Alt + w` - Specify window to swap with
<br/>
**Note**: The window rotates to the other end if it's at the left/rightmost corner
