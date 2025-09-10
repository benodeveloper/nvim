return {
	{
		"mfussenegger/nvim-dap",
		-- optional = true,
		opts = function()
			-- Simple configuration to attach to remote java debug process
			-- Taken directly from https://github.com/mfussenegger/nvim-dap/wiki/Java
			local dap = require("dap")
			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}

			local dapuiUtil = require("util.dapui")
			-- Set up DAP listeners to change Lualine theme

			-- Theme turns orange when the debugger is fully initialized
			dap.listeners.after.event_initialized["lualine_theme"] = function()
				dapuiUtil.set_debug_theme()
			end

			-- Revert theme when you manually disconnect or terminate the session
			dap.listeners.before.disconnect["lualine_theme"] = function()
				dapuiUtil.restore_original_theme()
			end
			dap.listeners.before.terminate["lualine_theme"] = function()
				dapuiUtil.restore_original_theme()
			end

			-- Revert theme when the debugged program exits on its own
			dap.listeners.after.event_terminated["lualine_theme"] = function()
				dapuiUtil.restore_original_theme()
			end
			dap.listeners.after.event_exited["lualine_theme"] = function()
				dapuiUtil.restore_original_theme()
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "console",
							size = 1,
						},
					},
					position = "bottom",
					size = 4,
				},
				{
					elements = {
						{ id = "scopes", size = 0.3 },
						{ id = "breakpoints", size = 0.3 },
						{ id = "stack", size = 0.4 },
					},
					position = "right",
					size = 130,
				},
			},
		},
	},
}
