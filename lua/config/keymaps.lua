local map = vim.keymap.set

-- Window Splitting
map("n", "<leader>|", ":vsplit<CR>", { desc = "Split window right" })
map("n", "<leader>-", ":split<CR>", { desc = "Split window below" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Snacks Navigation
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "H", ":bprevious<CR>", { desc = "Next Buffer" })
map("n", "L", ":bnext<CR>", { desc = "Previous Buffer" })
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
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
-- Search git log (using Snacks Picker)
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })

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

-- LSP Code Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- LSP Navigation (using Snacks.picker)
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
map("n", "gp", function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
    if result == nil or vim.tbl_isempty(result) then return end
    vim.lsp.util.preview_location(result[1], { border = "rounded" })
  end)
end, { desc = "Peek Definition" })

-- Drafts / Scratchpads
map("n", "<leader>ds", function() Snacks.scratch() end, { desc = "Toggle Scratchpad" })
map("n", "<leader>dl", function() Snacks.scratch.select() end, { desc = "Select Scratchpad" })

-- Manual Format File 
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Code" })
