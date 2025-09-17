local boilerplate = require("util.boilerplate")

-- Create an autocommand group to ensure it's cleared on reload
local boilerplate_group = vim.api.nvim_create_augroup("FileBoilerplate", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufEnter" }, {
	group = boilerplate_group,
	-- ✅ Listen for both Java and PHP files
	pattern = { "*.java", "*.php", "*.tsx", "*.jsx" },
	-- ✅ Call the new, more generic function
	callback = boilerplate.setup_file_boilerplate,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function(args)
		local buf = args.buf

		-- Custom "organize imports"
		vim.keymap.set("n", "<leader>cao", function()
			require("util.phputils").sort_php_imports()
		end, { buffer = buf, desc = "Organize Imports (length)" })

		-- Align PHP arrays and assignments (visual mode only)
		vim.keymap.set("v", "<leader>cao", function()
			require("util.phputils").align_php_code()
		end, { buffer = buf, desc = "Align PHP code (= / =>)" })
	end,
})
