-- Run Java test under cursor
vim.keymap.set("n", "<leader>jt", function()
	require("java").test.run_current_method()
end, { desc = "Run Java test" })

-- Run all Java tests in file
vim.keymap.set("n", "<leader>jT", function()
	require("java").test.debug_current_class()
end, { desc = "Run for the current class" })
