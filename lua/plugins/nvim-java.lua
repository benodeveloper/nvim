return {
	"nvim-java/nvim-java",
	ft = { "java" },
	dependencies = {
		"nvim-java/lua-async-await",
		"nvim-java/nvim-java-refactor",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-dap",
		"MunifTanjim/nui.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"nvim-java/lua-async",
		"nvim-tree/nvim-web-devicons",
		{
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
	},
	config = function()
		require("java").setup()
		require("lspconfig").jdtls.setup({
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = "/usr/lib/jvm/java-21-openjdk-amd64",
								default = true,
							},
						},
					},
				},
			},
		})
	end,
}
-- return {
-- 	"mfussenegger/nvim-jdtls",
-- 	ft = "java",
-- 	dependencies = {
-- 		"mfussenegger/nvim-dap",
-- 	},
-- }
