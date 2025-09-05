local tests = require("utils.tests")

-- Move highlighted lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "<leader>tf", function()
--     tests.run_gradle_test("file")
-- end, { desc = "Run [T]est [F]ile" })

vim.keymap.set("n", "<leader>ct", function()
    tests.create_test_file()
end, { desc = "[C]reate [T]est file" })

-- Run the specific test function under the cursor
-- vim.keymap.set("n", "<leader>tt", function()
--     tests.run_gradle_test("function")
-- end, { desc = "Run [T]his [T]est function" })

-- nvim-dap
vim.keymap.set(
    "n",
    "<leader>dB",
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    { desc = "Add Conditional Breakpoint" }
)
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Dap Continue" })
vim.keymap.set("n", "<leader>dsi", "<cmd>DapStepInto<CR>", { desc = "Dap Step Into" })
vim.keymap.set("n", "<leader>dso", "<cmd>DapStepOver<CR>", { desc = "Dap Step Over" })
vim.keymap.set("n", "<leader>dst", "<cmd>DapStepOut<CR>", { desc = "Dap Step Out" })
vim.keymap.set("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "Dap Terminate" })
vim.keymap.set("n", "<leader>dl", "<cmd>DapShowLog<CR>", { desc = "Dap Show Log" })
vim.keymap.set("n", "<leader>dr", "<cmd>DapToggleRepl<CR>", { desc = "Dap Toggle Repl" })

-- noice.nvim
vim.keymap.set("n", "<space>nn", "<cmd>Noice<cr>", { desc = "Noice Messages" })
vim.keymap.set("n", "<space>na", "<cmd>NoiceAll<cr>", { desc = "Noice All Messages" })
vim.keymap.set("n", "<space>nl", "<cmd>NoiceLast<cr>", { desc = "Noice Last" })
vim.keymap.set("n", "<space>ne", "<cmd>NoiceErrors<cr>", { desc = "Noice Errors" })

vim.keymap.set("n", "<space>ns", function()
    require("noice").redirect("Notifications")
end, { desc = "Noice Notifications" })
