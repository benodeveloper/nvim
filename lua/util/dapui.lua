-- We will store the original theme to revert back to
local original_lualine_theme = nil

-- This is a utility function to create a deep copy of a table.
-- This is crucial so we don't accidentally change the original theme table.
local function deepcopy(orig)
	local copy = {}
	for k, v in pairs(orig) do
		if type(v) == "table" then
			v = deepcopy(v)
		end
		copy[k] = v
	end
	return copy
end

local M = {}

-- Function to set the debug theme
function M.set_debug_theme()
	-- If we're already in debug mode, do nothing
	if original_lualine_theme then
		return
	end

	-- 1. Get the onedark theme
	local onedark_theme = require("lualine.themes.onedark")
	-- 2. Store a copy of the original theme for later restoration
	original_lualine_theme = onedark_theme

	-- 3. Create a new theme by deep-copying the original
	local debug_theme = deepcopy(original_lualine_theme)
	local debug_orange = "#7A3B10" -- A nice, readable orange.

	debug_theme.normal.c.bg = debug_orange
	-- debug_theme.insert.c.bg = debug_orange
	-- debug_theme.visual.c.bg = debug_orange
	-- debug_theme.command.c.bg = debug_orange
	-- debug_theme.replace.c.bg = debug_orange
	-- debug_theme.inactive.c.bg = "#7A3B10" -- A darker bg for inactive windows

	-- 6. Apply the newly modified theme
	require("lualine").setup({
		options = {
			theme = debug_theme,
		},
	})
end

-- Function to restore the original theme
function M.restore_original_theme()
	if original_lualine_theme then
		require("lualine").setup({
			options = {
				theme = original_lualine_theme,
			},
		})
		original_lualine_theme = nil
	end
end

return M
