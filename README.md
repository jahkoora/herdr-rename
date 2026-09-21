# herdr-rename

Rename agents in [herdr](https://herdr.dev) from the keyboard. Sets the pane label to match, so the name shows on pane borders too.

herdr's sidebar shows each agent's own terminal title (whatever Claude Code, Codex and friends set), and renaming the pane doesn't change it. The `herdr agent rename` CLI command does, but there's no keybinding for it. This adds one, plus a shell helper.

## What you get

- **`prefix+shift+a`**: a popup that lists your agents with the current one preselected. Pick one, type a name, done. Leave the name blank to clear it.
- **`agentname`**: a zsh function for use inside a pane. `agentname my-agent` names the agent you're in; `agentname w1:p7 my-agent` names another; `agentname --clear` reverts. Handy for telling an agent "run `agentname gt-nation-ui`" so it names itself.

Names follow herdr's rule: lowercase letters, digits, `-` or `_`, up to 32 characters.

## Install

Requires herdr 0.9.1 or later, zsh and python3 (both ship with macOS).

1. Put `bin/herdr-rename` somewhere on your `PATH` and make it executable:

   ```sh
   cp bin/herdr-rename ~/.local/bin/ && chmod +x ~/.local/bin/herdr-rename
   ```

2. Add the popup keybind to `~/.config/herdr/config.toml`:

   ```toml
   [[keys.command]]
   key = "prefix+shift+a"
   type = "popup"
   command = "herdr-rename"
   width = "70%"
   height = "40%"
   ```

   Then `herdr server reload-config` (or `prefix+shift+r`).

3. Optional: source `agentname.zsh` from your `.zshrc` for the shell helper.

## How it works

`herdr agent list` returns JSON with each agent's pane id, name and whether it's focused. The popup renders that as a numbered list, reads your choice and calls `herdr agent rename <pane> <name>`. The shell helper just uses `$HERDR_PANE_ID`, which herdr sets in every pane's environment.

## Licence

MIT
