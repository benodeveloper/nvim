local boilerplate = require("utils.boilerplate")

-- Create an autocommand group to ensure it's cleared on reload
local boilerplate_group = vim.api.nvim_create_augroup("FileBoilerplate", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufEnter" }, {
    group = boilerplate_group,
    -- ✅ Listen for both Java and PHP files
    pattern = { "*.java", "*.php", "*.tsx", "*.jsx" },
    -- ✅ Call the new, more generic function
    callback = boilerplate.setup_file_boilerplate,
})
