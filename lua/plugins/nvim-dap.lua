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
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		opts = {
			layouts = {
				-- {
				-- 	elements = {
				-- 		{
				-- 			id = "console",
				-- 			size = 1,
				-- 		},
				-- 	},
				-- 	position = "bottom",
				-- 	size = 4,
				-- },
				-- {
				-- 	elements = {
				-- 		{ id = "scopes", size = 0.5 },
				-- 		{ id = "breakpoints", size = 0.5 },
				-- 		-- { id = "stack", size = 0.5 },
				-- 	},
				-- 	position = "right",
				-- 	size = 30,
				-- },
			},
		},
	},
}
