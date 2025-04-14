local wezterm = require("wezterm") --[[@as Wezterm]]
local lib = wezterm.plugin.require("https://github.com/chrisgve/lib.wezterm")

local M = {}

-- Get priority for a process name
---@param process_name string
---@param config PivotConfig
---@return number
function M.get_process_priority(process_name, config)
	return config.priority_apps[process_name:lower()] or 1
end

-- Capture scrollback buffer from a pane if enabled
---@param pane any
---@param config PivotConfig
---@return string|nil
function M.capture_scrollback(pane, config)
	if config.max_scrollback_lines <= 0 then
		return nil
	end
	
	return lib.wezterm.capture_scrollback(pane, config.max_scrollback_lines)
end

return M
