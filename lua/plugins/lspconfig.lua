return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                emmet_language_server = {
                    filetypes = {
                        "html",
                        "blade",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "javascript",
                        "typescript",
                        "markdown",
                    },
                },
                intelephense = {},
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
