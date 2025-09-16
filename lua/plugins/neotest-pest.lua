return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"V13Axel/neotest-pest",
	},

	ft = "php",
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-pest"),
			},
		})
	end,
}
