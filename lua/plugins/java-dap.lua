return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        -- Automatically open/close the UI when debugging starts/stops
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Standard debugging keymaps
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    end,
}
