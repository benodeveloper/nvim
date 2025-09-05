local util = require("conform.util")
return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",

    keys = {
        {
            "<leader>cF",
            function()
                require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },

    init = function()
        -- Install the conform formatter on VeryLazy
        LazyVim.on_very_lazy(function()
            LazyVim.format.register({
                name = "conform.nvim",
                priority = 100,
                primary = true,
                format = function(buf)
                    require("conform").format({ bufnr = buf })
                end,
                sources = function(buf)
                    local ret = require("conform").list_formatters(buf)
                    ---@param v conform.FormatterInfo
                    return vim.tbl_map(function(v)
                        return v.name
                    end, ret)
                end,
            })
        end)
    end,

    opts = function()
        ---@type conform.setupOpts
        local opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
                lsp_format = "fallback", -- not recommended to change
            },
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
                java = { "google-java-format" },
                php = { "pint" },
                blade = { "blade-formatter" },
                javascript = { "prettierd" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
            },
            -- The options you set here will be merged with the builtin formatters.
            -- You can also define any custom formatters here.
            ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
            formatters = {
                injected = { options = { ignore_errors = true } },

                ["blade-formatter"] = {
                    command = "blade-formatter",
                    args = {
                        "--write",
                        "$FILENAME",
                        "--wrap-line-length",
                        "9999",
                        "--wrap-attributes",
                        "preserve-aligned",
                    },
                    cwd = util.root_file({
                        ".editorconfig",
                        "composer.json",
                        "package.json",
                    }),
                    stdin = false,
                },
            },

            pint = {
                meta = {
                    url = "https://github.com/laravel/pint",
                    description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
                },
                command = util.find_executable({
                    vim.fn.stdpath("data") .. "/mason/bin/pint",
                    "vendor/bin/pint",
                }, "pint"),
                args = { "$FILENAME" },
                stdin = false,
            },
        }
        return opts
    end,
}
