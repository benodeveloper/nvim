return {
    -- Add nvim-dap configuration for Java
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    table.insert(opts.ensure_installed, "java-debug-adapter")
                end,
            },
        },
        config = function()
            -- Just initialize dap without any server configurations
            local dap = require("dap")
            -- No need to configure adapters or connections for basic neotest usage
        end,
    },
    -- Override the existing neotest configuration
    {
        "nvim-neotest/neotest",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcasia/neotest-java",
        },
        opts = function(_, opts)
            opts.adapters = opts.adapters or {}
            table.insert(
                opts.adapters,
                require("neotest-java")({
                    ignore_wrapper = false,
                })
            )
            return opts
        end,
    },
}
-- return {
--     "nvim-neotest/neotest",
--     dependencies = {
--         "rcasia/neotest-java",
--     },
--     opts = function(_, opts)
--         table.insert(
--             opts.adapters,
--             require("neotest-java")({
--                 -- Optional configuration
--                 ignore_wrapper = false,
--             })
--         )
--     end,
-- }
