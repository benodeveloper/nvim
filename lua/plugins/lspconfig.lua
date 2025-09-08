return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jdtls = {
                    -- Explicitly set workspace directory
                    cmd = {
                        "jdtls",
                        "--jvm-arg=-Dfile.encoding=UTF-8",
                        "-data",
                        vim.fn.expand("~/.cache/nvim/jdtls/workspace")
                            .. "/"
                            .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
                    },
                    settings = {
                        java = {
                            configuration = {
                                updateBuildConfiguration = "interactive",
                            },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.junit.Assert.*",
                                    "org.junit.Assume.*",
                                    "org.junit.jupiter.api.Assertions.*",
                                    "org.junit.jupiter.api.Assumptions.*",
                                    "org.junit.jupiter.api.DynamicContainer.*",
                                    "org.junit.jupiter.api.DynamicTest.*",
                                },
                            },
                        },
                    },
                },

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
