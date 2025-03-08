return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascriptreact",
						"typescriptreact",
						"blade",
					},
				},
			},
		},
	},
}
