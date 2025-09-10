local keymaps = require("lazyvim.plugins.lsp.keymaps")
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"igorlfs/nvim-dap-view",
		},
		-- optional = true,
		opts = function()
			-- Simple configuration to attach to remote java debug process
			-- Taken directly from https://github.com/mfussenegger/nvim-dap/wiki/Java
			local dap = require("dap")
			local ok, dapview = pcall(require, "dap-view")
			local dapuiUtil = require("util.dapui")
			local keymap = vim.keymap.set
			local last_run = nil

			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}

			-- Store the config for 'dap.last_run()'
			dap.listeners.after.event_initialized["store_config"] = function(session)
				if session.config then
					last_run = {
						config = session.config,
					}
				end
			end

			-- Reimplement last_run to store the config
			-- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
			local function dap_run_last()
				if last_run and last_run.config then
					dap.run(last_run.config)
				else
					dap.continue()
				end
			end

			keymap({ "n", "v" }, "<F3>", "<cmd>DapViewToggle <CR>", { silent = true, desc = "DAP toggle UI" })
			keymap(
				{ "n", "v" },
				"<F4>",
				"<cmd>lua require('dap').pause()<CR>",
				{ silent = true, desc = "DAP pause (thread)" }
			)
			keymap(
				{ "n", "v" },
				"<F5>",
				"<cmd>lua require('dap').continue()<CR>",
				{ silent = true, desc = "DAP launch or continue" }
			)
			keymap(
				{ "n", "v" },
				"<F6>",
				"<cmd>lua require('dap').step_into()<CR>",
				{ silent = true, desc = "DAP step into" }
			)
			keymap(
				{ "n", "v" },
				"<F7>",
				"<cmd>lua require('dap').step_over()<CR>",
				{ silent = true, desc = "DAP step over" }
			)
			keymap(
				{ "n", "v" },
				"<F8>",
				"<cmd>lua require('dap').step_out()<CR>",
				{ silent = true, desc = "DAP step out" }
			)
			keymap(
				{ "n", "v" },
				"<F9>",
				"<cmd>lua require('dap').step_back()<CR>",
				{ silent = true, desc = "DAP step back" }
			)
			keymap({ "n", "v" }, "<F10>", function()
				dap_run_last()
			end, { silent = true, desc = "DAP run last" })
			-- F11 is used by KDE for fullscreen
			keymap(
				{ "n", "v" },
				"<F12>",
				"<cmd>lua require('dap').terminate()<CR>",
				{ silent = true, desc = "DAP terminate" }
			)
			keymap(
				{ "n", "v" },
				"<leader>dd",
				"<cmd>lua require('dap').disconnect({ terminateDebuggee = false })<CR>",
				{ silent = true, desc = "DAP disconnect" }
			)
			keymap(
				{ "n", "v" },
				"<leader>dt",
				"<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<CR>",
				{ silent = true, desc = "DAP disconnect and terminate" }
			)
			keymap(
				{ "n", "v" },
				"<leader>db",
				"<cmd>lua require('dap').toggle_breakpoint()<CR>",
				{ silent = true, desc = "DAP toggle breakpoint" }
			)
			keymap(
				{ "n", "v" },
				"<leader>dB",
				"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				{ silent = true, desc = "DAP set breakpoint with condition" }
			)
			keymap(
				{ "n", "v" },
				"<leader>dp",
				"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				{ silent = true, desc = "DAP set breakpoint with log point message" }
			)

			dapview.setup({
				winbar = {
					show = true,
					sections = {
						"watches",
						"scopes",
						"exceptions",
						"breakpoints",
						"threads",
						"repl",
						"console",
					},
					default_section = "watches",
					controls = {
						enabled = true,
					},
				},
				icons = {
					disabled = "",
					disconnect = " (<l>d)",
					enabled = "",
					filter = "󰈲",
					negate = " ",
					pause = "",
					play = " (F5)",
					run_last = " (F10)",
					step_back = " (F9)",
					step_into = " (F6)",
					step_out = " (F8)",
					step_over = " (F7)",
					terminate = " (F12)",
				},
			})
			dap.listeners.after.event_initialized["dap-view-config"] = dapview.open
			dap.listeners.before.event_terminated["dap-view-config"] = function(e)
				print(string.format("program '%s' was terminated.", vim.fn.fnamemodify(e.config.program, ":t")))
				dapview.close()
			end

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

			vim.fn.sign_define("DapBreakpoint", { text = "🔴" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟡" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "⭕" })
			vim.fn.sign_define("DapStopped", {
				text = "󰫎",
				texthl = "DapStoppedText",
				linehl = "DapStoppedLine",
				numhl = "",
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		enabled = false,
	},
}
