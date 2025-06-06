---@class PaneState
---@field command string Command running in the pane
---@field args string[] Command arguments
---@field cwd string Current working directory
---@field is_shell boolean Whether the pane is running a shell
---@field process_name string Name of the process running in the pane
---@field priority number Process priority for restoration (higher means higher priority)
---@field scrollback string|nil Captured scrollback content if available

---@class PivotConfig
---@field max_scrollback_lines number Maximum number of scrollback lines to preserve (0 to disable)
---@field priority_apps table<string, number> Table mapping application names to priority values
---@field shell_detection string[] List of shell names to identify shell panes
---@field debug boolean Enable debug logging
