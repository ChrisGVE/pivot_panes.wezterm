# pivot-pane.wezterm

A WezTerm plugin to toggle pane orientation between horizontal and vertical splits.

## Features

- Toggle pane orientation with a single keystroke
- Intelligently preserves shell state during orientation change
- Prioritizes applications based on their ability to be restored
- Configurable scrollback preservation (optional)
- Works with adjacent panes regardless of their content

## Installation

Add the plugin to your WezTerm configuration:

```lua
local wezterm = require("wezterm")
local config = {}

-- Add the plugin
local pivot_pane = wezterm.plugin.require("https://github.com/chrisgve/pivot-pane.wezterm")

-- Add keybinding
config.keys = {
  -- Other key assignments...
  {
    key = "p", 
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action_callback(pivot_pane.toggle_orientation_callback),
  },
}

-- Optional: Configure the plugin
pivot_pane.setup({
  max_scrollback_lines = 1000,
  debug = false,
  priority_apps = {
    -- Custom application priorities
    ["less"] = 5,
    ["nvim"] = 3,
  },
})

return config
```

## Usage

1. Create a split pane (horizontal or vertical)
2. With the pane active, press the configured shortcut (e.g., CTRL+SHIFT+ALT+P)
3. The pane orientation will toggle between horizontal and vertical

## Configuration Options

```lua
{
  -- Maximum number of scrollback lines to preserve (0 to disable)
  max_scrollback_lines = 1000,
  
  -- Table mapping application names to priority values
  -- Higher values indicate higher priority for preservation
  priority_apps = {
    -- Shells have highest priority - easiest to restore
    ["bash"] = 10,
    ["zsh"] = 10,
    ["fish"] = 10,
    
    -- Medium priority - state might be partially preserved
    ["less"] = 5,
    ["man"] = 5,
    ["top"] = 5,
    ["htop"] = 5,
    
    -- Low priority - complex applications with state that's hard to restore
    ["vim"] = 3,
    ["nvim"] = 3,
    ["neovim"] = 3,
    ["emacs"] = 2,
    ["nano"] = 3,
  },
  
  -- List of process names that should be identified as shells
  shell_detection = {
    "bash", "zsh", "fish", "sh", "dash", "ksh", "csh", "tcsh"
  },
  
  -- Enable debug logging
  debug = false,
}
```

## API

The plugin exposes the following functions:

```lua
-- Configure the plugin with custom settings
pivot_pane.setup(config_table)

-- Callback function for use with wezterm.action_callback() in keybindings
pivot_pane.toggle_orientation_callback(window, pane)

-- Direct function to toggle orientation of a specific pane or tab
-- If no argument is provided, uses the current active pane
pivot_pane.toggle_orientation(tab_or_pane)
```

## How it Works

The plugin:

1. Identifies adjacent panes and their current orientation
2. Captures the state of each pane (process, working directory, etc.)
3. Determines the priority of each pane based on its content
4. Closes one pane and recreates it with the opposite orientation
5. Restores the state to both panes based on priority

## Limitations

- Full application state cannot be preserved for complex applications
- Currently only works with pairs of panes (not complex layouts)
- Scrollback preservation is limited by WezTerm's API capabilities

## License

MIT
