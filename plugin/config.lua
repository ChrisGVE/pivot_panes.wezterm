local wezterm = require("wezterm") --[[@as Wezterm]]
local lib = wezterm.plugin.require("https://github.com/chrisgve/lib.wezterm")

local M = {}

-- Default configuration
---@type PivotConfig
M.default_config = {
	-- Maximum number of scrollback lines to preserve (0 to disable)
	max_scrollback_lines = 1000,

	-- Table mapping application names to priority values
	-- Higher values indicate higher priority for preservation
	-- Apps not listed default to priority 1
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
		["btop"] = 5,
		["lazygit"] = 5,

		-- Low priority - complex applications with state that's hard to restore
		["vim"] = 3,
		["nvim"] = 3,
		["neovim"] = 3,
		["emacs"] = 2,
		["nano"] = 3,
	},

	-- List of process names that should be identified as shells
	shell_detection = {
		"bash",
		"zsh",
		"fish",
		"sh",
		"dash",
		"ksh",
		"csh",
		"tcsh",
	},

	-- Enable debug logging
	debug = false,
}

---@type PivotConfig
M.config = nil

-- Initialize configuration with defaults
---@param user_config PivotConfig|nil
---@return PivotConfig
function M.setup(user_config)
	if M.config == nil then
		M.config = lib.table.tbl_deep_extend("force", M.default_config, user_config or {})
	end
	return M.config
end

return M
