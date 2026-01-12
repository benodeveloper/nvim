-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Snacks Explorer" })

-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search text" })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List buffers" })
