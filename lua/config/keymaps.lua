-- Move highlighted lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
local tests = require("utils.tests")

-- Run tests for the current file
vim.keymap.set("n", "<leader>tf", function()
    tests.run_gradle_test("file")
end, { desc = "Run [T]est [F]ile" })

vim.keymap.set("n", "<leader>ct", function()
    tests.create_test_file()
end, { desc = "[C]reate [T]est file" })

-- Run the specific test function under the cursor
vim.keymap.set("n", "<leader>tt", function()
    tests.run_gradle_test("function")
end, { desc = "Run [T]his [T]est function" })

-- Define the keymaps for visual mode
vim.keymap.set("v", "<leader>sc", function()
    require("nvim-silicon").clip()
end, { desc = "Copy code screenshot to clipboard" })
vim.keymap.set("v", "<leader>sf", function()
    require("nvim-silicon").file()
end, { desc = "Save code screenshot as file" })
vim.keymap.set("v", "<leader>ss", function()
    require("nvim-silicon").shoot()
end, { desc = "Create code screenshot" })
