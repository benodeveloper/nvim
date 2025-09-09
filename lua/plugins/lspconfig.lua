return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jdtls = {},
				intelephense = {},
			},
			setup = {
				jdtls = function()
					return true -- avoid duplicate servers
				end,
			},
		},
	},
}
