--- A module to dynamically toggle individual dapui elements in a sidebar.
-- Requires nvim-dap-ui.
-- @module dapui_switcher
local M = {}

--- The currently active sidebar element.
-- @field active_sidebar_element string|nil
M.active_sidebar_element = nil

--- The default layout configuration for the sidebar.
-- @field default_sidebar_opts table
M.default_sidebar_opts = {
	position = "left",
	size = 50, -- Adjust size as needed
}

--- Toggles a specific nvim-dap-ui element in a sidebar.
-- If the specified element is already active, the sidebar is closed.
-- If the sidebar is closed or showing a different element,
-- it will be opened with the new element.
-- @param element_id string The ID of the dapui element to show (e.g., "scopes", "console").
-- @return nil
function M.toggle_sidebar_element(element_id)
	-- Ensure dapui is available
	local dapui_ok, dapui = pcall(require, "dapui")
	if not dapui_ok then
		vim.notify("nvim-dap-ui is not available.", vim.log.levels.ERROR)
		return
	end

	-- If the specified element is currently active, close the UI
	-- if M.active_sidebar_element == element_id then
	-- 	dapui.close("sidebar")
	-- 	M.active_sidebar_element = nil
	-- 	return
	-- end

	-- Update the active element state
	M.active_sidebar_element = element_id

	-- Reconfigure dapui with the new layout
	dapui.setup({
		layouts = {
			vim.tbl_extend("force", M.default_sidebar_opts, {
				elements = { element_id },
			}),
		},
	})

	-- Open the sidebar to show the new element
	dapui.open("sidebar")
end

return M
