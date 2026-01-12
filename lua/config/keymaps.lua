local map = vim.keymap.set

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Snacks Navigation
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Project" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- Snacks Find Group
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })

-- Snacks Git
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff" })

-- Snacks Utils
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map({ "n", "t" }, "<C-/>", function() Snacks.terminal.toggle() end, { desc = "Toggle Terminal" })
map({ "n", "t" }, "<C-_>", function() Snacks.terminal.toggle() end, { desc = "Toggle Terminal" })

-- Open Lazygit
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
-- Search git log (using Snacks Picker)
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })

-- Smart Reload
map("n", "<leader>rl", function()
    for name, _ in pairs(package.loaded) do
        if name:match("^options") or name:match("^keymaps") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload config" })
