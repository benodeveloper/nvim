-- Move highlighted lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
