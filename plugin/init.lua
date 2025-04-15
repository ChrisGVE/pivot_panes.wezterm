local wezterm = require("wezterm") --[[@as Wezterm]]

---@type { setup: fun(opts: table)}
local dev = wezterm.plugin.require("https://github.com/chrisgve/dev.wezterm")

local M = {}

local function init()
	local opts = {
		keywords = { "https", "github", "chrisgve", "pivot_pane", "wezterm" },
		auto = true,
	}
	dev.setup(opts)

	-- Set up the config first with defaults
	local config = require("config")
	M.config = config.setup({})

	-- Set up the pivot module with the config
	local pivot = require("pivot")
	M.pivot = pivot.setup(M.config)
end

init()

-- Configure the plugin with custom settings
---@param user_config PivotConfig
---@return table
function M.setup(user_config)
	local config = require("config")
	M.config = config.setup(user_config)

	-- Re-setup the pivot module with new config
	M.pivot = require("pivot").setup(M.config)

	return M
end

-- Callback function for keybindings
---@param window any WezTerm window object
---@param pane any WezTerm pane object
---@return boolean success
function M.toggle_orientation_callback(window, pane)
	return M.pivot.toggle_orientation(pane)
end

-- Directly toggle pane orientation
---@param tab_or_pane? any Optional tab or pane to use (defaults to current)
---@return boolean success
function M.toggle_orientation(tab_or_pane)
	return M.pivot.toggle_orientation(tab_or_pane)
end

return M
