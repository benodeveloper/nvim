return {
	{
		"navarasu/onedark.nvim",
		priority = 9000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#0E1116",
		},
	},
}
