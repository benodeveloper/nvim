local tests = require("utils.tests")

-- Move highlighted lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>ct", function()
    tests.create_test_file()
end, { desc = "[C]reate [T]est file" })
